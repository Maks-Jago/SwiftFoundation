//
//  UserDefaults+SafetyStorage.swift
//  
//
//  Created by Max Kuznetsov on 27.09.2021.
//

import Foundation

extension UserDefaults: SafetyStorage {

    public func save<T>(_ object: T, key: String) throws where T: Encodable {
        let data = try JSONEncoder().encode(object)
        self.set(data, forKey: key)
    }

    public func load<T: Decodable>(key: String) throws -> T? {
        guard let data = self.data(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    public func remove(key: String) throws {
        self.set(nil, forKey: key)
    }

    public func saveString(_ string: String?, key: String) throws {
        if let string = string {
            self.set(string, forKey: key)
        } else {
            try self.remove(key: key)
        }
    }

    public func loadString(key: String) throws -> String? {
        self.value(forKey: key) as? String
    }
}
