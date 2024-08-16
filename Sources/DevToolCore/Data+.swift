//
//  File 2.swift
//
//
//  Created by Lova on 2024/6/13.
//

import Foundation

public
extension Data {
    var string: String? {
        String(data: self, encoding: .utf8)
    }

    func toCollection<T: Collection>() -> T? {
        let collection = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed)
        return collection as? T
    }

    func toArray<T: Collection>() -> [T] {
        self.toCollection() ?? []
    }
}
