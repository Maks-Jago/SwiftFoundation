//===--- KeyedDecodingContainer.swift -------------------------------------===//
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

public extension CodingUserInfoKey {
    /// A key used to store custom coding keys in the `userInfo` dictionary of a `Decoder`.
    static let codingKeys = CodingUserInfoKey(rawValue: "codingKeys")
}

public extension KeyedDecodingContainer {
    
    /// A helper struct to safely decode values, providing `nil` if decoding fails.
    private struct Safe<Base: Decodable>: Decodable {
        /// The decoded value, or `nil` if decoding fails.
        public let value: Base?
        
        /// Initializes the `Safe` structure, attempting to decode the value from the decoder.
        /// - Parameter decoder: The decoder to use for decoding the value.
        public init(from decoder: Decoder) throws {
            do {
                let container = try decoder.singleValueContainer()
                self.value = try container.decode(Base.self)
            } catch {
                self.value = nil
            }
        }
    }
    
    /// Decodes a value of the specified type for the given key.
    /// - Parameters:
    ///   - key: The key that the decoded value is associated with.
    ///   - type: The type of the value to decode.
    /// - Returns: The decoded value of the specified type.
    /// - Throws: An error if the value cannot be decoded.
    func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
    /// Decodes a value of the specified type for the given key, if present.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: The decoded value of the specified type, or `nil` if the value is not present.
    /// - Throws: An error if the value cannot be decoded.
    func decodeIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
    
    /// Safely decodes a value of the specified type for the given key, returning `nil` if decoding fails.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: The decoded value, or `nil` if decoding fails.
    func decodeSafely<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
        return self.decodeSafely(T.self, forKey: key)
    }
    
    /// Safely decodes a value of the specified type for the given key, returning `nil` if decoding fails.
    /// - Parameters:
    ///   - type: The type of the value to decode.
    ///   - key: The key that the decoded value is associated with.
    /// - Returns: The decoded value, or `nil` if decoding fails.
    func decodeSafely<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = try? decode(Safe<T>.self, forKey: key)
        return decoded?.value
    }
    
    /// Safely decodes a value of the specified type for the given key, if present, returning `nil` if decoding fails.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: The decoded value, or `nil` if decoding fails or is not present.
    func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
        return self.decodeSafelyIfPresent(T.self, forKey: key)
    }
    
    /// Safely decodes a value of the specified type for the given key, if present, returning `nil` if decoding fails.
    /// - Parameters:
    ///   - type: The type of the value to decode.
    ///   - key: The key that the decoded value is associated with.
    /// - Returns: The decoded value, or `nil` if decoding fails or is not present.
    func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = try? decodeIfPresent(Safe<T>.self, forKey: key)
        return decoded?.value
    }
}
