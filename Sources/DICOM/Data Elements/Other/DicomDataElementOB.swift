//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 OB - Other Byte

 # Definition
 A string of bytes where the encoding of the contents is specified by the negotiated Transfer Syntax.
 OB is a VR that is insensitive to Little/Big Endian byte ordering (see Section 7.3).
 The string of bytes shall be padded with a single trailing NULL byte value (00H) when necessary to achieve even length.

 # Character Reportoire
 not applicable

 # Length of value
 see Transfer Syntax definition
 */
public class DicomDataElementOB: DicomDataElement, DicomDataElementPixelData {
    public private(set) var pixelDataItems: [DicomPixelDataItem] = []

    public func add(_ item: DicomPixelDataItem) {
        self.pixelDataItems.append(item)
    }

    override public var stringValue: String? {
        if self.tag == 0x7FE00010 && self.length == 0xFFFFFFFF && self.pixelDataItems.count >= 2 {
            let offsetTableSize = self.pixelDataItems.first!.rawValue?.count ?? 0
            let numberOfFrames = offsetTableSize / 4
            return String(format: "Pixeldata with %d frames", numberOfFrames)
        } else {
            return super.stringValue
        }
    }
}


public class DicomPixelDataItem {
    public let tag: DicomTag
    public let length: UInt32
    public let rawValue: Data?

    init(tag: DicomTag, length: UInt32, rawValue: Data?) {
        self.tag = tag
        self.length = length
        self.rawValue = rawValue
    }
}

public protocol DicomDataElementPixelData {
    var pixelDataItems: [DicomPixelDataItem] { get }

    func add(_ item: DicomPixelDataItem)
}
