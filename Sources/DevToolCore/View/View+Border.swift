//
//  Border.swift
//  test
//
//  Created by Lova on 2022/1/10.
//

import SwiftUI

public
extension View {
    /// 蓋一個 RoundedRectangle 在上面
    func border(_ color: Color?, radius: CGFloat = 0, width: CGFloat = 1.5) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(lineWidth: width, antialiased: true)
                    .foregroundColor(color)
            )
    }
}
