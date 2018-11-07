//
//  DicomDataElementOL.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 OL - Other Long

 # Definition
 A string of 32-bit words where the encoding of the contents is specified by the negotiated Transfer Syntax.
 OL is a VR that requires byte swapping within each word when changing between Little Endian and Big Endian byte ordering (see Section 7.3).

 # Character Reportoire
 not applicable

 # Length of value
 see Transfer Syntax definition
 */
public class DicomDataElementOL: DicomDataElement {
}
