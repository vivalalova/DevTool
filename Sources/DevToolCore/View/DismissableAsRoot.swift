//
//  DismissableAsRoot.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public
extension EnvironmentValues {
    typealias Block = () -> Void

    var dismissRootView: Block {
        get { self[DismissRootViewKey.self] }
        set { self[DismissRootViewKey.self] = newValue }
    }

    struct DismissRootViewKey: EnvironmentKey {
        public
        static let defaultValue: Block = {}
    }
}

public
struct DismissRootViewModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    public func body(content: Content) -> some View {
        content
            .environment(\.dismissRootView) { self.dismiss() }
    }
}

public
extension View {
    /// NavigationView的補強
    /// 掛了 dismissableAsRoot()之後
    /// child view 可以從 @Environment(\.dismissRootView) 來叫他dismiss
    ///
    /// ```
    /// struct Foo:View {
    ///   var body: some View {
    ///     VStack {
    ///         Bar()
    ///     }
    ///     .dismissableAsRoot()
    ///   }
    /// }
    ///
    ///
    ///  struct Bar:View {
    ///     @Environment(\.dismissRootView) var dismissRootView
    ///
    ///     var body: some View {
    ///         Button("") {
    ///             // 將 Foo dismiss
    ///             dismissRootView()
    ///         }
    ///     }
    ///  }
    /// ```
    ///
    ///
    func dismissableAsRoot() -> some View {
        modifier(DismissRootViewModifier())
    }
}
