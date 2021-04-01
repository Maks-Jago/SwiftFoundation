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

@propertyWrapper
public final class SafetyValue<T: Codable> {
    public var defaultValue: T
    public var key: String
    public var storage: SafetyStorage
    
    public init(key: String, defaultValue: T, storage: SafetyStorage) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    public var wrappedValue: T {
        get { (try? storage.load(key: key)) ?? defaultValue }
        set { try? storage.save(newValue, key: key) }
    }
}
