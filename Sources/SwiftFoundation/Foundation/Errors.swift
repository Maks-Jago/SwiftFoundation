//
//  Errors.swift
//  SwiftFoundation
//
//  Created by  Vladyslav Fil on 22.09.2021.
//

import Foundation

struct SomeError: LocalizedError {
    
    var errorDescription: String? {
        return NSLocalizedString("Some error occurred. Please try again later", comment: "Some error occurred")
    }
}

struct CustomError: LocalizedError {
    var text: String?
    
    var errorDescription: String? {
        return text ?? ""
    }
}
