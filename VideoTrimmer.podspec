Pod::Spec.new do |s|
    s.name             = "VideoTrimmer"
    s.version          = "1.0.0"
    s.summary          = "A React Native module for trimming videos."
    s.description      = <<-DESC
                         VideoTrimmer is a React Native module that allows you to trim videos by specifying a start and end time. It supports iOS.
                         DESC
    s.homepage         = "https://github.com/yourusername/VideoTrimmer"
    s.license          = { :type => "MIT", :file => "LICENSE" }
    s.author           = { "Marcos L" => "marcos.sm2432@gmail.com" }
    s.source           = { :git => "https://github.com/yourusername/VideoTrimmer.git", :tag => "#{s.version}" }
    s.platform     = :ios, "10.0"
  
    s.source_files  = "ios/**/*.{h,m,swift}"
    s.requires_arc = true
  
    s.dependency "React"
    # If you have other dependencies, list them here as well. For example:
    # s.dependency "AFNetworking", "~> 4.0"
  
    # React Native libraries do not typically require frameworks.
    # s.framework  = "SomeFramework"
  
   
  