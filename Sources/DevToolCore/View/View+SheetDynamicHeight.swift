//
//  SheetDynamicHeight.swift
//
//  Created by Lova on 2024/3/29.
//
import SwiftUI

public
extension View {
    /// Dynamic present size for sheet
    ///
    /// ```
    /// .sheet(isPresented: $flag) {
    ///     FooView()
    ///         .padding()
    ///         .presentationDragIndicator(.visible)
    ///         .presentationDynamicHeight()
    /// }
    /// ```
    func presentationDynamicHeight() -> some View {
        modifier(SheetDynamicHeight())
    }
}

struct SheetDynamicHeight: ViewModifier {
    @State var viewSize: CGSize = .zero

    func body(content: Content) -> some View {
        ScrollView {
            content
                .onSizeChange(self.$viewSize)
        }
        .scrollDisabled(true)
        .presentationDetents([.height(self.viewSize.height)])
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        Text("hello")
    }
    .sheet(isPresented: .constant(true)) {
        Text("world")
            .presentationDragIndicator(.visible)
            .presentationBackground(.yellow)
            .padding()
            .presentationDynamicHeight()
    }
}
