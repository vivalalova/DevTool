//
//  SwiftUIView.swift
//
//
//  Created by rosalie on 2023/4/24.
//

import SwiftUI

public
extension View {
    func hidden(_ hidden: Bool) -> some View {
        self.opacity(hidden ? 0 : 1)
    }

    func refreshableOn15(action: @escaping () -> Void) -> some View {
        if #available(iOS 15.0, *) {
            return self.refreshable {
                action()
            }
        } else {
            return self
        }
    }
}
