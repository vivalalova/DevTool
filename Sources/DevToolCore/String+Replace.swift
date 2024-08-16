//
//  String+replace.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
extension String {
    func upperFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    func replace(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}
