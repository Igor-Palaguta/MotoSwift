Pod::Spec.new do |s|
  s.name             = 'MotoSwift'
  s.version          = '0.0.3'
  s.summary          = 'Generates managed object subclasses from Core Data model.'

  s.description      = <<-DESC
Parses Core Data model, and applies templates for generation swift code
                       DESC

  s.homepage         = 'https://github.com/Igor-Palaguta/MotoSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Igor Palaguta' => 'igor.palaguta@gmail.com' }
  s.source           = { :git => 'https://github.com/Igor-Palaguta/MotoSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/igor_palaguta'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'Source/MotoSwiftFramework/**/*.swift'

  s.dependency 'SWXMLHash'
  s.dependency 'Stencil'
end
