//===--- Int.swift --------------------------------------------------------===//
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

public extension Int {
    /// Initializes an `Int` from a `Bool` value.
    /// - Parameter value: The boolean value to convert. Returns `1` if `true` and `0` if `false`.
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}
