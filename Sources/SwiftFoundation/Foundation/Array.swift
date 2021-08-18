//
//  Array.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension Array where Element: Encodable {
    var jsonArray: [[String: Any]] {
        compactMap { $0.dictionary }
    }
}

public extension Array {
    
    func sorted<T: Comparable>(keyPath: KeyPath<Element, T>, ascending: Bool = true) -> Self {
        func comparator(_ lhs: T, _ rhs: T, _ comparator: (T, T) -> Bool) -> Bool { comparator(lhs, rhs) }
        
        return sorted { comparator($0[keyPath: keyPath], $1[keyPath: keyPath], ascending ? (<) : (>)) }
    }
    
    func sorted<T: Comparable>(keyPath: KeyPath<Element, T?>, ascending: Bool = true) -> Self {
        sorted {
            guard let lhs = $0[keyPath: keyPath], let rhs = $1[keyPath: keyPath] else {
                return false
            }
            
            return ascending ? lhs < rhs : lhs > rhs
        }
    }
}

public extension Array where Element: Equatable {
    mutating func toggle(_ item: Element) {
        if self.contains(item) {
            self.removeAll { $0 == item }
        } else {
            self.append(item)
        }
    }
    
    mutating func toggled(_ item: Element) -> Self {
        if self.contains(item) {
            self.removeAll { $0 == item }
        } else {
            self.append(item)
        }
        
        return self
    }
}
