//
//  IndexedCollection.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    public typealias Index = Base.Index
    public typealias Element = (index: Index, element: Base.Element)
    
    public let base: Base
    
    public init(base: Base) {
        self.base = base
    }
    
    public var startIndex: Index { base.startIndex }
    
    public var endIndex: Index { base.endIndex }
    
    public func index(after i: Index) -> Index {
        base.index(after: i)
    }
    
    public func index(before i: Index) -> Index {
        base.index(before: i)
    }
    
    public func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }
    
    public subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

public extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}

public extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
    
    func isFirstIndex(_ index: Index) -> Bool { startIndex == index }
    func isLastIndex(_ index: Index) -> Bool {
        self.index(endIndex, offsetBy: -1) == index
    }
}
