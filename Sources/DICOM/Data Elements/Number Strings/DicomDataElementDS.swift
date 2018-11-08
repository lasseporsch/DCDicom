//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 DS - Decimal String

 # Definition
 A string of characters representing either a fixed point number or a floating point number.

 A fixed point number shall contain only the characters 0-9 with an optional leading "+" or "-" and an optional "." to
 mark the decimal point.

 A floating point number shall be conveyed as defined in ANSI X3.9, with an "E" or "e" to indicate the start of the exponent.

 Decimal Strings may be padded with leading or trailing spaces. Embedded spaces are not allowed.

 Note:
 Data Elements with multiple values using this VR may not be properly encoded if Explicit-VR transfer syntax is
 used and the VL of this attribute exceeds 65534 bytes.

 # Character Reportoire
 "0"-"9", "+", "-", "E", "e", "." and the SPACE character of Default Character Repertoire

 # Length of value
 16 bytes maximum
 */
public class DicomDataElementDS: DicomDataElement {
    public override var stringValue: String? {
        guard let value = self.rawValue else {
            return nil
        }
        guard let stringValue = String(data: value, encoding: .ascii) else {
            return nil
        }
        return stringValue
    }
}
