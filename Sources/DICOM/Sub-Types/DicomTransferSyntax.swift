//
//  DicomTransferSyntax.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 27.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation
import Unbox

public struct DicomTransferSyntax {

    static let defaultTransferSyntax = DicomTransferSyntax.dictionary["1.2.840.10008.1.2"]! // If this entry is not present the app should rightfully crash

    static private var dictionary: [String: DicomTransferSyntax] {
        do {
            var dictionary: [String: DicomTransferSyntax] = [:]
            guard let tsJSONURL = Bundle.main.url(forResource: "DicomTransferSyntax", withExtension: "json") else {
                fatalError("Couldn't file Transfer Syntax definition file")
            }
            let tsJSONData = try Data(contentsOf: tsJSONURL)
            let tsArray: [DicomTransferSyntax] = try unbox(data: tsJSONData)

            tsArray.forEach {
                dictionary[$0.uid] = $0
            }
            return dictionary
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    let uid: String
    let name: String
    let explicitVR: Bool
    let bigEndian: Bool
    let deflated: Bool
    let encapsulated: Bool

    static func with(uid: String) -> DicomTransferSyntax? {
        return DicomTransferSyntax.dictionary[uid]
    }
}


extension DicomTransferSyntax: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.uid = try unboxer.unbox(key: "uid")
        self.name = try unboxer.unbox(key: "name")
        self.explicitVR = try unboxer.unbox(key: "explicitVR")
        self.bigEndian = try unboxer.unbox(key: "bigEndian")
        self.deflated = try unboxer.unbox(key: "deflated")
        self.encapsulated = try unboxer.unbox(key: "encapsulated")
    }
}
