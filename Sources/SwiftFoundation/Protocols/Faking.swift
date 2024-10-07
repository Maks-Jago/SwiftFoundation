//===--- Faking.swift -----------------------------------------------------===//
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

/// A protocol for creating fake instances of types, primarily for testing purposes.
public protocol Faking {
    /// Initializes a new instance of the conforming type.
    init()
    
    /// Generates an array of fake items.
    /// - Parameter count: The number of items to generate. Defaults to 10.
    /// - Returns: An array of fake items.
    static func fakeItems(count: Int) -> [Self]
}

public extension Faking {
    
    /// Generates an array of fake items.
    /// - Parameter count: The number of items to generate. Defaults to 10.
    /// - Returns: An array of fake items.
    static func fakeItems(count: Int = 10) -> [Self] {
        (0..<count).map { _ in Self.init() }
    }
    
    /// Generates a single fake item.
    /// - Returns: A fake instance of the conforming type.
    static func fakeItem() -> Self {
        fakeItems(count: 1).first!
    }
}

public extension Faking where Self: RawRepresentable & CaseIterable {
    
    /// Initializes a new instance of the conforming type using a random case.
    init() {
        self = Self.allCases.randomElement()!
    }
}

/// Generates a generic fake item.
public func fake() { }

/// Generates a fake item with a specific type.
/// - Parameter with: The type to generate a fake item for.
public func fake<T>(_ with: T) { }

/// Generates a single fake item of a type that conforms to `Faking`.
/// - Returns: A fake instance of the type.
public func fake<T: Faking>() -> T { T.fakeItem() }

/// Generates an optional fake item of a type that conforms to `Faking`.
/// - Returns: An optional fake instance of the type.
public func fake<T: Faking>() -> T? { T.fakeItem() }

/// Generates an array of fake items of a type that conforms to `Faking`.
/// - Returns: An array of fake instances of the type.
public func fake<T: Faking>() -> [T] { T.fakeItems() }

/// Generates a fake item of a type that conforms to `Faking` using a specified identifier.
/// - Parameter id: An identifier used to generate the fake item.
/// - Returns: A fake instance of the type.
public func fake<T: Faking, ID>(_ id: ID) -> T { T.fakeItem() }

/// Generates an array of fake items of a type that conforms to `Faking`.
/// - Parameter count: The number of fake items to generate.
/// - Returns: An array of fake instances of the type.
public func fake<T: Faking>(_ count: Int) -> [T] { T.fakeItems(count: count) }

/// Generates an array of identifiers for fake items of a type that conforms to `Faking` and `Identifiable`.
/// - Parameter type: The type of the fake items.
/// - Returns: An array of identifiers for the fake items.
public func fake<T: Faking & Identifiable>(_ type: T.Type) -> [T.ID] { T.fakeItems().map(\.id) }
