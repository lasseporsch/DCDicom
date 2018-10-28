//
//  DicomDataElementSS.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 SS - Signed Short

 # Definition
 Signed binary integer 16 bits long in 2's complement form. Represents an integer n in the range:

 -2^15<= n <= 2^15-1.

 # Character Reportoire
 not applicable

 # Length of value
 2 bytes fixed
 */
public class DicomDataElementSS: DicomDataElement {

    let value: Int16?

    init(tag: DicomTag, value: Data?) {
        if let rawValue = value {
            self.value = rawValue.withUnsafeBytes { (pointer: UnsafePointer<Int16>) in pointer.pointee }
        } else {
            self.value = nil
        }
        super.init(tag: tag, vr: .SS, length: 2, value: value)
    }

    public override var stringValue: String? {
        guard let value = self.value else {
            return nil
        }
        return String(format: "%d", value)
    }
}
