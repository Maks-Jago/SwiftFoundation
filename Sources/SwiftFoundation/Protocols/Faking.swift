//
//  Faking.swift
//  
//
//  Created by Max Kuznetsov on 01.04.2021.
//

import Foundation

public protocol Faking {
    init()
    static func fakeItems(count: Int) -> [Self]
}

public extension Faking {
    static func fakeItems(count: Int = 10) -> [Self] {
        (0..<count).map { _ in Self.init()}
    }
    
    static func fakeItem() -> Self {
        fakeItems(count: 1).first!
    }
}

public extension Faking where Self: RawRepresentable & CaseIterable {
    init() {
        self = Self.allCases.randomElement()!
    }
}
