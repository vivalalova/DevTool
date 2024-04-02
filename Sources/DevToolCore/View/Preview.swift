//
//  Preview.swift
//  test
//
//  Created by Lova on 2022/2/7.
//

import SwiftUI

@available(iOS 15.0, *)
public struct Preview<Content: View>: View {
    var content: () -> Content

    public init(content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        self.content()
            .previewDisplayName("Light Mode")

        self.content()
            .colorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}

@available(iOS 13.0, *)
public struct PreviewComponent<Content: View>: View {
    var withDisabled: Bool

    var content: Content

    public init(withDisabled: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.withDisabled = withDisabled
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 2) {
            self.part

            if self.withDisabled {
                self.part
                    .disabled(true)
            }
        }
        .padding(2)
        .previewLayout(.sizeThatFits)
    }

    var part: some View {
        HStack(spacing: 2) {
            VStack {
                self.content
            }
            .padding()

            VStack {
                self.content.colorScheme(.dark)
            }
            .padding()
            .background(Color.black)
        }
    }
}

@available(iOS 15.0, *)
struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview {
            List {
                Text("Hello world")
            }
        }

        PreviewComponent {
            Text("Hello world")
        }
    }
}
