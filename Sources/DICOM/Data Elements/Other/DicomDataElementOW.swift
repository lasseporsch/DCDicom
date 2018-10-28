//
//  DicomDataElementOW.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 OW - Other Word

 # Definition
 A string of 16-bit words where the encoding of the contents is specified by the negotiated Transfer Syntax.
 OW is a VR that requires byte swapping within each word when changing between Little Endian and Big Endian byte ordering (see Section 7.3).

 # Character Reportoire
 not applicable

 # Length of value
 see Transfer Syntax definition
 */
public class DicomDataElementOW: DicomDataElement {
//    override var debugDescription: String {
//        if let value = self.value, let valueString = String(data: value, encoding: .ascii) {
//            return String(format: "%@ %@: '%@' (%d Bytes)", self.tag.debugDescription, self.vr, valueString, self.length ?? -1)
//        } else {
//            return super.debugDescription
//        }
//    }
}
