## Persistence Demo

Demo project made with `https://jsonplaceholder.typicode.com` API.

## Project setup

Dependencies in this project are provided via Cocoapods. Please install all dependecies with `pod install`.

- macOS 10.10+
- Xcode 10.0+
- CocoaPods 1.6.0+

## Technical decisions

### Overview

The application is based on MVVM (model–view–viewmodel) pattern. ViewModels are structuting relationships bettwen model and user input or controllers life cycles as pipeline of transformations. Respositories are implemetned for each resource with need to be stored in persistance layer. DataSources (both local/remote) also are implemented per resource. 
Connectors are used for handling navigaiton bettwen view controllers, it also allows to decouple them. Connectors got reference to dependecy container to allows them resoloving object from it.


<p align="center">
<img width="100%" src="/Images/architecture.png">
</p>
<p style="text-align: center;">  </p>

<p align="center">
  Application architecture diagram.
</p>

### Database
For persistance **Core Data** with base setup - two contexts connected to same persistent store. *Private context* is used for importing data from a web service. *Main context* is used for UI related work.

<p align="center">
<img width="33%" src="/Images/core-data-setup.png">
<p>

<p align="center">
  Core Data setup.
</p>

## Tools & Libraries

- [Sourcery](https://github.com/krzysztofzablocki/Sourcery) for code generation, used via protocols `AutoEquatable`, `AutoMockable`.The configuration is available in .sourcery.yml.
- [Swiftlint](https://github.com/realm/SwiftLint) - for enforcing code style and producing warning or errors if they are not followed, there is an additional step in the build process for running  The configuration is available in .swiftlint.yml.
- [RxSwift](https://github.com/ReactiveX/RxSwift) - for reactive programing.
- [Dip](https://github.com/AliSoftware/Dip) - for depndecy injection.
- [RxSwift](https://github.com/ReactiveX/RxSwift) - for testing rx code.
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) - for generating type-safe resources, there is an additional step in the build process for running  The configuration is available in swiftgen.yml.

## Materials 

- [CoreData](https://www.objc.io/books/core-data)
- [ViewModels](https://medium.com/blablacar-tech/rxswift-mvvm-66827b8b3f10)
- [Networking](https://talk.objc.io/collections/networking)



