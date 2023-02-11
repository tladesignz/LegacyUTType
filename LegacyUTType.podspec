#
# Be sure to run `pod lib lint LegacyUTType.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LegacyUTType'
  s.version          = '0.1.0'
  s.summary          = 'UTType before iOS 14'
  s.description      = <<-DESC
Brings the convenience of `UTType`s to iOS before version 14.
                       DESC

  s.homepage         = 'https://github.com/tladesignz/LegacyUTType'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Benjamin Erhart' => 'berhart@netzarchitekten.com' }
  s.source           = { :git => 'https://github.com/tladesignz/LegacyUTType.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tladesignz'

  s.ios.deployment_target = '11.0'

  s.source_files = 'LegacyUTType/Classes/**/*'
end
