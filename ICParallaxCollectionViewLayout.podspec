Pod::Spec.new do |s|
  s.name             = "ICParallaxCollectionViewLayout"
  s.version          = "0.1.0"
  s.summary          = "A parallax header implementation with collection view"
  s.description      = <<-DESC
                       UICollectionViewFlowLayout subclass that provides a parallax header.
                       DESC
  s.homepage         = "https://github.com/iltercengiz/ICParallaxViewController"
  s.license          = 'MIT'
  s.author           = { "Ilter Cengiz" => "iltercengiz@yahoo.com" }
  s.source           = { :git => "https://github.com/iltercengiz/ICParallaxViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/iltercengiz'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'ICParallaxViewController/ICParallaxCollectionViewLayout.{h, m}'
  
  s.public_header_files = 'ICParallaxViewController/ICParallaxCollectionViewLayout.h'
end