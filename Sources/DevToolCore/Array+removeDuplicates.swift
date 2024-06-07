//
//  File.swift
//
//
//  Created by Lova on 2024/6/6.
//

import Foundation

public
extension Array where Element: Equatable {
    /// - Returns: 清除重複的element
    func removeDuplicates() -> Self {
        var result = Self()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

public
extension Array where Element: Hashable {
    /// - Returns: 清除重複的element
    func removeDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

public
extension Array {
    /// - Returns: 清除重複的element
    func removeDuplicates(by isDuplicate: (Element, Element) -> Bool) -> [Element] {
        var uniqueElements: [Element] = []

        return filter { element in
            let isUnique = !uniqueElements.contains(where: { isDuplicate($0, element) })
            if isUnique {
                uniqueElements.append(element)
            }
            return isUnique
        }
    }

    /// - Returns: 清除重複的element
    func removeDuplicates<T: Equatable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        self.removeDuplicates { a, b in
            a[keyPath: keyPath] == b[keyPath: keyPath]
        }
    }
}
