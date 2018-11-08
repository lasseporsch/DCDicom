//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation


public class DicomDataElement: CustomStringConvertible, CustomDebugStringConvertible {
    public let tag: DicomTag
    public let vr: DicomVR?
    public let length: UInt32
    public let rawValue: Data?

    public var stringValue: String? {
        return nil
    }

    private static var byteFormatter: ByteCountFormatter {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .memory
        return formatter
    }

    public static func make(tag: DicomTag, explicitVR: String?, length: UInt32, value: Data?) -> DicomDataElement {
        guard let explicitVR = explicitVR, let explicitDicomVR = DicomVR(rawValue: explicitVR) else {
            return DicomDataElement(tag: tag, vr: nil, length: length, value: value)
        }

        switch explicitDicomVR {
        case .AE: return DicomDataElementAE(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .AS: return DicomDataElementAS(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .AT: return DicomDataElementAT(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .CS: return DicomDataElementCS(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .DA: return DicomDataElementDA(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .DS: return DicomDataElementDS(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .DT: return DicomDataElementDT(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .FL: return DicomDataElementFL(tag: tag, value: value)
        case .FD: return DicomDataElementFD(tag: tag, value: value)
        case .IS: return DicomDataElementIS(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .LO: return DicomDataElementLO(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .LT: return DicomDataElementLT(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .OB: return DicomDataElementOB(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .OD: return DicomDataElementOD(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .OF: return DicomDataElementOF(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .OL: return DicomDataElementOL(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .OW: return DicomDataElementOW(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .PN: return DicomDataElementPN(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .SH: return DicomDataElementSH(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .SL: return DicomDataElementSL(tag: tag, value: value)
        case .SQ: return DicomDataElementSQ(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .SS: return DicomDataElementSS(tag: tag, value: value)
        case .ST: return DicomDataElementST(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .TM: return DicomDataElementTM(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .UC: return DicomDataElementUC(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .UI: return DicomDataElementUI(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .UL: return DicomDataElementUL(tag: tag, value: value)
        case .UN: return DicomDataElementUN(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .UR: return DicomDataElementUR(tag: tag, vr: explicitDicomVR, length: length, value: value)
        case .US: return DicomDataElementUS(tag: tag, value: value)
        case .UT: return DicomDataElementUT(tag: tag, vr: explicitDicomVR, length: length, value: value)
        }
    }

    public init(tag: DicomTag, vr: DicomVR?, length: UInt32, value: Data?) {
        self.tag = tag
        self.vr = vr
        self.length = length
        self.rawValue = value
    }

    public var description: String {
        let tag = String(describing: self.tag)
        let vr = self.vr != nil ? String(describing: self.vr!) : "--"
        let length = DicomDataElement.byteFormatter.string(fromByteCount: Int64(self.length)).padding(toLength: 10, withPad: " ", startingAt: 0)
        if let stringValue = self.stringValue {
            return String(format: "%@ [%@, %@]: %@", tag, vr, length, stringValue)
        } else {
            return String(format: "%@ [%@, %@]", tag, vr, length)
        }
    }
    public var debugDescription: String {
        let tag = String(reflecting: self.tag)
        let vr = self.vr != nil ? String(reflecting: self.vr!) : "--"
        let length = DicomDataElement.byteFormatter.string(fromByteCount: Int64(self.length)).padding(toLength: 10, withPad: " ", startingAt: 0)
        if let stringValue = self.stringValue {
            return String(format: "%@ [%@, %@]: %@", tag, vr, length, stringValue)
        } else {
            return String(format: "%@ [%@, %@]", tag, vr, length)
        }
    }
}
