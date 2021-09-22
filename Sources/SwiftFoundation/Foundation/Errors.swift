//
//  Errors.swift
//  SwiftFoundation
//
//  Created by  Vladyslav Fil on 22.09.2021.
//

import Foundation

public struct SomeError: LocalizedError {
    
    public var errorDescription: String? {
        return NSLocalizedString("Some error occurred. Please try again later", comment: "Some error occurred")
    }
}

public struct CustomError: LocalizedError {
    var text: String?
    
    public var errorDescription: String? {
        return text ?? ""
    }
}
