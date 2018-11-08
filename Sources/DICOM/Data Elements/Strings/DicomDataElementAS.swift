//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 AS - Age String

 # Definition
 A string of characters with one of the following formats -- nnnD, nnnW, nnnM, nnnY; where nnn shall contain the number of days for D, weeks for W, months for M, or years for Y.

 Example: "018M" would represent an age of 18 months.

 # Character Reportoire
 "0"-"9", "D", "W", "M", "Y" of Default Character Repertoire

 # Length of value
 4 bytes fixed
 */
public class DicomDataElementAS: DicomDataElement {

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
