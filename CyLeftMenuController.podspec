Pod::Spec.new do |s|

  s.name     = 'CyLeftMenuController'

  s.version  = '1.0.1'

  s.license  = { :type => 'MIT' }

  s.summary  = 'QQ 早期侧滑展开'

  s.description = <<-DESC
                   精简版左侧侧滑展开 可设置展开宽度 协议编，外部自由控制
                   DESC

  s.homepage = 'https://github.com/lanligang/NearPublicProject'

  s.authors  = { 'LenSky' => 'lslanligang@sina.com' }

  s.source   = { :git => 'https://github.com/lanligang/NearPublicProject.git', :tag => s.version }

  s.source_files = 'NearPublic/NearPublic/CyLeftMenuController/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.ios.frameworks = ['UIKit', 'CoreGraphics', 'Foundation']
end