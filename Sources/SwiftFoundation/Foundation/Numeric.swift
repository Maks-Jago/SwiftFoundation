//===--- Numeric.swift ----------------------------------------------------===//
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
