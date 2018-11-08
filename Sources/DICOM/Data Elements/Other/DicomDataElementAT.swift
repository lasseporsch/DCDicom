//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 AT - Attribute Tag

 # Definition
 Ordered pair of 16-bit unsigned integers that is the value of a Data Element Tag.

 Example: A Data Element Tag of (0018,00FF) would be encoded as a series of 4 bytes in a Little-Endian Transfer Syntax as 18H,00H,FFH,00H and in a Big-Endian Transfer Syntax as 00H,18H,00H,FFH.

 Note: The encoding of an AT value is exactly the same as the encoding of a Data Element Tag as defined in Section 7.

 # Character Reportoire
 not applicable

 # Length of value
 4 bytes fixed
 */
public class DicomDataElementAT: DicomDataElement {
}
