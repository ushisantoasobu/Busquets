#
# Be sure to run `pod lib lint Busquets.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Busquets"
  s.version          = "0.1.0"
  s.summary          = "Simple Swift in-memory LRU cache"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "Simple Swift in-memory LRU cache, named Busquets"

  s.homepage         = "https://github.com/ushisantoasobu/Busquets"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "ushisantoasobu" => "babblemann.shunsee@gmail.com" }
  s.source           = { :git => "https://github.com/ushisantoasobu/Busquets.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ushisantoasobu'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Busquets'
  s.resource_bundles = {
    'Busquets' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
