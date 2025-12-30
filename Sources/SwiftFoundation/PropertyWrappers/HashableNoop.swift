//===--- HashableNoop.swift -----------------------------------------------===//
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

/// A property wrapper that conforms to `Hashable` but does not contribute to the hashing process.
/// It is useful when you want to conform to `Hashable` but exclude a specific property from affecting the hash value.
@propertyWrapper
public struct HashableNoop<Value: Sendable & Equatable>: Hashable, Sendable {
    /// The wrapped value of the property.
    public var wrappedValue: Value
    
    /// Initializes a new `HashableNoop` with the given value.
    /// - Parameter value: The initial value to wrap.
    public init(wrappedValue value: Value) {
        self.wrappedValue = value
    }
    
    /// A no-op implementation of the `hash(into:)` method.
    /// - Parameter hasher: The hasher to use for combining the wrapped value.
    public func hash(into hasher: inout Hasher) {}
}
