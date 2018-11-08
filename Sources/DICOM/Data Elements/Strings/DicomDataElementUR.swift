//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

/**
 UR - Universal Resource Identifier or Universal Resource Locator (URI/URL)

 # Definition
 A string of characters that identifies a URI or a URL as defined in [RFC 3986]. Leading spaces are not allowed. Trailing spaces shall be ignored.
 Data Elements with this VR shall not be multi-valued.

 Note:
 - Both absolute and relative URIs are permitted. If the URI is relative, then it is relative to the base URI of the object within which it is contained.

 # Character Reportoire
 The subset of the Default Character Repertoire required for the URI as defined in IETF RFC3986 Section 2, plus the space (20H) character permitted only as trailing padding.

 Characters outside the permitted character set must be "percent encoded".

 Note:
 - The Backslash (5CH) character is among those disallowed in URIs.

 # Length of value
 2^32-2 bytes maximum.

 The length of the value is limited only by the size of the maximum unsigned integer representable in a 32 bit VL field minus two, since FFFFFFFFH is reserved and lengths are required to be even.
 */
public class DicomDataElementUR: DicomDataElement {

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
