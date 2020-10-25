//
//  NSSortDescriptor.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension NSSortDescriptor {
    static func byId(asending: Bool = true) -> NSSortDescriptor { NSSortDescriptor(key: "id", ascending: asending) }
}
