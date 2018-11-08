//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 AE - Application Entity

 # Definition
 A string of characters that identifies an Application Entity with leading and trailing spaces (20H) being non-significant.
 A value consisting solely of spaces shall not be used.

 # Character Reportoire
 Default Character Repertoire excluding character code 5CH (the BACKSLASH "\" in ISO-IR 6), and all control characters.

 # Length of value
 16 bytes maximum
 */
public class DicomDataElementAE: DicomDataElement {
    
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
