//
//  NSObject+Chainable.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
protocol Chainable {}

public
extension Chainable {
    @discardableResult
    func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}

extension NSObject: Chainable {}
