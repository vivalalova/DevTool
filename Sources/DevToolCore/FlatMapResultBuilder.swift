//
//  FlatMapResultBuilder.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation

@resultBuilder
/// 把二維陣列flatMap成一層的builder
public
enum FlatMapResultBuilder {
    /// 空的內容
    public static func buildBlock<T>() -> [T] {
        []
    }

    /// 一般狀況
    public static func buildBlock<T>(_ values: [T]...) -> [T] {
        values.flatMap { $0 }
    }

    public static func buildEither<T>(first values: [T]...) -> [T] {
        values.flatMap { $0 }
    }

    public static func buildEither<T>(second values: [T]...) -> [T] {
        values.flatMap { $0 }
    }

    public static func buildOptional<T>(_ values: [T]?) -> [T] {
        values ?? []
    }
}
