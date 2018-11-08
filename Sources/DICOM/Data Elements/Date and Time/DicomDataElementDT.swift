//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 DT - Date Time

 # Definition
 A concatenated date-time character string in the format:

 YYYYMMDDHHMMSS.FFFFFF&ZZXX

 The components of this string, from left to right, are YYYY = Year, MM = Month, DD = Day, HH = Hour (range "00" - "23"), MM = Minute (range "00" - "59"), SS = Second (range "00" - "60").

 FFFFFF = Fractional Second contains a fractional part of a second as small as 1 millionth of a second (range "000000" - "999999").

 &ZZXX is an optional suffix for offset from Coordinated Universal Time (UTC), where & = "+" or "-", and ZZ = Hours and XX = Minutes of offset.

 The year, month, and day shall be interpreted as a date of the Gregorian calendar system.

 A 24-hour clock is used. Midnight shall be represented by only "0000" since "2400" would violate the hour range.

 The Fractional Second component, if present, shall contain 1 to 6 digits. If Fractional Second is unspecified the preceding "." shall not be included. The offset suffix, if present, shall contain 4 digits. The string may be padded with trailing SPACE characters. Leading and embedded spaces are not allowed.

 A component that is omitted from the string is termed a null component. Trailing null components of Date Time indicate that the value is not precise to the precision of those components. The YYYY component shall not be null. Non-trailing null components are prohibited. The optional suffix is not considered as a component.

 A Date Time value without the optional suffix is interpreted to be in the local time zone of the application creating the Data Element, unless explicitly specified by the Timezone Offset From UTC (0008,0201).

 UTC offsets are calculated as "local time minus UTC". The offset for a Date Time value in UTC shall be +0000.

 Note:
 1. The range of the offset is -1200 to +1400. The offset for United States Eastern Standard Time is -0500. The offset for Japan Standard Time is +0900.
 2. The RFC 2822 use of -0000 as an offset to indicate local time is not allowed.
 3. A Date Time value of 195308 means August 1953, not specific to particular day. A Date Time value of 19530827111300.0 means August 27, 1953, 11;13 a.m. accurate to 1/10th second.
 4. The Second component may have a value of 60 only for a leap second.
 5. The offset may be included regardless of null components; e.g., 2007-0500 is a legal value.

 # Character Reportoire
 "0"-"9", "+", "-", "." and the SPACE character of Default Character Repertoire

 # Length of value
 26 bytes maximum

 In the context of a Query with range matching (see PS3.4), the length is 54 bytes maximum.
 */
public class DicomDataElementDT: DicomDataElement {
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMDDHHMMSS.FFFFFF&ZZXX"
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
        guard let dateValue = DicomDataElementDT.dateFormatter.date(from: stringValue) else {
            return nil
        }
        return dateValue
    }
}
