//
//  DicomDataElementSQ.swift
//  SwiftDicom
//
//  Created by Lasse Porsch on 26.10.18.
//  Copyright © 2018 DCSM GmbH. All rights reserved.
//

import Foundation

/**
 SQ - Sequence of Items

 # Definition
 Value is a Sequence of zero or more Items, as defined in Section 7.5.

 # Character Reportoire
 not applicable (see Section 7.5)

 # Length of value
 not applicable (see Section 7.5)
 */
public class DicomDataElementSQ: DicomDataElement {
    public private(set) var items: [DicomSequenceItem] = []

    func add(_ item: DicomSequenceItem) {
        self.items.append(item)
    }

    public override var stringValue: String? {
        return self.length == 0xFFFFFFFF ? "Undefined length" : self.length == 0x00000000 ? "0 Items" : String(format: "%d Bytes", self.length)
    }
}


public class DicomSequenceItem {
    public private(set) var dataElements: [DicomDataElement] = []

    func add(_ dataElement: DicomDataElement) {
        self.dataElements.append(dataElement)
    }
}
