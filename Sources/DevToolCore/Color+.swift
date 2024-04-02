//
//  Color+.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public
extension UIColor {
    var color: Color {
        Color(self)
    }
}

public
extension Color {
    var uiColor: UIColor {
        UIColor(self)
    }
}

public
extension UIColor {
    static func fromHex(_ hex: String) -> UIColor {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000FF) / 255
                    a = 1
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
            }
        }

        return .clear
    }

    static func light(_ lightColor: String, dark: String) -> UIColor {
        return UIColor.light(UIColor.fromHex(lightColor), dark: UIColor.fromHex(dark))
    }

    static func light(_ lightColor: UIColor, dark: UIColor) -> UIColor {
        return UIColor {
            if $0.userInterfaceStyle == .dark {
                return dark
            }
            return lightColor
        }
    }
}

@available(iOS 13.0, *)
extension Color {
    static func light(_ light: String, dark: String) -> Color {
        UIColor.light(light, dark: dark).color
    }

    static func light(_ light: String) -> Color {
        UIColor.light(light, dark: light).color
    }

    static func light(_ light: UIColor, dark: UIColor) -> Color {
        UIColor.light(light, dark: dark).color
    }
}
