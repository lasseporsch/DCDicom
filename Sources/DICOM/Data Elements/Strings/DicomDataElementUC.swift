//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 UC - Unlimited Characters

 # Definition
 A character string that may be of unlimited length that may be padded with trailing spaces. The character code 5CH (the BACKSLASH "\" in ISO-IR 6) shall not be present,
 as it is used as the delimiter between values in multiple valued data elements. The string shall not have Control Characters except for ESC.

 # Character Reportoire
 Default Character Repertoire and/or as defined by (0008,0005) excluding character code 5CH (the BACKSLASH "\" in ISO-IR 6), and all Control Characters except
 ESC when used for ISO 2022 escape sequences.

 # Length of value
 2^32-2 bytes maximum

 The length is limited only by the size of the maximum unsigned integer representable in a 32 bit VL field minus two, since FFFFFFFFH is reserved and lengths are required to be even.
 */
public class DicomDataElementUC: DicomDataElement {

    override public var stringValue: String? {
        guard let value = self.rawValue else {
            return nil
        }
        guard let stringValue = String(data: value, encoding: .ascii) else {
            return nil
        }
        return stringValue
    }
}
