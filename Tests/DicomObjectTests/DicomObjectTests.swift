//
//  DCDicom
//  Copyright © 2018 Lasse Porsch
//  Licensed under the MIT license, see LICENSE file
//


import XCTest
@testable import DCDicom


class TestDicoms {
    static let pdfDicom = Bundle(for: TestDicoms.self).url(forResource: "TestDicom_PDF", withExtension: "dcm")!
    static let imageDicom = Bundle(for: TestDicoms.self).url(forResource: "TestDicom_Image", withExtension: "dcm")!
}



class DicomObjectTests: XCTestCase {

    override func setUp() {
        super.setUp()

        self.continueAfterFailure = false
    }
}


// MARK: - Test Initialization
extension DicomObjectTests {
    func testThatItCanBeInitializedWithURL() {
        // Arrange
        let url = TestDicoms.pdfDicom

        // Act
        do {
            _ = try DicomObject(url: url)
        } catch {
            XCTFail("Failed to instantiate DicomObject from URL\n  URL: \(url)\n  Error: '\(String(describing: error))'")
        }
    }
    func testThatItCanBeInitializedWithData() {
        // Arrange
        let data = try! Data(contentsOf: TestDicoms.pdfDicom)

        // Act
        do {
            _ = try DicomObject(data: data)
        } catch {
            XCTFail("Failed to instantiate DicomObject from Data with error: '\(String(describing: error))'")
        }
    }
    func testThatItCanBeInitializedWithInputStream() {
        // Arrange
        let inputStream = InputStream(url: TestDicoms.pdfDicom)!

        // Act
        do {
            _ = try DicomObject(inputStream: inputStream)
        } catch {
            XCTFail("Failed to instantiate DicomObject from InputStream with error: '\(String(describing: error))'")
        }
    }
}

// MARK: - Test Subscript
extension DicomObjectTests {
    func testThatDataElementsAreAccessibleWithSubscript() {
        do {
            // Arrange
            let dicomObject = try DicomObject(url: TestDicoms.pdfDicom)

            // Act
            let transferSyntaxUidDataElement = dicomObject[0x00020010]
            let sopInstanceUidDataElement = dicomObject[0x00080018]

            // Assert
            XCTAssertNotNil(transferSyntaxUidDataElement, "Failed to read Data Element (0002,0010) 'Transfer Syntax UID' with subscript; Got back 'nil'")
            XCTAssertNotNil(sopInstanceUidDataElement, "Failed to read Data Element (0008,0018) 'SOP Instance UID' with subscript; Got back 'nil'")
       } catch {
            XCTFail("Failed to instantiate DicomObject with error: \(String(describing: error))")
        }

    }
}


// MARK: - Test Subscript
extension DicomObjectTests {
    func testThatItReadsAllDataElements() {
        // Arrange

        // Act

        // Assert

    }
    func testThatItDeterminedTheCorrectTransferSyntax() {
        // Arrange

        // Act

        // Assert

    }
}
