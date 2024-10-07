//===--- Numeric.swift ----------------------------------------------------===//
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

public extension Numeric {
    /// Returns a string representation of the numeric value with a grouping separator (`,`).
    /// - Uses the `Formatter.withSeparator` for formatting.
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? ""
    }
    
    /// Returns a string representation of the numeric value with a grouping separator (`,`) and rounds down to two decimal places.
    /// - Uses the `Formatter.roundingDownWithSeparator` for formatting.
    var roundingDownWithSeparator: String {
        Formatter.roundingDownWithSeparator.string(for: self) ?? ""
    }
}
