#
#  Be sure to run `pod spec lint GIFText.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    # 1
    s.platform = :ios
    s.ios.deployment_target = '8.0'
    s.name = "GIFText"
    s.summary = "GIFText is a text editor"
    s.requires_arc = true

    # 2
    s.version = "0.1.2"

    # 3
    s.license = { :type => "MIT", :file => "LICENSE" }

    # 4 - Replace with your name and e-mail address
    s.author = { "Eric Young" => "eric@gifit.us" }

    # For example,
    # s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }


    # 5 - Replace this URL with your own Github page's URL (from the address bar)
    s.homepage = "http://github.com/usmayoung/GIFText"

    # For example,
    # s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


    # 6 - Replace this URL with your own Git URL from "Quick Setup"
    s.source = { :git => "https://github.com/usmayoung/GIFText.git", :tag => "#{s.version}"}

    # For example,
    # s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


    # 7
    s.framework = "UIKit"
    s.dependency 'AFNetworking', '~> 2.0'
    #s.dependency 'MBProgressHUD', '~> 0.9.0'

    # 8
    s.source_files = "GIFText/**/*.{h,m}"

    # 9
    s.resources = "GIFText/**/*.{png,jpeg,jpg,storyboard,xib,ttf,bundle}"

end
