//===--- Formatter.swift --------------------------------------------------===//
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

public extension Formatter {
    
    /// A `NumberFormatter` that formats numbers with a grouping separator (`,`), no decimal places, and a `.` as the decimal separator.
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    /// A `NumberFormatter` that formats numbers with a grouping separator (`,`), up to two decimal places, and a `.` as the decimal separator. It uses a rounding mode of `.down`.
    static let roundingDownWithSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.roundingMode = .down
        return formatter
    }()
}
