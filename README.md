# DCDicom

[![CI Status](https://img.shields.io/travis/lasseporsch/DCDicom.svg?style=flat)](https://travis-ci.org/lasseporsch/DCDicom)
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
You can create a DicomObject instanc from a URL, from Data or from any InputStream.
```swift
let dicomObject = DicomObject(url: fileURL)
```

### Getting the DICOM contents
DICOM objects are hierarchical data structures consisting of Data Elements. Once a DicomObject is instantiated, 
you have direct access to all of its root-level data elements:
```swift
dicomObject.dataElements.forEach {
    print("Found DataElement with \($0.tag) and value \($0.stringValue))
}
```


