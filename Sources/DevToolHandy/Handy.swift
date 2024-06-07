//
//  Handy.swift
//
//  Created by Lova on 2024/3/29.
//

import DevToolCore
import SmartCodable

public
protocol Handy: SmartCodable, Hashable, Identifiable {
    var id: String { get }
}

public
extension Handy {
    var id: String { hashValue.string }
}

extension SmartDecodable where Self: SmartEncodable {
    func merging(another: Self) -> Self {
        guard let dict1 = self.toDictionary() else {
            return another
        }

        guard let dict2 = another.toDictionary() else {
            return self
        }

        let newDict = dict1.merging(another: dict2)

        guard let new = Self.deserialize(from: newDict) else {
            return self
        }

        return new
    }
}

public
extension [String: Any] {
    func merging(another: Self) -> Self {
        self.merging(another) { old, new in
            guard let old = old as? [String: Any], let new = new as? [String: Any] else {
                return new
            }

            return old.merging(another: new)
        }
    }
}
