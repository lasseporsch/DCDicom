//
//  DicomDataElementOD.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 OD - Other Double

 # Definition
 A string of 64-bit IEEE 754:1985 floating point words. OD is a VR that requires byte swapping within each 64-bit word
 when changing between Little Endian and Big Endian byte ordering (see Section 7.3).

 # Character Reportoire
 not applicable

 # Length of value
 2^32-8 bytes maximum
 */
public class DicomDataElementOD: DicomDataElement {
}
