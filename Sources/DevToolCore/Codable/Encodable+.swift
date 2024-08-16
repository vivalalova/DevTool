//
//  Decode.swift
//  DevTool
//
//  Created by Lova on 2024/8/15.
//

import Foundation

extension Encodable {
    func decode<T: Decodable>(as type: T.Type) -> T? {
        if let string = self as? String {
            return try? JSONDecoder().decode(T.self, from: string)
        } else if let data {
            return try? JSONDecoder().decode(T.self, from: data)
        }

        return nil
    }

    func decode<T: Decodable>() -> T? {
        self.decode(as: T.self)
    }
}
