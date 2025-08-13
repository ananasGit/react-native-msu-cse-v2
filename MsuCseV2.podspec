require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "MsuCseV2"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/ananasGit/react-native-msu-cse-v2.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{m,mm,cpp,swift}"
  s.public_header_files = "ios/**/*.h"
  
  s.pod_target_xcconfig = {
    "DEFINES_MODULE" => "YES",
    "SWIFT_OBJC_INTERFACE_HEADER_NAME" => "MsuCseV2-Swift.h",
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
  }
  
  s.compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

  install_modules_dependencies(s)
end
