//
//  UIEdgeInsets+.swift
//
//  Created by Lova on 2024/3/29.
//

import UIKit

public
extension UIEdgeInsets {
    static func padding(_ padding: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
}
