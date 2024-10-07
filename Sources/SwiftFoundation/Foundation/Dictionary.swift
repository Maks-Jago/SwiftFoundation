//===--- Dictionary.swift -------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under Apache License v2.0
//
// See https://opensource.org/licenses/Apache-2.0 for license information
//
//===----------------------------------------------------------------------===//

import Foundation

public extension Dictionary {
    /// Converts the dictionary to a JSON string.
    /// - Returns: A JSON string representation of the dictionary, or `nil` if the serialization fails.
    var jsonString: String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        
        return String(data: jsonData, encoding: .utf8)
    }
}
