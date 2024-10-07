//===--- Int.swift --------------------------------------------------------===//
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

public extension Int {
    /// Initializes an `Int` from a `Bool` value.
    /// - Parameter value: The boolean value to convert. Returns `1` if `true` and `0` if `false`.
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}
