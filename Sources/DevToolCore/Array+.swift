//
//  Array+.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

public
extension Array {
    func element(_ index: Int) -> Element? {
        guard count > index else {
            return nil
        }

        return self[index]
    }

    var second: Element? {
        self.element(1)
    }

    func second(where closure: (Element) -> Bool) -> Element? {
        filter { closure($0) }.second
    }

    var third: Element? {
        self.element(2)
    }

    func third(where closure: (Element) -> Bool) -> Element? {
        filter { closure($0) }.third
    }

    var fourth: Element? {
        self.element(3)
    }

    var fifth: Element? {
        self.element(4)
    }

    func mapTo<T>(to: T) -> [T] {
        map { _ in to }
    }
}

public
extension Array where Element: Equatable {
    func secondIndex(where closure: (Element) -> Bool) -> Self.Index? {
        guard let element = filter({ closure($0) }).second else {
            return nil
        }

        return firstIndex(of: element)
    }

    func thirdIndex(where closure: (Element) -> Bool) -> Self.Index? {
        guard let element = filter({ closure($0) }).third else {
            return nil
        }

        return firstIndex(of: element)
    }
}

public
extension Array {
    func mapMany<T>(_ transform: (Element) -> [T]) -> [T] {
        flatMap(transform)
    }

    func mapMany<T>(_ keyPath: KeyPath<Element, [T]>) -> [T] {
        self.mapMany { $0[keyPath: keyPath] }
    }
}

public
extension Array {
    /// 用keyPath排序, nil放最前面, 預設升冪
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value?>) -> Self {
        self.sorted(<, by: keyPath)
    }

    /// 用keyPath排序, nil放最前面, 預設升冪
    func sorted<Value: Comparable>(_ comparator: (Value, Value) -> Bool, by keyPath: KeyPath<Element, Value?>) -> Self {
        self.sorted { a, b in
            guard let aa = a[keyPath: keyPath], let bb = b[keyPath: keyPath] else {
                return true
            }

            return comparator(aa, bb)
        }
    }
}

public
extension Array {
    /// - Returns: Self or others when self is empty
    func ifEmpty(others: [Element]) -> Self {
        guard count != 0 else {
            return others
        }

        return self
    }
}

public
extension Array {
    /// 取前面幾個
    func first(_ count: Int) -> Self {
        let toIndex = Swift.min(self.count, count) - 1

        guard toIndex > 0 else {
            return []
        }

        return Array(self[0 ... toIndex])
    }
}
