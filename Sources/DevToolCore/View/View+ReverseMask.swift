//
//  View+ReverseMask.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public extension View {
    func reverseMask<V: View>(alignment: Alignment = .center, @ViewBuilder _ view: () -> V) -> some View {
        mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    view()
                        .blendMode(.destinationOut)
                }
        }
    }

    func reverseMask<V: View>(alignment: Alignment = .center, _ view: V) -> some View {
        mask(
            Rectangle()
                .overlay(
                    view
                        .blendMode(.destinationOut),
                    alignment: alignment
                )
        )
    }
}
