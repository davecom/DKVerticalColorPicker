Pod::Spec.new do |s|
  s.name             = 'DKVerticalColorPicker'
  s.version          = '1.0'
  s.license          = 'MIT'
  s.summary          = 'A simple iOS color picker presented as a vertical hue bar. '
  s.homepage         = 'https://github.com/davecom/DKVerticalColorPicker'
  s.social_media_url = 'https://twitter.com/davekopec'
  s.authors          = { 'David Kopec' => 'david@oaksnow.com' }
  s.source           = { :git => 'https://github.com/davecom/DKVerticalColorPicker.git', :tag => s.version }
  s.screenshot       = 'https://raw.githubusercontent.com/davecom/DKVerticalColorPicker/master/DKVerticalColorPicker.png'

  s.ios.deployment_target = '7.0'

  s.framework    = 'UIKit'
  s.source_files = 'DKVerticalColorPicker/DKVerticalColorPicker.{h,m}'
  s.requires_arc = true
end
