//===--- Data+Unwrap.swift ------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import Foundation

public extension Data {
    /// Unwraps JSON data by extracting the value for a specific key.
    /// - Parameter key: The key whose value should be extracted from the JSON object.
    /// - Returns: A `Data` object containing the JSON data for the specified key, or the original data if an error occurs.
    func unwrapJSONDataBy(key: String) -> Data {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return self
        }
        
        guard let jsonByKey = json[key] else {
            return self
        }
        
        guard let newData = try? JSONSerialization.data(withJSONObject: jsonByKey, options: .fragmentsAllowed) else {
            return self
        }
        
        return newData
    }
    
    /// Applies a block to modify each JSON object within an array in the JSON data.
    /// - Parameter block: A closure that takes an `inout` dictionary representing a JSON object and modifies it.
    /// - Returns: A `Data` object containing the modified array of JSON objects, or the original data if an error occurs.
    func applyBlockForEachJSONObject(_ block: (_ json: inout [String: Any]) -> Void) -> Data {
        guard var json = try? JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]] else {
            return self
        }
        
        for (index, var jsonObject) in json.enumerated() {
            block(&jsonObject)
            json[index] = jsonObject
        }
        
        guard let newData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            return self
        }
        
        return newData
    }
    
    /// Applies a block to modify a single JSON object in the JSON data.
    /// - Parameter block: A closure that takes an `inout` dictionary representing a JSON object and modifies it.
    /// - Returns: A `Data` object containing the modified JSON object, or the original data if an error occurs.
    func applyBlockForJSONObject(_ block: (_ json: inout [String: Any]) -> Void) -> Data {
        guard var json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return self
        }
        
        block(&json)
        
        guard let newData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            return self
        }
        
        return newData
    }
}
