//===--- Double+SecondsConvertibleComponent.swift -------------------------===//
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

public extension Double {
    /// An enumeration representing time components that can be converted to seconds.
    enum SecondsConvertibleComponent {
        case minutes, hours, days
    }
    
    /// Converts a specified value of time into seconds.
    /// - Parameters:
    ///   - value: The time value to convert.
    ///   - from: The component of time to convert from (`minutes`, `hours`, `days`).
    /// - Returns: The equivalent time in seconds.
    static func seconds(in value: Double, _ from: SecondsConvertibleComponent) -> Double {
        switch from {
        case .days:
            return .seconds(in: value, .hours) * 24
        case .hours:
            return .seconds(in: value, .minutes) * 60
        case .minutes:
            return value * 60
        }
    }
    
    /// Converts the current time value in seconds into another time component.
    /// - Parameter component: The component to convert to (`minutes`, `hours`, `days`).
    /// - Returns: The equivalent time in the specified component.
    func secondsAs(_ component: SecondsConvertibleComponent) -> Double {
        switch component {
        case .days:
            return self.secondsAs(.hours) / 24
        case .hours:
            return self.secondsAs(.minutes) / 60
        case .minutes:
            return self / 60
        }
    }
}
