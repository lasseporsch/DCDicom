//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 LT - Long Text

 # Definition
 A character string that may contain one or more paragraphs. It may contain the Graphic Character set and the Control Characters,
 CR, LF, FF, and ESC. It may be padded with trailing spaces, which may be ignored, but leading spaces are considered to be significant.
 Data Elements with this VR shall not be multi-valued and therefore character code 5CH (the BACKSLASH "\" in ISO-IR 6) may be used.

 # Character Reportoire
 Default Character Repertoire and/or as defined by (0008,0005) excluding Control Characters except TAB, LF, FF, CR
 (and ESC when used for ISO 2022 escape sequences).

 # Length of value
 10240 chars maximum (see Note in Section 6.2)
 */
public class DicomDataElementLT: DicomDataElement {

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
