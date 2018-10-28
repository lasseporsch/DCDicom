//
//  DicomDataElementUN.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 UN - Unknown

 # Definition
 A string of bytes where the encoding of the contents is unknown (see Section 6.2.2).

 # Character Reportoire
 not applicable

 # Length of value
 Any length valid for any of the other DICOM Value Representations
 */
public class DicomDataElementUN: DicomDataElement {
//    override var debugDescription: String {
//        if let value = self.value, let valueString = String(data: value, encoding: .ascii) {
//            return String(format: "%@ %@: '%@' (%d Bytes)", self.tag.debugDescription, self.vr, valueString, self.length ?? -1)
//        } else {
//            return super.debugDescription
//        }
//    }
}
