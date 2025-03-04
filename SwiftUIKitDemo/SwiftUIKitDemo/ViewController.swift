//
//  ViewController.swift
//  SwiftUIKitDemo
//
//  Created by sakiyamaK on 2025/03/04.
//


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

#Preview {
    ViewController()
}
