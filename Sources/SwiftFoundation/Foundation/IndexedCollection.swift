//===--- IndexedCollection.swift ------------------------------------------===//
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

/// A collection wrapper that allows access to both the index and element of the base collection.
public struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    public typealias Index = Base.Index
    public typealias Element = (index: Index, element: Base.Element)
    
    /// The underlying base collection.
    public let base: Base
    
    /// Initializes an `IndexedCollection` with a base collection.
    /// - Parameter base: The base collection to wrap.
    public init(base: Base) {
        self.base = base
    }
    
    /// The starting index of the collection.
    public var startIndex: Index { base.startIndex }
    
    /// The ending index of the collection.
    public var endIndex: Index { base.endIndex }
    
    /// Returns the index after the given index.
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Index) -> Index {
        base.index(after: i)
    }
    
    /// Returns the index before the given index.
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index value immediately before `i`.
    public func index(before i: Index) -> Index {
        base.index(before: i)
    }
    
    /// Returns an index that is the specified distance from the given index.
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset.
    /// - Returns: The index offset by `distance`.
    public func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }
    
    /// Accesses the element at the specified position.
    /// - Parameter position: The position of the element to access.
    /// - Returns: A tuple containing the index and the element.
    public subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

public extension RandomAccessCollection {
    /// Returns an `IndexedCollection` containing the elements of the collection along with their indices.
    /// - Returns: An `IndexedCollection` of the current collection.
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}

public extension Collection {
    /// Returns the distance from the start of the collection to the given index.
    /// - Parameter index: The index to measure the distance to.
    /// - Returns: The distance to the specified index.
    func distance(to index: Index) -> Int {
        distance(from: startIndex, to: index)
    }
    
    /// Checks if the given index is the first index of the collection.
    /// - Parameter index: The index to check.
    /// - Returns: `true` if the index is the first index; otherwise, `false`.
    func isFirstIndex(_ index: Index) -> Bool {
        startIndex == index
    }
    
    /// Checks if the given index is the last index of the collection.
    /// - Parameter index: The index to check.
    /// - Returns: `true` if the index is the last index; otherwise, `false`.
    func isLastIndex(_ index: Index) -> Bool {
        self.index(endIndex, offsetBy: -1) == index
    }
}
