//
//  PublishedAppStorage.swift
//  DevTool
//
//  Created by Lova on 2024/9/18.
//

import Combine
import SwiftUI


/// A property wrapper that combines `AppStorage` with `Codable` and `Combine` functionality.
///
/// `Storage` provides a convenient way to store and retrieve `Codable` values in `AppStorage`,
/// while also offering reactive updates through Combine.
///
/// Usage:
/// ```
/// @Storage("userPreferences") var preferences: UserPreferences = UserPreferences()
/// ```
///
/// - Note: This wrapper is marked with `@MainActor` to ensure all operations are performed on the main thread.
///
/// - Important: The wrapped value must conform to `Codable` protocol.
@propertyWrapper
@MainActor
public struct Storage<Value: Codable>: DynamicProperty {
    @AppStorage private var rawValue: String

    private let subject: CurrentValueSubject<Value, Never>
    private let defaultValue: Value

    public var wrappedValue: Value {
        get { self.getCurrentValue() }
        set { self.saveValue(newValue) }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        self.subject.eraseToAnyPublisher()
    }

    public init(wrappedValue defaultValue: Value, _ key: String) {
        self.defaultValue = defaultValue
        self._rawValue = AppStorage(wrappedValue: "", key)
        self.subject = CurrentValueSubject<Value, Never>(defaultValue)

        self.subject.send(self.wrappedValue)
    }

    private func getCurrentValue() -> Value {
        guard let data = rawValue.data(using: .utf8) else {
            return self.defaultValue
        }

        return (try? JSONDecoder().decode(Value.self, from: data)) ?? self.defaultValue
    }

    private func saveValue(_ newValue: Value) {
        guard let data = try? JSONEncoder().encode(newValue) else {
            return
        }

        self.rawValue = String(data: data, encoding: .utf8) ?? ""
        self.subject.send(newValue)
    }
}
