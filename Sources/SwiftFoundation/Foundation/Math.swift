//===--- Math.swift -------------------------------------------------------===//
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
import CoreGraphics

/// Rounds a `CGFloat` value up to the nearest integer.
/// - Parameter value: The `CGFloat` value to be rounded up.
/// - Returns: The smallest integer greater than or equal to `value`.
func ceilCGF(_ value: CGFloat) -> CGFloat {
    CGFloat(ceilf(Float(value)))
}

/// Rounds a `CGFloat` value to the nearest integer.
/// - Parameter value: The `CGFloat` value to be rounded.
/// - Returns: The integer closest to `value`.
func roundCGF(_ value: CGFloat) -> CGFloat {
    CGFloat(roundf(Float(value)))
}

/// Rounds a `CGFloat` value down to the nearest integer.
/// - Parameter value: The `CGFloat` value to be rounded down.
/// - Returns: The largest integer less than or equal to `value`.
func floorCGF(_ value: CGFloat) -> CGFloat {
    CGFloat(floorf(Float(value)))
}
