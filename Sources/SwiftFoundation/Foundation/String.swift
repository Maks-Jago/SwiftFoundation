//
//  String.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

public extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
    
    func toData(using: Encoding = .utf8) -> Data? {
        self.data(using: using)
    }
}

// MARK: - Identifiable
extension String: Identifiable {
    public var id: String { self }
}

// MARK: - Base64
public extension String {
    func toBase64() -> String {
        Data(self.utf8).base64EncodedString()
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: - Format
public extension String {
    func format(parameters: CVarArg...) -> String {
        return String(format: self, arguments: parameters)
    }
}
