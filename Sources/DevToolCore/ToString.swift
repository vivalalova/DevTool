//
//  ToString.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
extension Data {
    var string: String? {
        String(data: self, encoding: .utf8)
    }
}
