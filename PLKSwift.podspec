Pod::Spec.new do |s|
  s.name             = 'PLKSwift'
  s.version          = '1.0.0'
  s.summary          = 'A short description of PLKSwift.'
  s.description      = 'A more detailed description of PLKSwift.'
  s.homepage         = 'https://github.com/halisback/PLKSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Darwin.id' => 'hi@darwin.id' }
  s.source           = { :git => 'https://github.com/halisback/PLKSwift.git', :tag => s.version.to_s}
  s.source_files     = 'Sources/polka/**/*.{h,m,swift}'
  s.swift_versions   = ['5.0']
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = nil 
  s.dependency 'SwiftyJSON'
  s.requires_arc     = true
end
