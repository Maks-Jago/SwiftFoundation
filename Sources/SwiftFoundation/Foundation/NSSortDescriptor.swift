//===--- NSSortDescriptor.swift -------------------------------------------===//
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

public extension NSSortDescriptor {
    /// Creates a sort descriptor for the `id` key.
    /// - Parameter ascending: A Boolean value that indicates whether the sort is ascending (`true`) or descending (`false`). The default value is `true`.
    /// - Returns: An `NSSortDescriptor` object that sorts by the `id` key.
    static func byId(asending: Bool = true) -> NSSortDescriptor {
        NSSortDescriptor(key: "id", ascending: asending)
    }
}
