//
//  Equatable+isIn.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
extension Equatable {
    func isIn(_ cases: Self...) -> Bool {
        cases.contains(self)
    }

    func isIn(_ cases: [Self]) -> Bool {
        cases.contains(self)
    }

    func isNotIn(_ cases: Self...) -> Bool {
        !cases.contains(self)
    }
}
