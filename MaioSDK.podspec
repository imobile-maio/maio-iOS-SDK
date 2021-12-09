sdk_version = '1.6.0'

Pod::Spec.new do |s|
  s.name             = 'MaioSDK'
  s.version          = sdk_version
  s.summary          = 'MaioSDK for iOS'
  s.description      = <<-DESC
MaioSDK is Ad SDK of fullscreen movie
                       DESC

  s.homepage         = 'https://maio.jp'
  s.license          = { :type => 'Copyright', :text => 'Copyright 2015 i-mobile' }
  s.author           = 'i-mobile'
  s.source           = { :http => "https://github.com/imobile-maio/maio-iOS-SDK/releases/download/v#{sdk_version}/Maio.xcframework.zip",
                         :type => 'zip' }

  s.vendored_frameworks = 'Maio.xcframework'

  s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.frameworks = 'UIKit', 'CoreMedia', 'AVFoundation', 'SystemConfiguration', 'MobileCoreServices', 'AdSupport', 'StoreKit', 'WebKit'
  s.library = 'z'
end
