//===--- Bool.swift -------------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import Foundation

public extension Bool {
    /// Initializes a `Bool` from an `Int` value.
    /// - Parameter value: The integer value to convert. `0` becomes `false`, any other value becomes `true`.
    init(_ value: Int) {
        self = (value == 0) ? false : true
    }
}

public extension Bool {
    /// Toggles the current boolean value.
    mutating func toggle() {
        self = !self
    }
}
