//
//  UseSwiftUIInViewController.swift
//  SwiftUIKitDemo
//
//  Created by sakiyamaK on 2025/03/04.
//

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

#Preview {
    UINavigationController(rootViewController: UseSwiftUIInViewController())
}
