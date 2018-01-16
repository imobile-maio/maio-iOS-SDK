#
# Be sure to run `pod lib lint MaioSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MaioSDK'
  s.version          = '1.2.18'
  s.summary          = 'MaioSDK for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MaioSDK is Ad SDK of fullscreen movie
                       DESC

  s.homepage         = 'https://maio.jp'
  s.license          = { :type => 'Copyright', :text => 'Copyright 2017 i-mobile Corp. All Rights Reserved.' }
  s.author           = 'i-mobile Corporation'
  s.source           = { :http => 'https://github.com/imobile-maio/maio-iOS-SDK/releases/download/v1.2.18/Maio.framework.zip',
                         :flatten => true,
                         :type => 'zip' }

  s.vendored_frameworks = 'Maio.framework'

  s.platform = :ios
  s.ios.deployment_target = '6.0'

  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.frameworks = 'UIKit', 'CoreMedia', 'AVFoundation', 'SystemConfiguration', 'MobileCoreServices', 'AdSupport', 'StoreKit'
end
