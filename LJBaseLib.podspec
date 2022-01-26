
Pod::Spec.new do |spec|

  spec.name         = "LJBaseLib"
  spec.version      = "0.0.2"
  spec.summary      = "all kinds of categories for iOS develop"
  spec.description  = <<-DESC
			this project provide all kinds of categories for iOS developer 
                   DESC

  spec.homepage     = "https://github.com/lujiang520/LJBaseLib.git"

  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  spec.author             = { "逯江" => "794656230@qq.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/lujiang520/LJBaseLib.git", :tag => spec.version }


  spec.source_files  = "LJBaseLib/*.{swift}"


  spec.requires_arc = true


end
