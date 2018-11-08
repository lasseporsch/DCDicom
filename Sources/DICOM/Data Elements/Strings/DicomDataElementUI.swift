//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 UI - Unique Identifier (UID)

 # Definition
 A character string containing a UID that is used to uniquely identify a wide variety of items.
 The UID is a series of numeric components separated by the period "." character.
 If a Value Field containing one or more UIDs is an odd number of bytes in length, the Value Field shall be padded
 with a single trailing NULL (00H) character to ensure that the Value Field is an even number of bytes in length.
 See Section 9 and Annex B for a complete specification and examples.

 # Character Reportoire
 "0"-"9", "." of Default Character Repertoire

 # Length of value
 64 bytes maximum
 */
public class DicomDataElementUI: DicomDataElement {

    public override var stringValue: String? {
        guard var value = self.rawValue else {
            return nil
        }
        if value.last == 0x00 {
            value.removeLast() // We remove a trailing zero-byte that has been added for padding reasons
        }
        guard let stringValue = String(data: value, encoding: .ascii) else {
            return nil
        }
        return stringValue
    }
}
