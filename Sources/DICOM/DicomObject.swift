//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

public class DicomObject {

    public private(set) var dataElements: [DicomDataElement] = []

    private(set) var transferSyntax = DicomTransferSyntax.defaultTransferSyntax

    public convenience init(url: URL) throws {
        guard let inputStream = InputStream(url: url) else {
            throw DicomError.couldNotOpenFile
        }

        try self.init(inputStream: inputStream)
    }
    public convenience init(data: Data) throws {
        try self.init(inputStream: InputStream(data: data))
    }
    public init(inputStream: InputStream) throws {
        inputStream.open()

        do {
            let _: String = try inputStream.read(size: 128) // Preamble
            let prefix: String = try inputStream.read(size: 4) // Prefix
            guard prefix == "DICM" else {
                throw DicomError.invalidPrefix(prefix)
            }

            self.dataElements = try self.readDataElements(from: inputStream)
            inputStream.close()
        } catch {
            inputStream.close()
            throw error
        }
    }
}

public extension DicomObject {
    subscript(tag: DicomTag) -> DicomDataElement? {
        get {
            return self.dataElements.filter { element in element.tag == tag }.first
        }
    }
}


// MARK: - Reading Data Elements
extension DicomObject {
    private func readDataElements(from inputStream: InputStream) throws -> [DicomDataElement] {
        var elements: [DicomDataElement] = []

        var stop = false
        while !stop {
            guard let tag: DicomTag = try? inputStream.read() else {
                stop = true
                continue
            }

            switch tag {
            case 0xFFFCFFFC:
                // This is the "Data Set Trailing Padding". With this we have read everything and can stop now
                stop = true
                continue
            case 0xFFFEE00D:
                // This is the "Item Delimitation Item". With this we have read all elements of a sequence item and can stop now
                let _: UInt32 = try inputStream.read(size: 4) // Read dummy length
                stop = true
                continue
            default:
                let element = try self.readNextDataElement(for: tag, from: inputStream)

                // If this is (0002,0010), then we set our Transfer Syntax accordingly
                if element.tag == 0x00020010 {
                    guard let transferSyntaxUid = element.stringValue else {
                        throw DicomError.emptyTransferSyntax
                    }
                    guard let transferSyntax = DicomTransferSyntax.with(uid: transferSyntaxUid) else {
                        throw DicomError.unknownTransferSyntax
                    }
                    self.transferSyntax = transferSyntax
                }
                elements.append(element)
            }
        }
        return elements
    }
    private func readNextDataElement(for tag: DicomTag, from inputStream: InputStream) throws -> DicomDataElement {

        var dataElement: DicomDataElement
        let group = UInt16(tag >> 16)
        if self.transferSyntax.explicitVR || group == 0x0002 || group == 0x0004 {
            // We can expect an explicit VR
            let valueRepresentation: String = try inputStream.read(size: 2)

            switch valueRepresentation {
            case "OB", "OD", "OF", "OL", "OW", "UN", "UC", "UR", "UT":
                let reserved: UInt16 = try inputStream.read(size: 2) // reserved unused 2 bytes
                guard reserved == 0x0000 else {
                    throw DicomError.invalidDataElement
                }
                let valueSize: UInt32 = try inputStream.read(size: 4)
                switch valueSize {
                case 0x00000000:
                    dataElement = DicomDataElement.make(tag: tag, explicitVR: valueRepresentation, length: valueSize, value: nil)
                case 0xFFFFFFFF:
                    guard tag == 0x7FE00010 else {
                        throw DicomError.invalidUseOfUndefinedLength
                    }
                    dataElement = DicomDataElement.make(tag: tag, explicitVR: valueRepresentation, length: valueSize, value: nil)
                    try self.readPixelData(from: inputStream, into: dataElement as! DicomDataElementPixelData)

                default:
                    let value: Data = try inputStream.read(size: valueSize)
                    dataElement = DicomDataElement.make(tag: tag, explicitVR: valueRepresentation, length: valueSize, value: value)
                }

            case "SQ":
                let _: UInt16 = try inputStream.read(size: 2) // reserved unused 2 bytes
                let valueSize: UInt32 = try inputStream.read(size: 4)
                dataElement = DicomDataElement.make(tag: tag, explicitVR: valueRepresentation, length: valueSize, value: nil)
                try self.readSequence(from: inputStream, into: dataElement as! DicomDataElementSQ, length: valueSize)

            default:
                let valueSize16: UInt16 = try inputStream.read(size: 2)
                let valueSize: UInt32 = UInt32(valueSize16)
                var value: Data?
                if valueSize > 0 {
                    let data: Data = try inputStream.read(size: valueSize)
                    value = data
                }
                dataElement = DicomDataElement.make(tag: tag, explicitVR: valueRepresentation, length: valueSize, value: value)
            }
        } else {
            let valueSize: UInt32 = try inputStream.read(size: 4)
            switch valueSize {
            case 0xFFFFFFFF, 0x00000000:
                dataElement = DicomDataElement.make(tag: tag, explicitVR: "SQ", length: valueSize, value: nil)
                try self.readSequence(from: inputStream, into: dataElement as! DicomDataElementSQ, length: valueSize)

            default:
                var value: Data?
                if valueSize > 0 {
                    let data: Data = try inputStream.read(size: valueSize)
                    value = data
                }
                dataElement = DicomDataElement.make(tag: tag, explicitVR: nil, length: valueSize, value: value)
            }
        }
        return dataElement
    }
}

