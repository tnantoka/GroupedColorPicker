Pod::Spec.new do |s|
  s.name             = 'GroupedColorPicker'
  s.version          = '0.3.6'
  s.summary          = 'Color Picker with Material Design palette.'

  s.description      = <<-DESC
                       Color picker for grouped colors like a palette of material design.
                       DESC

  s.homepage         = 'https://github.com/tnantoka/GroupedColorPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tnantoka' => 'tnantoka@bornneet.com' }
  s.source           = { :git => 'https://github.com/tnantoka/GroupedColorPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tnantoka'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GroupedColorPicker/Classes/**/*'
  s.resource_bundles = {
    'GroupedColorPicker' => ['GroupedColorPicker/Assets/*']
  }

  s.swift_version = '5.0'
end
