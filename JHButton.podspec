 
Pod::Spec.new do |s|
  s.name             = 'JHButton'
  s.version          = '0.2.0'
  s.summary          = '自定义图文按钮,使用masonry.'
 
  s.description      = <<-DESC
							图文按钮.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHButton.git', :tag => s.version.to_s }
 
  s.platform         = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source_files = 'JHButton/JHButton/JHButton/**/*.{h,m}'
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.requires_arc        = true
  s.dependency 'Masonry'
end
