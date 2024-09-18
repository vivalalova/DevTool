//
//  PublishedAppStorage.swift
//  DevTool
//
//  Created by Lova on 2024/9/18.
//

import Combine
import SwiftUI

//FIXME: not works in simulator
@propertyWrapper
public
struct PublishedAppStorage<Value: Codable> {
    @AppStorage private var storage: String
    private let subject = PassthroughSubject<Value, Never>()
    private let key: String
    private let defaultValue: Value

    public var wrappedValue: Value {
        get {
            guard let data = storage.data(using: .utf8),
                  let decodedValue = try? JSONDecoder().decode(Value.self, from: data) else {
                return self.defaultValue
            }
            return decodedValue
        }
        set {
            guard let encodedData = try? JSONEncoder().encode(newValue),
                  let encodedString = String(data: encodedData, encoding: .utf8) else {
                return
            }

            self.storage = encodedString
            UserDefaults.standard.set(encodedString, forKey: self.key)
            self.subject.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        self.subject.eraseToAnyPublisher()
    }

    public init(wrappedValue defaultValue: Value, _ key: String) {
        self.defaultValue = defaultValue
        self.key = key
        self._storage = AppStorage(wrappedValue: "", key)
        if let savedString = UserDefaults.standard.string(forKey: key) {
            self.storage = savedString
        } else if let encodedData = try? JSONEncoder().encode(defaultValue),
                  let encodedString = String(data: encodedData, encoding: .utf8) {
            self.storage = encodedString
        } else {
            self.storage = ""
        }
    }
}
