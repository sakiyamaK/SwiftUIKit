//
//  ContentView.swift
//  SwiftUIKitDemo
//
//  Created by sakiyamaK on 2025/03/04.
//

import SwiftUI
import UIKit
import SwiftUIKit

struct RootView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Go to SwiftUI") {
                    UseUIKitInSwiftUIView()
                }
                NavigationLink("Go to UIKit") {
                    UIKitView {
                        UseSwiftUIInViewController().view!
                    }
                }
            }
            .navigationTitle("Home")

        }
    }
}

#Preview {
    RootView()
}
