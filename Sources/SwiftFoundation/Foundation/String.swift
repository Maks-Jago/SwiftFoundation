//===--- String.swift -----------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You are launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import Foundation

public extension String {
    /// Capitalizes the first letter of the string.
    /// - Returns: A new string with the first letter capitalized.
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
    
    /// Converts the string to `Data` using the specified encoding.
    /// - Parameter using: The encoding to use. Default is `.utf8`.
    /// - Returns: The `Data` representation of the string, or `nil` if the conversion fails.
    func toData(using: Encoding = .utf8) -> Data? {
        self.data(using: using)
    }
}

public extension String {
    /// Evaluates the string against a regular expression.
    /// - Parameter regex: The regular expression to match.
    /// - Returns: `true` if the string matches the regular expression; otherwise, `false`.
    func evaluate(withRegex regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}

// MARK: - Identifiable
extension String: Identifiable {
    /// The string itself as its unique identifier.
    public var id: String { self }
}

// MARK: - Base64
public extension String {
    /// Encodes the string to a Base64 encoded string.
    /// - Returns: A Base64 encoded version of the string.
    func toBase64() -> String {
        Data(self.utf8).base64EncodedString()
    }
    
    /// Decodes a Base64 encoded string.
    /// - Returns: The decoded string, or `nil` if decoding fails.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: - Format
public extension String {
    /// Formats the string using the specified parameters.
    /// - Parameter parameters: The parameters to use in the format.
    /// - Returns: A formatted string.
    func format(parameters: CVarArg...) -> String {
        return String(format: self, arguments: parameters)
    }
}

// MARK: - Slice Including
public extension String {
    /// Extracts a substring that includes the specified start and end markers.
    /// - Parameters:
    ///   - from: The start marker.
    ///   - to: The end marker.
    /// - Returns: A substring that includes the specified markers, or `nil` if not found.
    func sliceIncluding(from: String, to: String) -> String? {
        return (range(of: from)?.lowerBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.upperBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

public extension String {
    /// Converts the string containing HTML into an `NSAttributedString`.
    /// - Returns: An `NSAttributedString` representing the HTML content, or `nil` if conversion fails.
    func convertHtml() -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        } else {
            return nil
        }
    }
}
