//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 SL - Signed Long

 # Definition
 Signed binary integer 32 bits long in 2's complement form.

 Represents an integer, n, in the range:

 - 2^31<= n <= 2^^31-1.

 # Character Reportoire
 not applicable

 # Length of value
 4 bytes fixed
 */
public class DicomDataElementSL: DicomDataElement {

    let value: Int32?

    init(tag: DicomTag, value: Data?) {
        if let rawValue = value {
//            self.value = rawValue.withUnsafeBytes { (pointer: UnsafePointer<Int32>) in pointer.pointee }
            self.value = rawValue.withUnsafeBytes { $0.load(as: Int32.self) }
        } else {
            self.value = nil
        }
        super.init(tag: tag, vr: .SL, length: 4, value: value)
    }

    override public var stringValue: String? {
        guard let value = self.value else {
            return nil
        }
        return String(format: "%d", value)
    }
}
