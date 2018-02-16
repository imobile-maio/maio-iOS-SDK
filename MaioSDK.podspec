sdk_version = '1.2.19'

Pod::Spec.new do |s|
  s.name             = 'MaioSDK'
  s.version          = sdk_version
  s.summary          = 'MaioSDK for iOS'
  s.description      = <<-DESC
MaioSDK is Ad SDK of fullscreen movie
                       DESC

  s.homepage         = 'https://maio.jp'
  s.license          = { :type => 'Copyright', :text => 'Copyright 2017 i-mobile Corp. All Rights Reserved.' }
  s.author           = 'i-mobile Corporation'
  s.source           = { :http => "https://github.com/imobile-maio/maio-iOS-SDK/releases/download/v#{sdk_version}/Maio.framework.zip",
                         :flatten => true,
                         :type => 'zip' }

  s.vendored_frameworks = 'Maio.framework'

  s.platform = :ios
  s.ios.deployment_target = '6.0'

  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.frameworks = 'UIKit', 'CoreMedia', 'AVFoundation', 'SystemConfiguration', 'MobileCoreServices', 'AdSupport', 'StoreKit'
end
