# DCDicom

[![CI Status](https://travis-ci.org/lasseporsch/DCDicom.svg?branch=master)](https://travis-ci.org/lasseporsch/DCDicom)
[![Version](https://img.shields.io/cocoapods/v/DCDicom.svg?style=flat)](https://cocoapods.org/pods/DCDicom)
[![License](https://img.shields.io/cocoapods/l/DCDicom.svg?style=flat)](https://cocoapods.org/pods/DCDicom)
[![Platform](https://img.shields.io/cocoapods/p/DCDicom.svg?style=flat)](https://cocoapods.org/pods/DCDicom)

## Installation

DCDicom is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DCDicom'
```

## Author

Lasse Porsch, lasse.porsch@d-csm.com

## License

DCDicom is available under the MIT license. See the LICENSE file for more info.

## Usage

### Creating a DicomObject
You can create a DicomObject instance from a URL, from Data or from any InputStream.
```swift
do {
    let dicomObjectFromURL = try DicomObject(url: dicomURL)
    let dicomObjectFromData = try DicomObject(data: dicomData)
    let dicomObjectFromInputStream = try DicomObject(inputStream: dicomInputStream)
} catch {
    print("Something went wrong! Error: \(error)")
}
```

### Reading the Data Elements
DICOMs are hierarchical data structures consisting of Data Elements. Once a DicomObject is instantiated, 
you have direct access to all of its root-level data elements by traversing the `dataElements`:
```swift
dicomObject.dataElements.forEach {
    print("Found DataElement with \($0.tag)")
}
```
Specific Data Elements can also be accessed by subscript:
```swift
let sopInstanceUidDataElement = dicomObject[0x00080018]!
```


### Accessing typed values
While each Data Element normally has a raw value of type Data and most have a string representation of this raw value, 
you can also "introspect" the actual" data type of the Data Element and get a Swift-typed value. 
The Data Element's Value Representation is used for this. However, it is only available if it is explicitly mentioned in the DICOM object. 
If the Dicom Object uses implicit Value Representations, you have to manually convert the raw data into a typed value based on the semantics 
of the specific Dicom Object as per the corresponding DICOM Conformance Statement.
```swift
guard let vr = dataElement.vr else {
    print("Implicit Value Representation. Cannot determine value type without more context")
}
switch vr {
    case .FD: // Double
        if let doubleValue = (dataElement as! DicomDataElementFD).value {
            print(String(format: "Double value = %f", doubleValue))
        } else {
            print("Empty value")
        }
    case .FL: // Float
        if let floatValue = (dataElement as! DicomDataElementFL).value {
            print(String(format: "Float value = %f", floatValue))
        } else {
            print("Empty value")
        }
    case .DA: // Date
        if let dateValue = (dataElement as! DicomDataElementDA).value {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            print(String(format: "Date value = %@", formatter.string(from: dateValue)))
        } else {
            print("Empty value")
        }
    default:
        break
}
```
