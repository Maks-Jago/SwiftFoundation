//===--- Errors.swift -----------------------------------------------------===//
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

/// A generic error that provides a localized error description.
public struct SomeError: LocalizedError {
    
    /// Initializes a new instance of `SomeError`.
    public init() {}
    
    /// A localized description of the error.
    public var errorDescription: String? {
        return NSLocalizedString("Some error occurred. Please try again later", comment: "Some error occurred")
    }
}

/// A custom error that allows for a user-defined error message.
public struct CustomError: LocalizedError {
    /// The custom error message.
    var text: String?
    
    /// Initializes a new instance of `CustomError`.
    /// - Parameter text: The custom error message.
    public init(text: String?) {
        self.text = text
    }
    
    /// A localized description of the error.
    public var errorDescription: String? {
        return text ?? ""
    }
}
