//
//  File.swift
//
//
//  Created by Lova on 2024/4/8.
//

import Foundation

public
extension Encodable {
    var encoder: JSONEncoder { JSONEncoder() }

    func toDict() -> [String: Any]? {
        self.data?.toCollection()
    }

    func toJSONString(pretty: Bool = false) -> String? {
        self.data?.string
    }

    var data: Data? {
        if let data = self as? Data {
            return data
        }

        return try? self.encoder.encode(self)
    }
}

public
extension Decodable {
    private static var decoder: JSONDecoder { JSONDecoder() }

    static func array(from string: String?) -> [Self] {
        let data = string?.data(using: .utf8)

        return self.array(from: data)
    }

    static func array(from dict: [Any]?) -> [Self] {
        guard let dict, let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return []
        }

        return self.array(from: jsonData)
    }

    static func array(from data: Data?) -> [Self] {
        guard let data else {
            return []
        }

        do {
            return try JSONDecoder().decode([Self].self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            print("keyNotFound", key, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("typeMismatch", type, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("valueNotFound", value, context)
        } catch let DecodingError.dataCorrupted(context) {
            print("dataCorrupted", context)
        } catch {
            print(error)
        }

        return []
    }

    static func model(from string: String?) -> Self? {
        guard let data = string?.data(using: .utf8) else {
            return nil
        }

        return self.model(from: data)
    }

    static func model(from data: Data?) -> Self? {
        guard let data else {
            return nil
        }

        do {
            return try self.decoder.decode(self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            print("keyNotFound", key, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("typeMismatch", type, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("valueNotFound", value, context)
        } catch let DecodingError.dataCorrupted(context) {
            print("dataCorrupted", context)
        } catch {
            print(error)
        }

        return nil
    }
}
