Pod::Spec.new do |s|
  s.name             = 'BesitosOfferwall'
  s.version          = '1.0.0'
  s.summary          = 'Besitos Offerwall Mobile SDK for iOS'
  s.description      = 'Plug-and-play Offerwall WebView SDK for iOS. Embed the Besitos Offerwall inside any native iOS app with minimal code.'
  s.homepage         = 'https://github.com/Jay-7stallions/Besitos-Offerwall-Mobile-SDK'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Besitos' => 'sdk@besitos.ai' }
  s.source           = { :git => 'https://github.com/Jay-7stallions/Besitos-Offerwall-Mobile-SDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_version    = '5.9'
  s.source_files     = 'Sources/BesitosOfferwall/**/*.swift'
  s.resource_bundles = { 'BesitosOfferwall' => ['Sources/BesitosOfferwall/PrivacyInfo.xcprivacy'] }
end
