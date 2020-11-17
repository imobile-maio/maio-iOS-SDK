Pod::Spec.new do |spec|

  spec.name         = "MaioOB"
  spec.version      = "2.0.0-alpha"
  spec.summary      = "maio for openbidding."

  spec.description  = <<-DESC
  MaioSDK is Ad SDK of fullscreen movie.
                   DESC

  spec.homepage     = "https://maio.jp"
  spec.license      = { :type => "Copylight",:text => 'Copyright 2015 i-mobile'}
  spec.author       = "i-mobile"

  spec.source       = { :http => "https://github.com/imobile-maio/maio-iOS-SDK/releases/download/ob-alpha/MaioOB.xcframework.zip",
                        :type => 'zip' }

  spec.vendored_frameworks = "MaioOB.xcframework"

  spec.platform = :ios
  spec.ios.deployment_target = "9.0"

  spec.frameworks = "UIKit", "AVFoundation", "SystemConfiguration", "CoreTelephony", "AdSupport", "StoreKit", "WebKit", "SafariServices"

end
