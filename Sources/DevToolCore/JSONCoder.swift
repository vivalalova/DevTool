//
//  File.swift
//
//
//  Created by Lova on 2024/4/11.
//

import Foundation

public
extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }

        return try self.decode(type, from: data)
    }
}
