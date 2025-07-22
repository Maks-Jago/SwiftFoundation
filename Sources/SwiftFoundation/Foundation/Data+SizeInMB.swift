//
//  Data+SizeInMB.swift
//  SwiftFoundation
//
//  Created by Vlad Andrieiev on 16.07.2025.
//

import Foundation

public extension Data {
    /// The size of the data in megabytes.
    var sizeInMB: Double {
        Double(count) / 1_048_576.0
    }

    /// The size of the data in kilobytes.
    var sizeInKB: Double {
        Double(count) / 1_024.0
    }
}
