//
//  DicomDataElementDA.swift
//  DCDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 DA - Date

 # Definition
 A string of characters of the format YYYYMMDD; where YYYY shall contain year, MM shall contain the month,
 and DD shall contain the day, interpreted as a date of the Gregorian calendar system.

 Example:
 "19930822" would represent August 22, 1993.

 Note:
 The ACR-NEMA Standard 300 (predecessor to DICOM) supported a string of characters of the format YYYY.MM.DD for this VR.
 Use of this format is not compliant.

 See also DT VR in this table.

 # Character Reportoire
 "0"-"9" of Default Character Repertoire

 In the context of a Query with range matching (see PS3.4), the character "-" is allowed, and a trailing SPACE character
 is allowed for padding.

 # Length of value
 8 bytes fixed

 In the context of a Query with range matching (see PS3.4), the length is 18 bytes maximum.
 */
public class DicomDataElementDA: DicomDataElement {
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
