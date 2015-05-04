Pod::Spec.new do |s|
  s.name             = "HaidoraRefreshExtension"
  s.version          = "0.1"
  s.summary          = "A short description of HaidoraRefreshExtension."
  s.description      = <<-DESC
                       DESC
  s.homepage         = "https://github.com/Haidora/HaidoraRefreshExtension"
  s.license          = 'MIT'
  s.author           = { "mrdaios" => "mrdaios@gmail.com" }
  s.source           = { :git => "https://github.com/Haidora/HaidoraRefreshExtension.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.h'
  s.subspec 'Color' do |hdColor|
    hdColor.source_files = 'Pod/Classes/ExtensionColor/**/*'
  end
  s.subspec 'Gif' do |hdGif|
    hdGif.source_files = 'Pod/Classes/ExtensionGif/**/*'
    hdGif.dependency 'AnimatedGIFImageSerialization', '~> 0.2.0'
    hdGif.resource_bundles = {
        'HaidoraRefreshExtensionGif' => ['Pod/Assets/ExtensionGif/*.*']
    }
  end
#s.resource_bundles = {
#    'HaidoraRefreshExtension' => ['Pod/Assets/*.png']
#  }
  s.dependency 'HaidoraRefresh'
end
