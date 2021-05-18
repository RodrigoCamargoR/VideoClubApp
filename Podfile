platform :ios, '9.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'Video Club App' do
    use_frameworks!
  # Pods for Video Club App
    
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
    pod 'Firebase/Storage'
  
    pod 'RealmSwift'

  target 'Video Club AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Video Club AppUITests' do
    # Pods for testing
  end

end

