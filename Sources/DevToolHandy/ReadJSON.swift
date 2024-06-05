//
//  ReadJSON.swift
//
//  Created by Lova on 2024/3/29.
//

import Foundation
import HandyJSON

public
/// For Preview Content
struct JSON<T: HandyJSON> {
    private static func string(_ name: String) -> String? {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }

        return try? String(contentsOfFile: bundlePath)
    }

    public static func read(_ name: String) -> T? {
        let jsonString = string(name)

        return JSONDeserializer.deserializeFrom(json: jsonString)
    }

    public static func read(_ name: String) -> [T] {
        let jsonString = string(name)

        return JSONDeserializer.deserializeModelArrayFrom(json: jsonString)?
            .compactMap { $0 } ?? []
    }
}
