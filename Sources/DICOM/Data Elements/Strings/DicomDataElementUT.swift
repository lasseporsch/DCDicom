//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 UT - Unlimited Text

 # Definition
 A character string that may contain one or more paragraphs. It may contain the Graphic Character set and the Control Characters, CR, LF, FF, and ESC.
 It may be padded with trailing spaces, which may be ignored, but leading spaces are considered to be significant.
 Data Elements with this VR shall not be multi-valued and therefore character code 5CH (the BACKSLASH "\" in ISO-IR 6) may be used.

 # Character Reportoire
 Default Character Repertoire and/or as defined by (0008,0005) excluding Control Characters except TAB, LF, FF, CR (and ESC when used for ISO 2022 escape sequences).

 # Length of value
 2^32-2 bytes maximum.

 The length of the value is limited only by the size of the maximum unsigned integer representable in a 32 bit VL field minus two, since FFFFFFFFH is reserved and lengths are required to be even.
 */
public class DicomDataElementUT: DicomDataElement {

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
