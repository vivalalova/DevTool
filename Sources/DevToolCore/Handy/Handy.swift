//
//  Handy.swift
//
//  Created by Lova on 2024/3/29.
//

import HandyJSON

public
protocol Handy: HandyJSON, Hashable, Identifiable {
    var id: String { get }
}

public
extension Handy {
    var id: String {
        hashValue.string
    }
}

public
extension HandyJSON {
    func merging(another: Self) -> Self {
        guard let dict1 = toJSON() else {
            return another
        }

        guard let dict2 = another.toJSON() else {
            return self
        }

        let newDict = dict1.merging(another: dict2)

        guard let new: Self = JSONDeserializer.deserializeFrom(dict: newDict) else {
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
