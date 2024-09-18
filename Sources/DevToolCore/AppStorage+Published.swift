//
//  PublishedAppStorage.swift
//  DevTool
//
//  Created by Lova on 2024/9/18.
//



@propertyWrapper
struct PublishedAppStorage<Value: Codable> {
    @AppStorage private var storage: Data
    private let subject = PassthroughSubject<Value, Never>()
    private let key: String
    private let defaultValue: Value

    var wrappedValue: Value {
        get {
            guard let data = try? JSONDecoder().decode(Value.self, from: storage) else {
                return self.defaultValue
            }
            return data
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                self.storage = encodedData
                UserDefaults.standard.set(encodedData, forKey: key)
                self.subject.send(newValue)
            }
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        self.subject.eraseToAnyPublisher()
    }

    init(wrappedValue defaultValue: Value, _ key: String) {
        self.defaultValue = defaultValue
        self.key = key
        self._storage = AppStorage(wrappedValue: Data(), key)
        if let savedData = UserDefaults.standard.data(forKey: key) {
            self.storage = savedData
        } else {
            self.storage = (try? JSONEncoder().encode(defaultValue)) ?? Data()
        }
    }
}