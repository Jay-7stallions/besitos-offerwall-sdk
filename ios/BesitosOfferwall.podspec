Pod::Spec.new do |s|
  s.name             = 'BesitosOfferwall'
  s.version          = '1.0.0'
  s.summary          = 'Besitos Offerwall Mobile SDK for iOS'
  s.homepage         = 'https://github.com/besitos-ai/offerwall-sdk'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Besitos' => 'sdk@besitos.ai' }
  s.source           = { :git => 'https://github.com/besitos-ai/offerwall-sdk.git', :tag => s.version.to_s }
  s.ios.deployment_target = '14.0'
  s.swift_version    = '5.9'
  s.source_files     = 'Sources/BesitosOfferwall/**/*.swift'
end
