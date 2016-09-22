Pod::Spec.new do |s|

  s.name         = "LYCLocalization"
  s.version      = "0.0.1"
  s.summary      = "Swift Localization for iOS"

  s.description  = "Written in Swift for localizing your iOS app."
                   

  s.homepage     = "https://github.com/ismaelliang/LYCLocalization"

  s.license      = "MIT"

  s.author       = { "ismaelliang" => "ismaelliang@gmail.com" }

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/ismaelliang/LYCLocalization.git", :tag => "#{s.version}" }


  s.source_files  = "LYCLocalization/"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

end
