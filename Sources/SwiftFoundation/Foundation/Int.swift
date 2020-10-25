//
//  Int.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension Int {
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}
