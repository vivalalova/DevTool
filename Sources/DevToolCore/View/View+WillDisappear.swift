//
//  View+WillDisappear.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

struct WillDisappearHandler: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    let onWillDisappear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
        context.coordinator
    }

    func updateUIViewController(_: UIViewControllerType, context _: UIViewControllerRepresentableContext<Self>) {
        //
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onWillDisappear: self.onWillDisappear)
    }

    class Coordinator: UIViewControllerType {
        let onWillDisappear: () -> Void

        init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.onWillDisappear()
        }
    }
}

struct WillDisappearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(WillDisappearHandler(onWillDisappear: self.callback))
    }
}

public
extension View {
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillDisappearModifier(callback: perform))
    }
}
