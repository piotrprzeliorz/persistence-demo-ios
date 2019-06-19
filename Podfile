platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def libraries
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Dip', '~> 7.0.1'
end

def test_libraries
  pod 'RxTest', '~> 5'
end

target 'PersistenceDemo' do
  libraries
end

target 'PersistenceDemoTests' do
  test_libraries
  libraries
end
