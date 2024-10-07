//===--- JSONDecoder.swift ------------------------------------------------===//
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

public extension JSONDecoder {
    /// Creates a `JSONDecoder` configured to convert keys from snake_case to camelCase.
    /// - Returns: A `JSONDecoder` instance with the `keyDecodingStrategy` set to `.convertFromSnakeCase`.
    static func snakeCaseDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
