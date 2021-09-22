//
//  Double+SecondsConvertibleComponent.swift
//  SwiftFoundation
//
//  Created by  Vladyslav Fil on 22.09.2021.
//

import Foundation

extension Double {
    enum SecondsConvertibleComponent {
        case minutes, hours, days
    }
    
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
