//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//

import Foundation

public struct DicomTransferSyntax: Decodable {

    static let defaultTransferSyntax = DicomTransferSyntax.dictionary["1.2.840.10008.1.2"]! // If this entry is not present the app should rightfully crash

    static private var dictionary: [String: DicomTransferSyntax] {
        do {
            var dictionary: [String: DicomTransferSyntax] = [:]
            guard let tsJSONURL = Bundle(for: DicomObject.self).url(forResource: "DicomTransferSyntax", withExtension: "json") else {
                fatalError("Couldn't file Transfer Syntax definition file")
            }
            let tsJSONData = try Data(contentsOf: tsJSONURL)
            let tsArray = try JSONDecoder().decode([DicomTransferSyntax].self, from: tsJSONData)

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
