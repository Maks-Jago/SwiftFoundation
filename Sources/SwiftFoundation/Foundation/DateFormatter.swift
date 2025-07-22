//===--- DateFormatter.swift ----------------------------------------------===//
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

public extension DateFormatter {
    /// An ISO 8601 date formatter (e.g., "2024-07-16T14:30:00Z").
    static let iso8601: ISO8601DateFormatter = .init()
    
    /// A date formatter with a medium date style (e.g., "Jul 16, 2024").
    static let medium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    /// A date formatter with a full date style (e.g., "Tuesday, July 16, 2024").
    static let full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    /// A date formatter with a medium date style and short time style (e.g., "Jul 16, 2024 at 2:30 PM").
    static let mediumWithTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    /// A date formatter that formats the month in full (e.g., "January").
    static let monthFull: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    /// A date formatter that formats the month in short (e.g., "Jan").
    static let monthShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
    /// A date formatter that formats the weekday in full (e.g., "Monday").
    static let weekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    /// A date formatter that formats the weekday in short (e.g., "Mon").
    static let weekdayShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    /// A date formatter that formats the year (e.g., "2024").
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    /// A date formatter that formats only the time in 24-hour format (e.g., "14:30").
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    /// A date formatter that formats the full date with short weekday (e.g., "Mon 15.07.2024").
    static let fullDateAndDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd.MM.yyyy"
        return formatter
    }()
    
    /// A date formatter that formats the full date (e.g., "15.07.2024").
    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    /// A date formatter that formats the full date with short year (e.g., "15.07.24").
    static let fullDateShortYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    /// A date formatter that formats the day and month with single-digit month (e.g., "15.7.2024").
    static let shortMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.M.yyyy"
        return formatter
    }()
    
    /// A date formatter that formats the time in 12-hour format with AM/PM (e.g., "2:30 PM").
    static let timeOnly12Hours: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    /// A date formatter that formats the full month with year (e.g., "July 2024").
    static let fullMonthWithYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    /// A date formatter that formats only the day (e.g., "15").
    static let shortDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    /// A date formatter that formats the date as day, month name, and year (e.g., "15 Jul 2024").
    static let dayMonthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
}

public extension DateFormatter {
    /// Returns a string representation of the given date using `timeOnly`.
    static func time(for date: Date) -> String {
        timeOnly.string(from: date)
    }
    
    /// Returns a string representation of the given date using `timeOnly12Hours`.
    static func time12hours(for date: Date) -> String {
        timeOnly12Hours.string(from: date)
    }
    
    /// Returns a string representation of the given date using `fullDateAndDay`.
    static func fullDateAndDay(for date: Date) -> String {
        fullDateAndDay.string(from: date)
    }
    
    /// Returns a string representation of the given date using `fullDate`.
    static func fullDate(for date: Date) -> String {
        fullDate.string(from: date)
    }
    
    /// Returns a string representation of the given date using `fullDateShortYear`.
    static func fullDateShortYear(for date: Date) -> String {
        fullDateShortYear.string(from: date)
    }
    
    /// Returns a string representation of the given date using `shortMonth`.
    static func shortMonthDate(for date: Date) -> String {
        shortMonth.string(from: date)
    }
    
    /// Returns a string representation of the given date using `fullMonthWithYear`.
    static func fullMonthWithYear(for date: Date) -> String {
        fullMonthWithYear.string(from: date)
    }
    
    /// Returns a string representation of the given date using `weekdayShort`.
    static func shortWeekDay(for date: Date) -> String {
        weekdayShort.string(from: date)
    }
    
    /// Returns a string representation of the given date using `shortDay`.
    static func shortDay(for date: Date) -> String {
        shortDay.string(from: date)
    }
    
    /// Returns a string representation of the given date using `monthShort`.
    static func shortMonth(for date: Date) -> String {
        monthShort.string(from: date)
    }
    
    /// Returns a string representation of the given date using `year`.
    static func year(for date: Date) -> String {
        year.string(from: date)
    }
    
    /// Returns a string representation of the given date using `dayMonthYear`.
    static func dayMonthYear(for date: Date) -> String {
        dayMonthYear.string(from: date)
    }
    
    /// Returns a string representation of the given date using `medium`.
    static func medium(for date: Date) -> String {
        medium.string(from: date)
    }
    
    /// Returns a string representation of the given date using `full`.
    static func full(for date: Date) -> String {
        full.string(from: date)
    }
    
    /// Returns a string representation of the given date using `mediumWithTime`.
    static func mediumWithTime(for date: Date) -> String {
        mediumWithTime.string(from: date)
    }
    
    /// Returns a string representation of the given date using `monthFull`.
    static func fullMonth(for date: Date) -> String {
        monthFull.string(from: date)
    }
    
    /// Returns a string representation of the given date using `weekday`.
    static func weekday(for date: Date) -> String {
        weekday.string(from: date)
    }
    
    /// Returns an ISO 8601 formatted string representation of the given date.
    static func iso8601String(for date: Date) -> String {
        (iso8601 as ISO8601DateFormatter).string(from: date)
    }
}
