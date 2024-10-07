//===--- Array.swift ------------------------------------------------------===//
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

public extension Array where Element: Encodable {
    /// Converts an array of `Encodable` elements into an array of dictionaries.
    var jsonArray: [[String: Any]] {
        compactMap { $0.dictionary }
    }
}

public extension Array {
    
    /// Returns a sorted array based on the specified key path.
    /// - Parameters:
    ///   - keyPath: The key path to the value to sort by.
    ///   - ascending: A Boolean value that determines the sort order. Default is `true`.
    /// - Returns: A sorted array.
    func sorted<T: Comparable>(keyPath: KeyPath<Element, T>, ascending: Bool = true) -> Self {
        func comparator(_ lhs: T, _ rhs: T, _ comparator: (T, T) -> Bool) -> Bool { comparator(lhs, rhs) }
        
        return sorted { comparator($0[keyPath: keyPath], $1[keyPath: keyPath], ascending ? (<) : (>)) }
    }
    
    /// Returns a sorted array based on the specified optional key path.
    /// - Parameters:
    ///   - keyPath: The key path to the optional value to sort by.
    ///   - ascending: A Boolean value that determines the sort order. Default is `true`.
    /// - Returns: A sorted array.
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
    /// Toggles the presence of an element in the array. Adds it if not present, removes it if present.
    /// - Parameter item: The element to toggle.
    mutating func toggle(_ item: Element) {
        if self.contains(item) {
            self.removeAll { $0 == item }
        } else {
            self.append(item)
        }
    }
    
    /// Returns a new array with the specified element toggled.
    /// - Parameter item: The element to toggle.
    /// - Returns: The updated array.
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
    /// Removes the first occurrence of the specified element.
    /// - Parameter element: The element to remove.
    /// - Returns: The removed element, or `nil` if not found.
    mutating func removeFirst(_ element: Element) -> Element? {
        if let index = self.firstIndex(of: element) {
            return self.remove(at: index)
        }
        return nil
    }
}

public extension Array {
    /// Safely returns the element at the specified index if it is within bounds, otherwise returns `nil`.
    /// - Parameter index: The index of the element.
    /// - Returns: The element at the specified index, or `nil` if out of bounds.
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

public extension Array {
    /// Converts the array to a dictionary using a key path.
    /// - Parameter keyPath: The key path to use as the key for each dictionary entry.
    /// - Returns: A dictionary where the keys are values from the key path and the values are elements of the array.
    func toDictionary<T>(_ keyPath: KeyPath<Element, T>) -> [T: Element] {
        self.reduce( [T: Element]() ) { (dict, element) -> [T : Element] in
            var dict = dict
            dict[element[keyPath: keyPath]] = element
            return dict
        }
    }
}

public extension Array where Element: Identifiable {
    /// Returns an array of the IDs of all elements in the array.
    var ids: [Element.ID] { map(\.id) }
}

public extension Array {
    /// Mutates each element in the array using a specified mutation function.
    /// - Parameter mutation: A function that takes an element in the array and modifies it.
    /// - Returns: An array of mutated elements.
    func mutate(_ mutation: (_ element: inout Element) -> Void) -> [Element] {
        map { element in
            var mutableElement = element
            mutation(&mutableElement)
            return mutableElement
        }
    }
}
