//
//  Numeric.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension Numeric {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? ""
    }
    
    var roundingDownWithSeparator: String {
        Formatter.roundingDownWithSeparator.string(for: self) ?? ""
    }
}
