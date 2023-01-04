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

### Swift async-await

Let's say we have a view controller that invokes an async function to refresh itself on appear:
```swift
class ViewController: UIVewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Task {
            do {
                let data = try await fetchData()
                presentData(data)
            } catch {
                presentError(error)
            }
        }
    }

    private func fetchData() async throws -> DataType {
        // Some fetch logic
    }

    private func presentData(_ data: DataType) {
        // Do something
    }

    private func presentError(_ error: Error) {
        // Do something
    }
}
```

The problem here is that `Task` retains the view controller until it's finished with some result. And no pretty means to cancel it.

The package solves cancellation problem by providing the `store(in:)` function:

```swift
    let subscriptions = SubscriptionsStore()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Task { [unowned self] in
            do {
                let data = try await fetchData()
                presentData(data)
            } catch {
                presentError(error)
            }
        }
        .store(in: subscriptions)
    }
```

Note that either `unowned self` or `weak self` are necessary here to avoid a retain cycle. It's safe to use `unowned` here since the subscription is cancelled upon `SubscriptionsStore.deinit`, which is invoked when `ViewController` is deallocated.

### Combine

The same approach can be done with `Combine` publishers. The package provides the same `store(in:)` function for cancellables:

```swift
Future { promise in
    // Fulfill the promise
}
.store(in: subscriptions)
```

## Examples

Examples for the above use cases are [here](https://github.com/iharandreyev/Subscriptions/tree/main/Examples)

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

Alternatevly:
1. Go to your project settings.
2. Go to `Package Dependencies` tab
3. Click the `+` button
4. Put `https://github.com/iharandreyev/Subscriptions.git` into `Search or Enter Package URL` field
5. Click `Add Package`
6. Go to your app target
7. And add the package into `Frameworks, Libraries and Embedded Content` list

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
