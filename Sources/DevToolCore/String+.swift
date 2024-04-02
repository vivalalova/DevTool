//
//  String+.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
extension String {
    var url: URL? {
        URL(string: self)
    }

    var int: Int? {
        Int(self)
    }
}
