//
//  PropertyReflectable.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
protocol PropertyReflectable {}

public extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}
