source 'git@github.com:DoubleNode/SpecsPrivateRepo.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

inhibit_all_warnings!

platform :ios, '10.0'

target 'DNCDataObjectConversions' do
  # Pods for DNCDataObjectConversions
  pod 'DNCore'
  pod 'DNCDataObjects'
  
  target 'DNCDataObjectConversionsTests' do
    inherit! :search_paths

    # Pods for testing
    pod 'Gizou', :git => "git@github.com:doublenode/Gizou.git"
    pod 'OCMock'
  end

end
