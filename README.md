# SwiftUIKit

[![Swift](https://img.shields.io/badge/Swift-5-orange?style=flat-square)](https://img.shields.io/badge/Swift-5-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_-yellowgreen?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
[![Twitter](https://img.shields.io/badge/twitter-@sakiyamaK-blue.svg?style=flat-square)](https://twitter.com/sakiyamaK)

UIKitとSwiftUIを簡単に連携するライブラリ


```swift
import SwiftUI
import UIKit
import SwiftUIKit

struct ContentView: View {
    var body: some View {

        let label1 = UILabel(frame: .zero)
        label1.text = "UILabel Hello, world!"

        var config1 = UIButton.Configuration.plain()
        config1.title = "UIButton Hello, world!"
        let button1 = UIButton(configuration: config1)

        let label2 = UILabel(frame: .zero)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "UILabel2 Hello, world!"

        var config2 = UIButton.Configuration.plain()
        config2.title = "UIButton Hello, world!"
        let button2 = UIButton(configuration: config2)

        return VStack(spacing: 100) {

            // pattern 1
            VStack {
                label1.view()
                button1.view()
            }

            // pattern 2
            VStack {
                UIKitView {
                    label2
                }
                .fixedSize()

                UIKitView {
                    button2
                }
                .fixedSize()
            }

            /*
             *** layout crash ***
             *** Do NOT use UIStackView ***
            UIKitView {
                let stackView = UIStackView(arrangedSubviews: [label2, button2])
                stackView.axis = .vertical
                stackView.alignment = .center
                return stackView
            }
             */

            VStack {
                Text("Text Hello, world!")
                Button("Button Hello, world!") {}
            }
        }
    }
}

```

```swift

import UIKit
import SwiftUI
import SwiftUIKit

extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach { addArrangedSubview($0) }
        return self
    }
}

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = createStackView(spacing: 20)

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])


        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = "UILabel Hello, world!"

        var config = UIButton.Configuration.plain()
        config.title = "UIButton Hello, world!"
        let button = UIButton(configuration: config)

        stackView.addArrangedSubviews([
            createStackView().addArrangedSubviews([
                label,
                button,
            ]),
            // pattern 1
            createStackView().addArrangedSubviews([
                Text("Text Hello, world!").uiView(),
                Button("Button Hello, world!") {}.uiView()

            ]),
            // pattern 2
            SwiftUIView {
                VStack {
                    Text("Text Hello, world!")
                    Button("Button Hello, world!") {}
                }
            }
        ])
    }

    private func createStackView(spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
```

## Installation

### Swift Package Manager

Once you have your Swift package set up, adding DeclarativeUIKit as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/sakiyamaK/SwiftUIKit", .upToNextMajor(from: "0.1"))
]
```

To install DeclarativeUIKit package via Xcode

Go to File -> Swift Packages -> Add Package Dependency...
Then search for https://github.com/sakiyamaK/SwiftUIKit
And choose the version you want