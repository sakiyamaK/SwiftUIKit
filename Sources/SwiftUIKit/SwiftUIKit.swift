// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import SwiftUI

// UIKit -> SwiftUI
public struct UIKitView: UIViewRepresentable {
    public var bodyBuilder: () -> UIView
    public var updateBuilder: () -> Void = { }
    public init(bodyBuilder: @escaping () -> UIView, updateBuilder: @escaping () -> Void = { }) {
        self.bodyBuilder = bodyBuilder
        self.updateBuilder = updateBuilder
    }
    public func makeUIView(context: Context) -> UIView {
        bodyBuilder()
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        updateBuilder()
    }
}

public extension UIView {
    func view (
        isFixedSize: Bool = true,
        updateBuilder: @escaping () -> Void = { }
    ) -> some View {
        let view = UIKitView(
            bodyBuilder: { self },
            updateBuilder: updateBuilder
        )
        return  Group {
            if isFixedSize {
                view.fixedSize()
            } else {
                view
            }
        }
    }
}

// SwiftUI -> UIKit
@MainActor
public func SwiftUIView<Content: View>(bodyBuilder: @escaping () -> Content) -> UIView {
    UIHostingConfiguration {
        _SwiftUIView(bodyBuilder: bodyBuilder)
    }
    .margins(.all, 0)
    .makeContentView()
}

struct _SwiftUIView<Content: View>: View {
    var bodyBuilder: () -> Content

    var body: some View {
        bodyBuilder()
    }
}

public extension View {
    func uiView() -> UIView {
        SwiftUIView(bodyBuilder: { self })
    }
}
