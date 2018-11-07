//
//  DicomDataElementOF.swift
//  DCDicom
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
}
