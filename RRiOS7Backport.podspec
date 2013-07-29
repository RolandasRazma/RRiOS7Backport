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

  s.frameworks          = 'GameKit', 'QuartzCore', 'CoreGraphics'

  s.platform            = :ios, '5.0'
  s.requires_arc        = true
  s.prefix_header_file  = 'RRiOS7Backport/Prefix.pch'
  s.source_files        = 'RRiOS7Backport/**/*.{h,m}'

end
