Pod::Spec.new do |s|

  s.name         = 'DCDicom'
  s.version      = '0.3.2'
  s.summary      = 'A DICOM reader written in Swift.'

  s.homepage     = 'https://github.com/lasseporsch/DCDicom'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Lasse Porsch' => 'lasse.porsch@d-csm.com' }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source       = { :git => 'https://github.com/lasseporsch/DCDicom.git', :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
  s.requires_arc = true

  s.resources    = 'Resources/**/*.*'

  s.exclude_files = 'Tests/**/*'

  s.swift_version = '5.0'
end
