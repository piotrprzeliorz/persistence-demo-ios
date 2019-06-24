platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def main_libraries

  pod 'DBDebugToolkit'

  #Reactive

  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'

  #DI
  pod 'Dip', '~> 7.0.1'

  #Helpers

  pod 'SwiftLint', '~> 0.33.0'
end

def test_libraries
  pod 'RxTest', '~> 5'
end

target 'PersistenceDemo' do
  main_libraries
end

target 'PersistenceDemoTests' do
  test_libraries
  main_libraries
end
