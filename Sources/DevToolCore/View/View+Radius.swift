//
//  SwiftUIView.swift
//
//
//  Created by Lova on 2022/2/23.
//

import SwiftUI

public
extension View {
    /// 圓滑曲線 圓角
    func radius(_ r: CGFloat) -> some View {
        clipShape(RoundedRectangle(cornerRadius: r, style: .continuous))
    }
}
