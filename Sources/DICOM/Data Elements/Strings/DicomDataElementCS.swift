//
//  DicomDataElementCS.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 CS - Code String

 # Definition
 A string of characters with leading or trailing spaces (20H) being non-significant.

 # Character Reportoire
 Uppercase characters, "0"-"9", the SPACE character, and underscore "_", of the Default Character Repertoire

 # Length of value
 16 bytes maximum
 */
public class DicomDataElementCS: DicomDataElement {

    override public var stringValue: String? {
        guard let value = self.rawValue else {
            return nil
        }
        guard let stringValue = String(data: value, encoding: .ascii) else {
            return "[Unrecognized String data]"
        }
        return stringValue
    }
}
