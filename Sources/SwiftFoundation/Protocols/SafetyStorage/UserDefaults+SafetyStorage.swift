//===--- UserDefaults+SafetyStorage.swift ---------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under Apache License v2.0
//
// See https://opensource.org/licenses/Apache-2.0 for license information
//
//===----------------------------------------------------------------------===//

import Foundation

/// Extends `UserDefaults` to conform to the `SafetyStorage` protocol,
/// allowing for the storage, retrieval, and removal of Codable objects and strings.
extension UserDefaults: SafetyStorage {
    
    /// Saves an encodable object to `UserDefaults`.
    /// - Parameters:
    ///   - object: The object to save, which conforms to `Encodable`.
    ///   - key: The key under which the object is stored.
    /// - Throws: An error if the object cannot be encoded.
    public func save<T>(_ object: T, key: String) throws where T: Encodable {
        let data = try JSONEncoder().encode(object)
        self.set(data, forKey: key)
    }
    
    /// Loads a decodable object from `UserDefaults`.
    /// - Parameter key: The key under which the object is stored.
    /// - Returns: The decoded object, or `nil` if it cannot be found.
    /// - Throws: An error if the object cannot be decoded.
    public func load<T: Decodable>(key: String) throws -> T? {
        guard let data = self.data(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /// Removes an object from `UserDefaults`.
    /// - Parameter key: The key under which the object is stored.
    /// - Throws: An error if the object cannot be removed.
    public func remove(key: String) throws {
        self.set(nil, forKey: key)
    }
    
    /// Saves a string to `UserDefaults`.
    /// - Parameters:
    ///   - string: The string to save. If `nil`, the existing value for the key will be removed.
    ///   - key: The key under which the string is stored.
    /// - Throws: An error if the string cannot be saved.
    public func saveString(_ string: String?, key: String) throws {
        if let string = string {
            self.set(string, forKey: key)
        } else {
            try self.remove(key: key)
        }
    }
    
    /// Loads a string from `UserDefaults`.
    /// - Parameter key: The key under which the string is stored.
    /// - Returns: The string, or `nil` if it cannot be found.
    public func loadString(key: String) throws -> String? {
        self.value(forKey: key) as? String
    }
}
