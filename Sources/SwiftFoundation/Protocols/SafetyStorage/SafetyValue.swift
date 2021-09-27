//
//  SafetyValue.swift
//  
//
//  Created by Max Kuznetsov on 27.09.2021.
//

import Foundation

@propertyWrapper
public struct SafetyValue<T: Codable> {
    public var defaultValue: T
    public var key: String
    @EquatableNoop public var storage: SafetyStorage
    private var inMemoryValue: T

    public init(key: String, defaultValue: T, storage: SafetyStorage) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        self.inMemoryValue = defaultValue
        self.inMemoryValue = self.wrappedValue
    }

    public var wrappedValue: T {
        get { (try? storage.load(key: key)) ?? defaultValue }
        set {
            inMemoryValue = newValue
            try? storage.save(newValue, key: key)
        }
    }
}

extension SafetyValue: Equatable where T: Equatable {
    public static func == (lhs: SafetyValue<T>, rhs: SafetyValue<T>) -> Bool {
        lhs.key == rhs.key &&
        lhs.inMemoryValue == rhs.inMemoryValue &&
        lhs.defaultValue == rhs.defaultValue
    }
}
