platform :ios, '8.0'

# Add Application pods here
pod 'couchbase-lite-ios', '~> 1.0.3.1'

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Specta'
  pod 'Expecta'
  pod 'OCMock'
  pod 'OHHTTPStubs'
end
