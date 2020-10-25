//
//  Bool.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension Bool {
    init(_ value: Int) {
        self = (value == 0) ? false : true
    }
}

public extension Bool {
    mutating func toggle() {
        self = !self
    }
}
