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

public extension Array where Element: Equatable {
    mutating func removeFirst(_ element: Element) -> Element? {
        if let index = self.firstIndex(of: element) {
            return self.remove(at: index)
        }
        return nil
    }
}

public extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

public extension Array {
    func toDictionary<T>(_ keyPath: KeyPath<Element, T>) -> [T: Element] {
        self.reduce( [T: Element]() ) { (dict, element) -> [T : Element] in
            var dict = dict
            dict[element[keyPath: keyPath]] = element
            return dict
        }
    }
}

public extension Array where Element: Identifiable {
    var ids: [Element.ID] { map(\.id) }
}


public extension Array {
    func mutate(_ mutation: (_ element: inout Element) -> Void) -> [Element] {
        map { element in
            var mutableElement = element
            mutation(&mutableElement)
            return mutableElement
        }
    }
}
