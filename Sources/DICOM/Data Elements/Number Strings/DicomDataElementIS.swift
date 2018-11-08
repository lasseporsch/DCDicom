//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 IS - Integer String

 # Definition
 A string of characters representing an Integer in base-10 (decimal), shall contain only the characters 0 - 9,
 with an optional leading "+" or "-". It may be padded with leading and/or trailing spaces. Embedded spaces are not allowed.

 The integer, n, represented shall be in the range:

 -231<= n <= (231-1).

 # Character Reportoire
 "0"-"9", "+", "-" and the SPACE character of Default Character Repertoire

 # Length of value
 12 bytes maximum
 */
public class DicomDataElementIS: DicomDataElement {
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
