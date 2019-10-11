#
#  Be sure to run `pod spec lint DCNavigationController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "DCNavigationController"
  s.version      = "0.1"
  s.summary      = "A navigationController for iOS"
  s.homepage     = "https://github.com/dicesc/DCNavigationController"
  s.license      = "MIT"
  s.author             = { "diaochuan" => "dicesc@163.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/dicesc/DCNavigationController.git", :tag => "#{s.version}" }
  s.source_files  = "DCNavController/*.swift"
  s.swift_version = '4.0'

end
