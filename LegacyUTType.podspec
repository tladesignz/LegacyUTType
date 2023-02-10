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

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Wrapper class to use a UTType-style interface to Uniform Type Identifiers before iOS 14.
                       DESC

  s.homepage         = 'https://github.com/tladesignz/LegacyUTType'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Benjamin Erhart' => 'berhart@netzarchitekten.com' }
  s.source           = { :git => 'https://github.com/tladesignz/LegacyUTType.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tladesignz'

  s.ios.deployment_target = '11.0'

  s.source_files = 'LegacyUTType/Classes/**/*'
end
