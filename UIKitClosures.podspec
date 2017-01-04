Pod::Spec.new do |spec|
  spec.name = "UIKitClosures"
  spec.version = "0.1.0"
  spec.summary = "Adds closures to UIKit components."
  spec.homepage = "https://github.com/Infinity-James/UIKitClosures"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "James Valaitis" => 'jamesvalaitis@gmail.com' }
  spec.social_media_url = "https://twitter.com/InfinityJames"

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/Infinity-James/UIKitClosures.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "UIKitClosures/**/*.{h,swift}"
end
