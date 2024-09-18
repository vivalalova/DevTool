//
//  Numberic+.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
extension Numeric {
    var string: String {
        String(describing: self)
    }
}

public
extension Numeric {
    var powered: Self { self * self }
}

public
extension BinaryFloatingPoint {
    var int: Int { Int(self) }
}
