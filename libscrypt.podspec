#
# Be sure to run `pod lib lint libscrypt.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'libscrypt'
  s.version          = '1.22.1'
  s.summary          = 'Linux scrypt shared library.'
  s.description      = <<-DESC
  A shared library that implements scrypt() functionality - a replacement for bcrypt().
                       DESC

  s.homepage         = 'https://github.com/sunimp/libscrypt'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yang Guang' => 'holaux@gmail.com' }
  s.source           = { :git => 'https://github.com/sunimp/libscrypt.git', :tag => 'v' + s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'libscrypt/*.{h,m,c}'
  s.requires_arc = true
  s.framework    = 'Foundation'

end
