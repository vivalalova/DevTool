//
//  ReadJSON.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation
import SmartCodable

public
/// For Preview Content
struct JSON<T: SmartCodable> {
    private static func string(_ name: String) -> String? {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }

        return try? String(contentsOfFile: bundlePath)
    }

    public static func read(_ name: String) -> T? {
        let jsonString = self.string(name)

        return T.deserialize(from: jsonString)
    }

    public static func read(_ name: String) -> [T] {
        let jsonString = self.string(name)

        return [T].deserialize(from: jsonString)?.compactMap { $0 } ?? []
    }
}
