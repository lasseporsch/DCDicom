//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 UL - Unsigned Long

 # Definition
 Unsigned binary integer 32 bits long. Represents an integer n in the range:

 0 <= n < 2^32.

 # Character Reportoire
 not applicable

 # Length of value
 4 bytes fixed
 */
public class DicomDataElementUL: DicomDataElement {

    let value: UInt32?

    init(tag: DicomTag, value: Data?) {
        if let rawValue = value {
//            self.value = rawValue.withUnsafeBytes { (pointer: UnsafePointer<UInt32>) in pointer.pointee }
            self.value = rawValue.withUnsafeBytes { $0.load(as: UInt32.self) }
        } else {
            self.value = nil
        }
        super.init(tag: tag, vr: .UL, length: 4, value: value)
    }

    override public var stringValue: String? {
        guard let value = self.value else {
            return nil
        }
        return String(format: "%d", value)
    }
}
