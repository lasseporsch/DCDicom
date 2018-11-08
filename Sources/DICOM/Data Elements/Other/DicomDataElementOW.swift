//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
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
}
