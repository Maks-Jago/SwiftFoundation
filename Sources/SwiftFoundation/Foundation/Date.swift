//===--- Date.swift -------------------------------------------------------===//
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

public extension Date {
    /// Returns a `Date` object representing yesterday.
    var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    /// Returns a `Date` object representing tomorrow.
    var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? self
    }
    
    /// Returns the start of the day for the current date.
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// Returns the end of the day for the current date.
    var endOfDay: Date? {
        let components = DateComponents(hour: 23, minute: 59, second: 59)
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    /// Returns a new date by adding a specified number of days.
    /// - Parameter days: The number of days to add.
    /// - Returns: A new `Date` object.
    func dateByAdding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    /// Returns a `Date` object set to noon on the current day.
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    /// Returns the day component of the current date.
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    /// Returns the month component of the current date.
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    /// Returns the start of the month for the current date.
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    /// Returns the end of the month for the current date.
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    /// Checks if the current date is the last day of the month.
    var isLastDayOfMonth: Bool {
        tomorrow.month != month
    }
    
    /// Sets the time of the current date using the time from another date.
    /// - Parameter timeDate: The date from which to extract the time components.
    /// - Returns: A new `Date` object with the updated time.
    func setTime(from timeDate: Date) -> Date {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: timeDate)
        var result = Calendar.current.date(bySetting: .hour, value: timeComponents.hour ?? 0, of: self) ?? self
        result = Calendar.current.date(bySetting: .minute, value: timeComponents.minute ?? 0, of: result) ?? result
        return result
    }
    
    /// Calculates the absolute difference in days between two dates.
    /// - Parameter dateFrom: The date to compare with.
    /// - Returns: The number of days between the two dates.
    func daysDiff(from dateFrom: Date) -> Int {
        abs(Calendar.current.dateComponents([.day], from: dateFrom, to: self).day ?? 0)
    }
    
    /// Enum representing components of a date to add.
    enum ComponentToAdd {
        case seconds(Int)
        case minutes(Int)
        case hours(Int)
        case days(Int)
        case weeks(Int)
        case months(Int)
        case years(Int)
        
        /// Returns a tuple containing the calendar component and its value.
        var dict: (key: Calendar.Component, value: Int) {
            switch self {
            case .seconds(let value):
                return (.second, value)
            case .minutes(let value):
                return (.minute, value)
            case .hours(let value):
                return (.hour, value)
            case .days(let value):
                return (.day, value)
            case .weeks(let value):
                return (.day, value * 7)
            case .months(let value):
                return (.month, value)
            case .years(let value):
                return (.year, value)
            }
        }
        
        /// Creates an array of `ComponentToAdd` from `DateComponents`.
        /// - Parameter components: The date components to convert.
        /// - Returns: An array of `ComponentToAdd`.
        static func from(components: DateComponents) -> [ComponentToAdd] {
            var result: [ComponentToAdd] = []
            
            if let years = components.year, years != 0 {
                result.append(.years(years))
            }
            if let months = components.month, months != 0 {
                result.append(.months(months))
            }
            if let days = components.day, days != 0 {
                result.append(.days(days))
            }
            if let hours = components.hour, hours != 0 {
                result.append(.hours(hours))
            }
            if let minutes = components.minute, minutes != 0 {
                result.append(.minutes(minutes))
            }
            if let seconds = components.second, seconds != 0 {
                result.append(.seconds(seconds))
            }
            
            return result
        }
    }
    
    func add(_ component: ComponentToAdd) -> Date {
        Calendar.current.date(byAdding: component.dict.key, value: component.dict.value, to: self) ?? self
    }
    
    private func add(_ component: ComponentToAdd, to: Date? = nil) -> Date {
        let toDate = to ?? self
        return Calendar.current.date(byAdding: component.dict.key, value: component.dict.value, to: toDate) ?? toDate
    }
    
    func add(_ components: [ComponentToAdd]) -> Date {
        var date = self
        for component in components {
            date = add(component, to: date)
        }
        return date
    }
    
    /// Adds multiple date components to the current date using variadic parameters.
    /// - Parameter components: The components to add.
    /// - Returns: A new `Date` object.
    func add(_ components: ComponentToAdd...) -> Date {
        add(components)
    }
}
