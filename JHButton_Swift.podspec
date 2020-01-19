 
Pod::Spec.new do |s|
  s.name             = 'JHButton_Swift'
  s.version          = '0.7.0'
  s.summary          = '自定义图文按钮.'
 
  s.description      = <<-DESC
							图文按钮.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHButton.git', :tag => s.version.to_s }
 
  s.platform         = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.swift_version     = '5.1'
  s.source_files = 'JHButton/JHButton_Swift/Class/**/*'
  s.frameworks   = "UIKit" #支持的框架
  s.requires_arc        = true
  s.dependency 'SnapKit'
end
