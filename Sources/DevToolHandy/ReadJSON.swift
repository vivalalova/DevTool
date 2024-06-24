//
//  ReadJSON.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation
import SmartCodable

public
/// For Preview Content
enum file {
    public static func string(_ name: String) -> String? {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }

        return try? String(contentsOfFile: bundlePath)
    }

    public static func jsonObject(_ name: String) -> Any? {
        guard let data = self.string(name)?.data(using: .utf8) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: data)
    }
}

public
struct JSON<T: SmartCodable> {
    public static func read(_ name: String) -> T? {
        let jsonString = file.string(name)

        return T.deserialize(from: jsonString)
    }

    public static func read(_ name: String) -> [T] {
        let jsonString = file.string(name)
        print(jsonString)
        return [T].deserialize(from: jsonString)?.compactMap { $0 } ?? []
    }
}
