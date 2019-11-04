//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

public enum DicomError: Error {
    case couldNotOpenFile
    case invalidPreamble
    case invalidPrefix(_ prefix: String)
    case invalidDataElement
    case undelimitedSequencesNotSupported
    case undelimitedSequenceItemsNotSupported
    case invalidSequenceTag
    case emptyTransferSyntax
    case unknownTransferSyntax
    case invalidUseOfUndefinedLength
}
