//
//  StorableValue.swift
//  
//
//  Created by Max Kuznetsov on 27.09.2021.
//

import Foundation

@propertyWrapper
public struct StorableValue<T: Codable> {
    public var defaultValue: T
    public var key: String
    @EquatableNoop public var storage: SafetyStorage
    private var inMemoryValue: T

    public init(key: String, defaultValue: T, storage: SafetyStorage) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        self.inMemoryValue = defaultValue
        self.wrappedValue = (try? storage.load(key: key)) ?? defaultValue
    }

    public init<K: RawRepresentable>(key: K, defaultValue: T, storage: SafetyStorage) where K.RawValue == String {
        self.init(key: key.rawValue, defaultValue: defaultValue, storage: storage)
    }

    public var wrappedValue: T  {
        get { inMemoryValue }
        set {
            inMemoryValue = newValue
            try? storage.save(newValue, key: key)
        }
    }
}

extension StorableValue: Equatable where T: Equatable {}
