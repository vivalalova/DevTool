//
//  View+Shadow.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public
extension View {
    /// .shadow(.top) => 只顯示在上面
    func shadow(_ alignment: Alignment? = nil, radius: CGFloat? = 5, color: Color = Color.black.opacity(0.12)) -> some View {
        Group {
            if let radius {
                self.clipped()
                    .shadow(
                        color: color,
                        radius: radius,
                        x: {
                            if alignment?.isIn(.leading, .topLeading, .bottomLeading) == true {
                                return -radius - 1
                            } else if alignment?.isIn(.trailing, .topTrailing, .bottomTrailing) == true {
                                return radius + 1
                            }

                            return 0
                        }(),
                        y: {
                            if alignment?.isIn(.top, .topLeading, .topTrailing) == true {
                                return -radius - 1
                            } else if alignment?.isIn(.bottom, .bottomLeading, .bottomTrailing) == true {
                                return radius + 1
                            }

                            return 0
                        }()
                    )
            } else {
                self
            }
        }
    }
}
