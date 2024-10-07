//===--- SafetyStorage.swift ----------------------------------------------===//
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

/// A protocol that defines a safe storage mechanism for encoding, decoding, and managing data.
public protocol SafetyStorage {
    
    /// Saves an encodable object to storage.
    /// - Parameters:
    ///   - object: The object to save, which conforms to the `Encodable` protocol.
    ///   - key: A unique key to identify the stored object.
    /// - Throws: An error if the object cannot be encoded or saved.
    func save<T: Encodable>(_ object: T, key: String) throws
    
    /// Loads a decodable object from storage.
    /// - Parameter key: The key that identifies the stored object.
    /// - Returns: The decoded object, or `nil` if the object cannot be found or decoded.
    /// - Throws: An error if the object cannot be decoded.
    func load<T: Decodable>(key: String) throws -> T?
    
    /// Removes an object from storage.
    /// - Parameter key: The key that identifies the object to be removed.
    /// - Throws: An error if the object cannot be removed.
    func remove(key: String) throws
    
    /// Saves a string to storage.
    /// - Parameters:
    ///   - string: The string to save. If `nil`, the existing value for the key will be removed.
    ///   - key: A unique key to identify the stored string.
    /// - Throws: An error if the string cannot be saved.
    func saveString(_ string: String?, key: String) throws
    
    /// Loads a string from storage.
    /// - Parameter key: The key that identifies the stored string.
    /// - Returns: The string, or `nil` if the string cannot be found.
    /// - Throws: An error if the string cannot be loaded.
    func loadString(key: String) throws -> String?
}
