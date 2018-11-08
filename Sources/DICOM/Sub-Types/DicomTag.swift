//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

public enum DicomTagClass {
    case fileMetaInformation
    case directoryStructure
    case dataElement
}

public typealias DicomTag = UInt32

extension DicomTag: CustomDebugStringConvertible {
    public var debugDescription: String {
        let group = UInt16(self >> 16)
        let element = UInt16(((self << 16) >> 16))
        return String(format: "(%04X,%04X)", group, element)
    }
    public var description: String {
        let group = UInt16(self >> 16)
        let element = UInt16(((self << 16) >> 16))
        return String(format: "(%04X,%04X)", group, element)
    }
}


//class DicomTag {
//    let group: UInt16
//    let element: UInt16
//    let name: String
//    let implicitVR: DicomVR?
//    let 
//    let tagClass: DicomTagClass
//
//    init(_ group: UInt16, _ element: UInt16) {
//        self.group = group
//        self.element = element
//        switch group {
//        case 0x0002: self.tagClass = .fileMetaInformation
//        case 0x0004: self.tagClass = .directoryStructure
//        default: self.tagClass = .dataElement
//        }
//        self.implicitVR = nil
//    }
//}
