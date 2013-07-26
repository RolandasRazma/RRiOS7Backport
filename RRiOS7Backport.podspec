Pod::Spec.new do |s|
  s.name                = "RRiOS7Backport"
  s.version             = "0.0.1"
  s.summary             = "libRRiOS7Backport is an effort to backport parts of iOS7 to iOS6/iOS5"
  s.homepage            = "https://github.com/RolandasRazma/RRiOS7Backport"
  s.author              = { "Rolandas Razma" => "rolandas@razma.lt" }
  s.license      = { 
  	:type => 'MIT', 
  	:file => 'LICENSE'
  }
  
  s.source       = {
  	:git => "https://github.com/RolandasRazma/RRiOS7Backport.git", 
  	:tag => s.version.to_s
  }

  s.platform            = :ios, '5.0'
  s.requires_arc        = true
  s.source_files        = 'RRiOS7Backport/RRiOS7Backport.h'
  s.prefix_header_file  = 'RRiOS7Backport/Prefix.pch'

  s.subspec 'Core' do |sub|
    sub.source_files  = 'RRiOS7Backport/RRiOS7Backport.h'
  end

  s.subspec 'Foundation' do |sub|
    sub.dependency    'RRiOS7Backport/Core'
    sub.source_files  = 'RRiOS7Backport/Foundation/*.{h,m}'
    sub.frameworks    = 'Foundation'
    sub.xcconfig      = { 'OTHER_CFLAGS' => '-DRRiOS7BackportFoundation=1' }
  end

  s.subspec 'GameKit' do |sub|
    sub.dependency    'RRiOS7Backport/Core'
    sub.source_files  = 'RRiOS7Backport/GameKit/*.{h,m}'
    sub.frameworks    = 'GameKit'
    sub.xcconfig      = { 'OTHER_CFLAGS' => '-DRRiOS7BackportGameKit=1' }
    end

  s.subspec 'UIKit' do |sub|
    sub.dependency    'RRiOS7Backport/Core'
    sub.source_files  = 'RRiOS7Backport/UIKit/*.{h,m}'
    sub.frameworks    = 'UIKit', 'QuartzCore', 'CoreGraphics'
    sub.xcconfig      = { 'OTHER_CFLAGS' => '-DRRiOS7BackportUIKit=1' }
  end
end
