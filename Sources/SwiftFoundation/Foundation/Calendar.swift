//===--- Calendar.swift ---------------------------------------------------===//
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

public extension Calendar {
    /// Generates an array of dates within a specified date interval that match given date components.
    /// - Parameters:
    ///   - interval: The `DateInterval` within which to generate dates.
    ///   - components: The `DateComponents` to match (e.g., specific time components).
    /// - Returns: An array of `Date` objects that fall within the interval and match the specified components.
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
}
