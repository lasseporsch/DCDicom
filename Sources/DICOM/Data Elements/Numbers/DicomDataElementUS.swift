//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 US - Unsigned Short

 # Definition
 Unsigned binary integer 16 bits long. Represents integer n in the range:

 0 <= n < 2^16.

 # Character Reportoire
 not applicable

 # Length of value
 2 bytes fixed
 */
public class DicomDataElementUS: DicomDataElement {

    let value: UInt16?

    init(tag: DicomTag, value: Data?) {
        if let rawValue = value {
//            self.value = rawValue.withUnsafeBytes { (pointer: UnsafePointer<UInt16>) in pointer.pointee }
            self.value = rawValue.withUnsafeBytes { $0.load(as: UInt16.self) }
        } else {
            self.value = nil
        }
        super.init(tag: tag, vr: .US, length: 2, value: value)
    }

    public override var stringValue: String? {
        guard let value = self.value else {
            return nil
        }
        return String(format: "%d", value)
    }
}
