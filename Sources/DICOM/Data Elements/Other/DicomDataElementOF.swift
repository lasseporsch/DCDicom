//
//  DicomDataElementOF.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 OF - Other Float

 # Definition
 A string of 32-bit IEEE 754:1985 floating point words. OF is a VR that requires byte swapping within each 32-bit word when
 changing between Little Endian and Big Endian byte ordering (see Section 7.3).

 # Character Reportoire
 not applicable

 # Length of value
 2^32-4 bytes maximum
 */
public class DicomDataElementOF: DicomDataElement {
//    override var debugDescription: String {
//        if let value = self.value, let valueString = String(data: value, encoding: .ascii) {
//            return String(format: "%@ %@: '%@' (%d Bytes)", self.tag.debugDescription, self.vr, valueString, self.length ?? -1)
//        } else {
//            return super.debugDescription
//        }
//    }
}
