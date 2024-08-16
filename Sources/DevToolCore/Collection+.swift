//
//  File.swift
//
//
//  Created by Lova on 2024/4/11.
//

import Foundation

public
extension Collection {
    func data() -> Data? {
        try? JSONSerialization.data(withJSONObject: self)
    }

    func toJSONString() -> String? {
        self.data()?.string
    }
}
