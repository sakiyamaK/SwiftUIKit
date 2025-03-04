# SwiftUIKit

[![Swift](https://img.shields.io/badge/Swift-5-orange?style=flat-square)](https://img.shields.io/badge/Swift-5-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_-yellowgreen?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
[![Twitter](https://img.shields.io/badge/twitter-@sakiyamaK-blue.svg?style=flat-square)](https://twitter.com/sakiyamaK)

UIKitとSwiftUIを簡単に連携するライブラリ


# Sample

## UIKit Integration in SwiftUI

```swift
import SwiftUI
import UIKit
import SwiftUIKit

struct UseUIKitInSwiftUIView: View {
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
                    /***
                     UIKit Component
                     **/
                    label1.view()
                    button1.view()
                }

                // pattern 2
                VStack {
                    /***
                     UIKit Component
                     **/
                    UIKitView {
                        label2
                    }
                    .fixedSize()

                    /***
                     UIKit Component
                     **/
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
        }.navigationTitle("SwiftUI")
    }
}

```

<img width="259" alt="Image" src="https://github.com/user-attachments/assets/0fafbb42-5ceb-4071-90de-4653789f6ed1" />

## SwiftUI Integration in UIKit

```swift

import UIKit
import SwiftUI
import SwiftUIKit

final class UseSwiftUIInViewController: UIViewController {

    private lazy var stackView = createStackView(spacing: 100)
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = "UILabel Hello, world!"
        return label
    }()
    private lazy var button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "UIButton Hello, world!"
        let button = UIButton(configuration: config)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "UIViewController"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(stackView)
        setupConstraint()

        stackView.addArrangedSubviews([
            createStackView().addArrangedSubviews([
                label,
                button,
            ]),

            // pattern 1
            createStackView().addArrangedSubviews([
                /***
                SwiftUI Component
                 ***/
                Text("Text Hello, world!").uiView(),
                Button("Button Hello, world!") {}.uiView()

            ]),

            // pattern 2
            SwiftUIView {
                /***
                SwiftUI Component
                 ***/
                VStack {
                    Text("Text Hello, world!")
                    Button("Button Hello, world!") {}
                }
            }
        ])
    }
}

private extension UseSwiftUIInViewController {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func createStackView(spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

}
extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach { addArrangedSubview($0) }
        return self
    }
}
```

<img width="259" alt="Image" src="https://github.com/user-attachments/assets/016e5f0c-6705-41d0-b974-64c71cea3dc3" />

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
