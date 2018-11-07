//
//  DicomDataElementFL.swift
//  DCDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 FL - Floating Point Single

 # Definition
 Single precision binary floating point number represented in IEEE 754:1985 32-bit Floating Point Number Format.

 # Character Reportoire
 not applicable

 # Length of value
 4 bytes fixed
 */
public class DicomDataElementFL: DicomDataElement {

    let value: Float32?

    init(tag: DicomTag, value: Data?) {
        if let rawValue = value {
            self.value = rawValue.withUnsafeBytes { (pointer: UnsafePointer<Float32>) in pointer.pointee }
        } else {
            self.value = nil
        }
        super.init(tag: tag, vr: .FL, length: 4, value: value)
    }


    public override var stringValue: String? {
        guard let value = self.value else {
            return nil
        }
        return String(format: "%f", value)
    }
}
