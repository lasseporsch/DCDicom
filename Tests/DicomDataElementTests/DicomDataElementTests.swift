//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//


import XCTest
@testable import DCDicom

class DicomDataElementTests: XCTestCase {

    func testThatItReturnsTheCorrectSubclassesForExplicitVRs() {

        // No explicit VR
        self.check(explicitVR: nil, instantiatesAs: DicomDataElement.self)

        // Number Strings
        self.check(explicitVR: "IS", instantiatesAs: DicomDataElementIS.self)
        self.check(explicitVR: "DS", instantiatesAs: DicomDataElementDS.self)

        // Date and Time
        self.check(explicitVR: "DA", instantiatesAs: DicomDataElementDA.self)
        self.check(explicitVR: "TM", instantiatesAs: DicomDataElementTM.self)
        self.check(explicitVR: "DT", instantiatesAs: DicomDataElementDT.self)

        // Strings
        self.check(explicitVR: "UR", instantiatesAs: DicomDataElementUR.self)
        self.check(explicitVR: "UI", instantiatesAs: DicomDataElementUI.self)
        self.check(explicitVR: "SH", instantiatesAs: DicomDataElementSH.self)
        self.check(explicitVR: "UT", instantiatesAs: DicomDataElementUT.self)
        self.check(explicitVR: "AS", instantiatesAs: DicomDataElementAS.self)
        self.check(explicitVR: "CS", instantiatesAs: DicomDataElementCS.self)
        self.check(explicitVR: "ST", instantiatesAs: DicomDataElementST.self)
        self.check(explicitVR: "LT", instantiatesAs: DicomDataElementLT.self)
        self.check(explicitVR: "LO", instantiatesAs: DicomDataElementLO.self)
        self.check(explicitVR: "UC", instantiatesAs: DicomDataElementUC.self)
        self.check(explicitVR: "AE", instantiatesAs: DicomDataElementAE.self)

        // Numbers
        self.check(explicitVR: "SS", instantiatesAs: DicomDataElementSS.self)
        self.check(explicitVR: "SL", instantiatesAs: DicomDataElementSL.self)
        self.check(explicitVR: "US", instantiatesAs: DicomDataElementUS.self)
        self.check(explicitVR: "FD", instantiatesAs: DicomDataElementFD.self)
        self.check(explicitVR: "UL", instantiatesAs: DicomDataElementUL.self)
        self.check(explicitVR: "FL", instantiatesAs: DicomDataElementFL.self)

        // Other
        self.check(explicitVR: "AT", instantiatesAs: DicomDataElementAT.self)
        self.check(explicitVR: "OL", instantiatesAs: DicomDataElementOL.self)
        self.check(explicitVR: "OW", instantiatesAs: DicomDataElementOW.self)
        self.check(explicitVR: "UN", instantiatesAs: DicomDataElementUN.self)
        self.check(explicitVR: "OF", instantiatesAs: DicomDataElementOF.self)
        self.check(explicitVR: "OD", instantiatesAs: DicomDataElementOD.self)
        self.check(explicitVR: "OB", instantiatesAs: DicomDataElementOB.self)

        // Special formats
        self.check(explicitVR: "SQ", instantiatesAs: DicomDataElementSQ.self)
        self.check(explicitVR: "PN", instantiatesAs: DicomDataElementPN.self)
    }

    private func check<T>(explicitVR: String?, instantiatesAs: T.Type, file: StaticString = #file, line: UInt = #line) {
        let element = DicomDataElement.make(tag: 0x00000000, explicitVR: explicitVR, length: 0, value: nil)
        XCTAssert(element is T, "Explicit VR '\(explicitVR ?? "nil")' was expected instantiate as '\(String(describing: T.self))', but did instantiate as '\(String(describing: type(of: element)))'", file: file, line: line)
    }
}
