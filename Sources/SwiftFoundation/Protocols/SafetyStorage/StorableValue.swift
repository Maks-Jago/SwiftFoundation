//===--- StorableValue.swift ----------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You are launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import Foundation

/// A property wrapper for storing and retrieving values using a `SafetyStorage` mechanism.
@propertyWrapper
public struct StorableValue<T: Codable & Sendable>: Sendable {
    /// The default value to use if no stored value is found.
    public var defaultValue: T
    /// The key used to store and retrieve the value.
    public var key: String
    /// The storage mechanism used for persisting values.
    @EquatableNoop public var storage: SafetyStorage
    /// The in-memory value of the wrapped property.
    private var inMemoryValue: T
    
    /// Initializes a new `StorableValue`.
    /// - Parameters:
    ///   - key: The key used to store and retrieve the value.
    ///   - defaultValue: The default value if no stored value is found.
    ///   - storage: The storage mechanism to use for persisting values.
    public init(key: String, defaultValue: T, storage: SafetyStorage) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        self.inMemoryValue = defaultValue
        self.wrappedValue = (try? storage.load(key: key)) ?? defaultValue
    }
    
    /// Initializes a new `StorableValue` using a key of a `RawRepresentable` type.
    /// - Parameters:
    ///   - key: The key used to store and retrieve the value, of a `RawRepresentable` type.
    ///   - defaultValue: The default value if no stored value is found.
    ///   - storage: The storage mechanism to use for persisting values.
    public init<K: RawRepresentable>(key: K, defaultValue: T, storage: SafetyStorage) where K.RawValue == String {
        self.init(key: key.rawValue, defaultValue: defaultValue, storage: storage)
    }
    
    /// The wrapped value stored in memory and persistent storage.
    public var wrappedValue: T {
        get { inMemoryValue }
        set {
            inMemoryValue = newValue
            try? storage.save(newValue, key: key)
        }
    }
}

/// Conformance to `Equatable` for `StorableValue` when `T` is also `Equatable`.
extension StorableValue: Equatable where T: Equatable {}
