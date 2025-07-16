//
//  URL+FileSizeInMB.swift
//  SwiftFoundation
//
//  Created by Vlad Andrieiev on 16.07.2025.
//

import Foundation

public extension URL {
    /// Returns the size of the file at the current URL in megabytes.
    ///
    /// This method uses `FileManager` to fetch file attributes without loading the file into memory.
    /// - Returns: The size of the file in megabytes.
    /// - Throws: An error if the file size cannot be determined or is invalid.
    func fileSizeInMB() throws -> Double {
        let attributes = try FileManager.default.attributesOfItem(atPath: path)
        
        guard let size = attributes[.size] as? NSNumber else {
            throw FileSizeError.invalidFileSizeAttribute
        }
        
        return size.doubleValue / 1_048_576.0
    }
    
    /// An error representing issues determining file size.
    enum FileSizeError: Error {
        /// The file size attribute could not be cast to `NSNumber`.
        case invalidFileSizeAttribute
    }
}
