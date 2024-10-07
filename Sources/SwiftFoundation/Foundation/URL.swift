//===--- URL.swift --------------------------------------------------------===//
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

// MARK: - Identifiable
extension URL: Identifiable {
    /// The unique identifier for the URL, represented by its absolute string.
    public var id: String { absoluteString }
}

public extension URL {
    /// Returns the first value from the URL's query parameters.
    /// - Returns: The first query parameter value, or `nil` if no query parameters are present.
    var queryFirstValue: String? {
        queryDict[queryDict.keys.first ?? ""]
    }
    
    /// Returns a dictionary of the URL's query parameters.
    /// - Returns: A dictionary where the keys are the parameter names and the values are the parameter values.
    var queryDict: [String: String] {
        var dict: [String: String] = [:]
        
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    if let value = item.value {
                        dict[item.name] = value
                    }
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
