//
//  SwiftUIView.swift
//  SwiftUIKitDemo
//
//  Created by sakiyamaK on 2025/03/04.
//


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

#Preview {
    ContentView()
}
