//
//  Data+Unwrap.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension Data {
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
