Pod::Spec.new do |s|

  s.name         = "DNCDataObjectConversions"
  s.version      = "0.0.43"
  s.summary      = "A base collection of default DNCore Data Object Conversions."

  s.description  = <<-DESC
                    A base collection of default DNCore Data Object Conversions for base interactions with server Core.
                   DESC

  s.homepage     = "https://github.com/DoubleNode/Pod_DNCDataObjectConversions"
  s.license      = { :type => "PRIVATE", :file => "README.md" }

  s.author             = { "Darren Ehlers" => "me@darrenehlers.com" }
  s.social_media_url   = "http://twitter.com/ehlersd"

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/DoubleNode/Pod_DNCDataObjectConversions.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "Classes/**/*.h"

  s.requires_arc = true

  s.dependency "DNCore"
  s.dependency "DNCDataObjects"

end
