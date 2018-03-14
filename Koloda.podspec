Pod::Spec.new do |s|
s.name             = "Koloda"
s.version          = ‘4.3.2’
s.summary          = "KolodaView is a class designed to simplify the implementation of Flip like cards on iOS. "

s.homepage         = "https://github.com/Eratos1122/Koloda"
s.license          = 'MIT'
s.author           = "Yalantis"
s.source           = { :git => "https://github.com/Eratos1122/Koloda.git", :tag => s.version }
s.social_media_url = 'http://www.flip.dating'

s.platform     = :ios, '8.0'
s.source_files = 'Pod/Classes/**/*'

s.frameworks = 'UIKit'
s.dependency 'pop', '~> 1.0'
end
