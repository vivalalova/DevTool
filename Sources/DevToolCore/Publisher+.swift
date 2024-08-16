//
//  Publisher+.swift
//
//  Created by Lova on 2024/3/29.
//

import Combine

public
extension Publisher where Output: Collection {
    func mapMany<Result>(_ transform: @escaping (Output.Element) -> Result) -> Publishers.Map<Self, [Result]> {
        map { $0.map(transform) }
    }
}
