//
//  SwiftUIView.swift
//
//
//  Created by lova on 2023/12/22.
//

import SwiftUI

public
extension View {
    /// 加條件來使用modifier
    ///
    /// someView
    ///     .if(condition) { view in
    ///         view.padding(15)
    ///     }
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
