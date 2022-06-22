# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

def app_pods
  pod 'Alamofire', '4.8.2'
end

def testing_pods
  pod 'Quick', '~> 4.0.0'
  pod 'Nimble', '~> 9.2.0'
end

target 'CatchTest' do
  app_pods
  
  target 'CatchTestTests' do
    inherit! :search_paths
    testing_pods
  end
  
  target 'CatchTestUITests' do
    inherit! :search_paths
    testing_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
