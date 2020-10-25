//
//  URL.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

extension URL: Identifiable {
    public var id: String { absoluteString }
}

public extension URL {
    var queryFirstValue: String? {
        queryDict[queryDict.keys.first ?? ""]
    }
    
    var queryDict: [String: String] {
        var dict: [String : String] = [:]
        
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value!
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