// Mark: - Reading Pixeldata fragments
extension DicomObject {
    private func readPixelData(from inputStream: InputStream, into pixelDataElement: DicomDataElementPixelData) throws {

        // We read all items, one after the other, until we hit the sequence delimeter tag
        var stop = false
        while !stop {
            let tag: DicomTag = try inputStream.read()
            let length: UInt32 = try inputStream.read(size: 4)

            if tag == 0xFFFEE0DD {
                stop = true
                continue
            }

            var value: Data?
            if length > 0 {
                let data: Data = try inputStream.read(size: length)
                value = data
            }
            pixelDataElement.add(DicomPixelDataItem(tag: tag, length: length, rawValue: value))
        }
    }
}


// MARK: - Reading Sequences and Sequence Items
extension DicomObject {
    private func readSequence(from inputStream: InputStream, into sequence: DicomDataElementSQ, length: UInt32) throws {
        var sequenceInputStream: InputStream
        var usesexplicitLengthInputStream = false

        switch length {
        case 0xFFFFFFFF: // this is a delimited sequence
            sequenceInputStream = inputStream
        case 0x00000000: // this sequence contains no items
            return
        default: // this sequence has an explicit length - we don't support this at the moment
            usesexplicitLengthInputStream = true
            let sequenceData: Data = try inputStream.read(size: length)
            sequenceInputStream = InputStream(data: sequenceData)
            sequenceInputStream.open()
        }

        do {
            var stop = false
            while !stop {
                if usesexplicitLengthInputStream && !sequenceInputStream.hasBytesAvailable {
                    stop = true
                    continue
                }
                let tag: DicomTag = try sequenceInputStream.read()
                switch tag {
                case 0xFFFEE000: // Begin Sequence Item
                    let item = DicomSequenceItem()
                    sequence.add(item)
                    try self.readSequenceItem(from: sequenceInputStream, into: item)
                case 0xFFFEE0DD: // End Sequence
                    let _: UInt32 = try sequenceInputStream.read(size: 4) // Read dummy length
                    stop = true
                    continue
                default:
                    throw DicomError.invalidSequenceTag
                }
            }
        } catch {
            if usesexplicitLengthInputStream {
                sequenceInputStream.close()
            }
            throw error
        }
    }
    private func readSequenceItem(from inputStream: InputStream, into sequenceItem: DicomSequenceItem) throws {
        let length: UInt32 = try inputStream.read(size: 4)
        let isDelimited = length == 0xFFFFFFFF
        guard isDelimited else {
            throw DicomError.undelimitedSequenceItemsNotSupported
        }
        try self.readDataElements(from: inputStream).forEach {
            sequenceItem.add($0)
        }
    }
}

private extension InputStream {
    func read<T>(size: UInt32) throws -> T {
        let requestedSize = Int(size)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: requestedSize)
        let actualSize = self.read(buffer, maxLength: requestedSize)
        guard actualSize == requestedSize else {
            throw DicomError.invalidDataElement
        }
        return UnsafeRawPointer(buffer).load(as: T.self)
    }
    func read() throws -> DicomTag {
        let group: UInt16 = try self.read(size: 2)
        let element: UInt16 = try self.read(size: 2)
        let group32: UInt32 = UInt32(group) << 16
        let element32: UInt32 = UInt32(element)
        let value: DicomTag = group32 | element32
        return value
    }

    func read(size: UInt32) throws -> String {
        let requestedSize = Int(size)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: requestedSize)
        let actualSize = self.read(buffer, maxLength: requestedSize)
        guard actualSize == requestedSize else {
            throw DicomError.invalidDataElement
        }
        return String(cString: buffer)
    }
    func read(size: UInt32) throws -> Data {
        let requestedSize = Int(size)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: requestedSize)
        let actualSize = self.read(buffer, maxLength: requestedSize)
        guard actualSize == requestedSize else {
            throw DicomError.invalidDataElement
        }

        return Data(UnsafeBufferPointer(start: buffer, count: requestedSize))
    }
}
