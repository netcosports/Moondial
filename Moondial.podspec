Pod::Spec.new do |s|

  s.name = 'Moondial'
  s.version = '1.0.0'
  s.summary = 'Shimmer library for iOS'

  s.homepage = 'https://github.com/netcosports/Moondial'
  s.license = { :type => "MIT" }
  s.author = {
    'Dzianis Shykunets' => 'denis@origins-digital.com'
  }
  s.source = { :git => 'https://github.com/netcosports/Moondial', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.dependency 'Astrolabe', '~> 6'
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3']
  s.source_files = ['Sources/**/*.swift']

end
