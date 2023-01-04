<p align="center">
<br />
<img src="https://img.shields.io/github/actions/workflow/status/iharandreyev/Subscriptions/swift.yml" alt="Build Status" />
<img src="https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS-333333.svg" alt="Supported Platforms: iOS, macOS, & watchOS" />
<br />
<a href="https://github.com/apple/swift-package-manager" alt="Subscriptions on Swift Package Manager" title="Subscriptions on Swift Package Manager"><img
src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
<br />
<img src="https://img.shields.io/github/license/iharandreyev/Subscriptions" alt="MIT license"
</p>

A small package that enables convenient async tasks subscriptions management, inspired by [RxSwift.DisposeBag](https://github.com/ReactiveX/RxSwift/blob/main/RxSwift/Disposables/DisposeBag.swift)

## Usage

Please check out [examples](https://github.com/iharandreyev/Subscriptions/tree/main/Examples)

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager) 

Create a Package.swift file.

```swift
// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "ProjectName",
  dependencies: [
    .package(url: "https://github.com/iharandreyev/Subscriptions.git")
  ],
  targets: [
    .target(name: "ProjectName", dependencies: ["Subscriptions"])
  ]
)
```

```
$ swift build
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
