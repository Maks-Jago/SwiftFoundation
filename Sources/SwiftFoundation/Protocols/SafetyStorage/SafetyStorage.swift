//
//  SafetyStorage.swift
//  
//
//  Created by Max Kuznetsov on 01.04.2021.
//

import Foundation

public protocol SafetyStorage {
    func save<T: Encodable>(_ object: T, key: String) throws
    func load<T: Decodable>(key: String) throws -> T?
    func remove(key: String) throws
    
    func saveString(_ string: String?, key: String) throws
    func loadString(key: String) throws -> String?
}
