//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 FD - Floating Point Double

 # Definition
 Double precision binary floating point number represented in IEEE 754:1985 64-bit Floating Point Number Format.

 # Character Reportoire
 not applicable

 # Length of value
 8 bytes fixed
 */
public class DicomDataElementFD: DicomDataElement {

    let value: Float64?

    init(tag: DicomTag, value: Data?) {
        if let rawValue = value {
//            self.value = rawValue.withUnsafeBytes { (pointer: UnsafePointer<Float64>) in pointer.pointee }
            self.value = rawValue.withUnsafeBytes { $0.load(as: Float64.self) }
        } else {
            self.value = nil
        }
        super.init(tag: tag, vr: .FD, length: 8, value: value)
    }

    override public var stringValue: String? {
        guard let value = self.value else {
            return nil
        }
        return String(format: "%f", value)
    }
}
