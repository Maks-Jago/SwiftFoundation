//
//  Date.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension Date {
    var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? self
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func dateByAdding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var month: Int {
        Calendar.current.component(.month,  from: self)
    }
    
    var isLastDayOfMonth: Bool {
        tomorrow.month != month
    }
    
    func setTime(from timeDate: Date) -> Date {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: timeDate)
        var result = Calendar.current.date(bySetting: .hour, value: timeComponents.hour ?? 0, of: self) ?? self
        result = Calendar.current.date(bySetting: .minute, value: timeComponents.minute ?? 0, of: result) ?? result
        return result
    }
}
