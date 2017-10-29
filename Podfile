# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Briefinsta' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # DB
  pod 'RealmSwift'
  
  # Networking
  pod 'Moya'
  pod 'Kingfisher', '~> 4.0'
  
  # UI
  pod 'SnapKit'
  pod 'ManualLayout'
  
  # Logging
  #pod 'CocoaLumberjack/Swift'
  
  # Misc.
  pod 'Carte'
  
  # Pods for Briefinsta

  target 'BriefinstaTests' do
    inherit! :search_paths
    # Pods for testing
    #pod 'Quick'
    #pod 'Nimble'
  end

  target 'BriefinstaUITests' do
    inherit! :search_paths
    # Pods for testing
    #pod 'Quick'
    #pod 'Nimble'
  end

end

post_install do |installer|
  pods_dir = File.dirname(installer.pods_project.path)
  at_exit { `ruby #{pods_dir}/Carte/Sources/Carte/carte.rb configure` }
end
