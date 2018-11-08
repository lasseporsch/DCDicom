//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 TM - Time

 # Definition
 A string of characters of the format HHMMSS.FFFFFF; where HH contains hours (range "00" - "23"), MM contains minutes (range "00" - "59"),
 SS contains seconds (range "00" - "60"), and FFFFFF contains a fractional part of a second as small as 1 millionth of a second (range "000000" - "999999").
 A 24-hour clock is used. Midnight shall be represented by only "0000" since "2400" would violate the hour range. The string may be padded with trailing spaces.
 Leading and embedded spaces are not allowed.

 One or more of the components MM, SS, or FFFFFF may be unspecified as long as every component to the right of an unspecified component is also unspecified,
 which indicates that the value is not precise to the precision of those unspecified components.

 The FFFFFF component, if present, shall contain 1 to 6 digits. If FFFFFF is unspecified the preceding "." shall not be included.

 Examples:
 1. "070907.0705 " represents a time of 7 hours, 9 minutes and 7.0705 seconds.
 2. "1010" represents a time of 10 hours, and 10 minutes.
 3. "021 " is an invalid value.

 Note:
 1. The ACR-NEMA Standard 300 (predecessor to DICOM) supported a string of characters of the format HH:MM:SS.frac for this VR. Use of this format is not compliant.
 2. See also DT VR in this table.
 3. The SS component may have a value of 60 only for a leap second.

 # Character Reportoire
 "0"-"9", "." and the SPACE character of Default Character Repertoire

 In the context of a Query with range matching (see PS3.4), the character "-" is allowed.

 # Length of value
 14 bytes maximum

 In the context of a Query with range matching (see PS3.4), the length is 28 bytes maximum.
 */
public class DicomDataElementTM: DicomDataElement {
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHMMSS.FFFFFF"
        return formatter
    }

    public override var stringValue: String? {
        guard let value = self.rawValue else {
            return nil
        }
        guard let stringValue = String(data: value, encoding: .ascii) else {
            return nil
        }
        return stringValue
    }

    public var value: Date? {
        guard let stringValue = self.stringValue else {
            return nil
        }
        guard let dateValue = DicomDataElementTM.dateFormatter.date(from: stringValue) else {
            return nil
        }
        return dateValue
    }
}
