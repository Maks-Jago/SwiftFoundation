//===--- EquatableNoop.swift ----------------------------------------------===//
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

/// A property wrapper that conforms to `Equatable` but always returns `true` for equality checks.
/// This is useful when you want to conform to `Equatable` without considering the wrapped property's value in equality comparisons.
@propertyWrapper
public struct EquatableNoop<Value>: Equatable {
    /// The wrapped value of the property.
    public var wrappedValue: Value
    
    /// Initializes a new `EquatableNoop` with the given value.
    /// - Parameter value: The initial value to wrap.
    public init(wrappedValue value: Value) {
        self.wrappedValue = value
    }
    
    /// Always returns `true` when comparing two `EquatableNoop` instances, regardless of their wrapped values.
    public static func == (lhs: EquatableNoop<Value>, rhs: EquatableNoop<Value>) -> Bool { true }
}

/// Conformance to `Sendable` for `EquatableNoop` when `T` is also `Sendable`.
extension EquatableNoop: Sendable where Value: Sendable {}
