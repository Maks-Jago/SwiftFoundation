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

#if os(iOS)
import UIKit

public extension String {
    
    /// Calculates the width of the string using the specified font.
    /// - Parameter font: The `UIFont` to be used for calculating the string's width.
    /// - Returns: The width of the string as a `CGFloat`.
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
#else
import AppKit

public extension String {
    
    /// Calculates the width of the string using the specified font (macOS version).
    /// - Parameter font: The `NSFont` to be used for calculating the string's width.
    /// - Returns: The width of the string as a `CGFloat`.
    func widthOfString(usingFont font: NSFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
#endif

// MARK: - StringProtocol Extensions
public extension StringProtocol {
    
    /// Finds the starting index of the first occurrence of a given substring.
    /// - Parameters:
    ///   - string: The substring to search for.
    ///   - options: Options for string comparison. Default is an empty array.
    /// - Returns: The starting index of the substring if found, or `nil` if not found.
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    
    /// Finds the ending index of the first occurrence of a given substring.
    /// - Parameters:
    ///   - string: The substring to search for.
    ///   - options: Options for string comparison. Default is an empty array.
    /// - Returns: The ending index of the substring if found, or `nil` if not found.
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    
    /// Finds all starting indices of occurrences of a given substring.
    /// - Parameters:
    ///   - string: The substring to search for.
    ///   - options: Options for string comparison. Default is an empty array.
    /// - Returns: An array of starting indices for each occurrence of the substring.
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    
    /// Finds all ending indices of occurrences of a given substring.
    /// - Parameters:
    ///   - string: The substring to search for.
    ///   - options: Options for string comparison. Default is an empty array.
    /// - Returns: An array of ending indices for each occurrence of the substring.
    func endIndices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.upperBound)
    }
    
    /// Finds all ranges of a given substring within the string.
    /// - Parameters:
    ///   - string: The substring to search for.
    ///   - options: Options for string comparison. Default is an empty array.
    /// - Returns: An array of ranges representing each occurrence of the substring.
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex, let range = self[startIndex...].range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

// MARK: HTML
/// Example usage:
/// ```swift
/// let attributedString = model.htmlDescription
///                             .htmlWithListMarkers()
///                             .convertHtmlUTF16()
///
/// ```
public extension String {
    /// Converts the string (assumed to be HTML) into an `NSAttributedString` using UTF-16 encoding.
    ///
    /// This method injects default styling into the HTML content (using `Montserrat-Medium` at 14pt)
    /// and attempts to parse it as a styled `NSAttributedString`.
    ///
    /// - Returns: An optional `NSAttributedString` if conversion succeeds; otherwise, `nil`.
    func convertHtmlUTF16(fontFamily: String, fontSize: CGFloat) -> NSAttributedString? {
        let htmlWithStyles = """
        <style>
        body {
            font-family: '\(fontFamily)', sans-serif;
            font-size: \(fontSize)px;
        }
        </style>
        \(self)
        """

        guard let styledData = htmlWithStyles.data(using: .utf16),
              let attributedString = try? NSAttributedString(
                  data: styledData,
                  options: [
                      .documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf16.rawValue,
                  ],
                  documentAttributes: nil
              ) else { return nil }

        return attributedString
    }

    /// Transforms custom HTML list markers from Quill.js (or similar editors) into standard list formats.
    ///
    /// Specifically:
    /// - Replaces bullet lists (with `data-list="bullet"`) with `"•"` prefix.
    /// - Replaces ordered lists (with `data-list="ordered"`) by prepending index numbers like `1.`, `2.`, etc.
    ///
    /// This is useful when handling raw HTML exported from rich text editors that use `<span class="ql-ui">` elements
    /// to simulate list bullets/numbers, which aren't visually meaningful in native rendering.
    ///
    /// - Returns: A modified HTML string with recognizable list markers.
    func htmlWithListMarkers() -> String {
        var html = self

        let bulletPattern = #"<li\s+data-list="bullet"><span class="ql-ui"[^>]*></span>"#
        html = html.replacingOccurrences(
            of: bulletPattern,
            with: "<li>• ",
            options: .regularExpression
        )

        let orderedPattern = #"<li\s+data-list="ordered"><span class="ql-ui"[^>]*></span>"#
        guard let regex = try? NSRegularExpression(
            pattern: orderedPattern,
            options: []
        ) else {
            return html
        }

        var counter = 0
        let matches = regex.matches(
            in: html,
            options: [],
            range: NSRange(html.startIndex..., in: html)
        )
        var result = ""
        var lastIndex = html.startIndex

        for m in matches {
            let range = Range(m.range, in: html)!
            result += String(html[lastIndex ..< range.lowerBound])
            counter += 1
            result += "<li>\(counter). "
            lastIndex = range.upperBound
        }

        result += String(html[lastIndex...])
        return result
    }
}
