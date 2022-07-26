#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = "${POD_NAME}"
  s.version = "0.1.0"
  s.summary = "A short description of ${POD_NAME}."

  s.description = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage = "https://gerrit.huami.com/admin/repos/apps/ios/libs/${POD_NAME},general"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "${USER_NAME}" => "${USER_EMAIL}" }
  s.source = {
    :git => "ssh://${USER_NAME}@gerrit.huami.com:29418/apps/ios/libs/BNCSQLite",
    :tag => s.version.to_s,
  }

  s.ios.deployment_target = "10.0"

  # 如果需要支持ZeppLife需要将deployment_target设置成iOS10
  s.ios.deployment_target = "11.0"
  s.swift_version = "5.0"
  s.static_framework = true

  if ENV["IS_BINARY"]
    s.vendored_frameworks = "Carthage/Build/iOS/Static/${POD_NAME}.framework"
    s.resource = "Carthage/Build/iOS/Static/${POD_NAME}.framework/${POD_NAME}.bundle"
  else
    s.source_files = "${POD_NAME}/Classes/**/*"
    s.resource_bundle = { "${POD_NAME}" => ["${POD_NAME}/Assets/*"] }
    s.script_phase = {
      :name => "CopyBundleToFramework",
      :script => "cp -r ${TARGET_BUILD_DIR}/${POD_NAME}.bundle ${TARGET_BUILD_DIR}/${POD_NAME}.framework",
      :execution_position => "after_compile",
    }
  end

  s.pod_target_xcconfig = {
    "DEFINES_MODULE" => "YES",
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64 i386",
    "EXCLUDED_ARCHS[sdk=iphoneos*]" => "armv7",
    "BUILD_LIBRARY_FOR_DISTRIBUTION" => "YES",
  }
end
