//
//  DicomError.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 25.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

public enum DicomError: Error {
    case couldNotOpenFile
    case invalidPreamble
    case invalidPrefix
    case invalidDataElement
    case undelimitedSequencesNotSupported
    case undelimitedSequenceItemsNotSupported
    case invalidSequenceTag
    case emptyTransferSyntax
    case unknownTransferSyntax
    case invalidUseOfUndefinedLength
}
