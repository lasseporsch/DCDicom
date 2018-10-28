Pod::Spec.new do |spec|

  spec.name         = "DCDicom"
  spec.version      = "0.1.0"
  spec.summary      = "DCDicom is a DICOM parser written in Swift."

  spec.homepage     = "https://github.com/D-CSM/DCDicom"

  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Lasse Porsch" => "lasse.porsch@d-csm.de" }

  spec.ios.deployment_target = "8.0"
  spec.osx.deployment_target = "10.9"

  spec.source       = { :git => "https://github.com/D-CSM/DCDicom.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources/**/*.swift"
  spec.requires_arc = true

  spec.resources    = "Resources/**/*.*"

  spec.swift_version = "4.2"

  spec.dependency "Unbox", "3.0.0"
end
