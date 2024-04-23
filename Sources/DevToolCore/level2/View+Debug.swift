//
//  View+Debug.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public
extension View {
    /// 在debug的時候顯示border
    func debug(_ prefix: String = "debug", color: Color = .blue) -> some View {
        #if DEBUG
        border(color)
            .onSizeChangePrint(prefix)
        #else
        self
        #endif
    }
}

public
extension View {
    /// print change
    @available(iOS 16.4, *)
    func debug<Root, T: Equatable>(_ prefix: String = "debug", printChange keyPath: KeyPath<Root, T>, on: Root) -> some View {
        #if DEBUG
        onChange(of: on[keyPath: keyPath]) { newValue in
            print(prefix, keyPath.debugDescription, newValue)
        }
        #else
        self
        #endif
    }
}
