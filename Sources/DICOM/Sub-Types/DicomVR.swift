//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

public enum DicomVR: String {
    /// Application Entity
    case AE

    /// Age String
    case AS

    /// Attribute Tag
    case AT

    /// Code String
    case CS

    /// Date (YYYYMMDD)
    case DA

    /// Decimal String
    case DS

    /// Date Time (YYYYMMDDHHMMSS.FFFFFF&ZZXX)
    case DT

    /// Floating Point Single (IEEE 754:1985 32-bit Floating Point Number Format)
    case FL

    /// Floating Point Double (IEEE 754:1985 64-bit Floating Point Number Format)
    case FD

    /// Integer String
    case IS

    /// Long String
    case LO

    /// Long Text
    case LT

    /// Other Byte
    case OB

    /// Other Double
    case OD

    /// Other Float
    case OF

    /// Other Long
    case OL

    /// Other Word
    case OW

    /// Person Name
    case PN

    /// Short String
    case SH

    /// Signed Long
    case SL

    /// Sequence
    case SQ

    /// Signed Short
    case SS

    /// Short Text
    case ST

    /// Time (HHMMSS.FFFFFF)
    case TM

    /// Unlimited Characters
    case UC

    /// Unique Identifier
    case UI

    /// Unsigned Long
    case UL

    /// Unknown
    case UN

    /// Universal Resource Identifier (URI / URL)
    case UR

    /// Unsigned Short
    case US

    /// Unlimited Text
    case UT
}

extension DicomVR: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.rawValue
    }
    public var description: String {
        return self.rawValue
    }
}
