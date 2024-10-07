//===--- Bundle.swift -----------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import Foundation

public extension Bundle {
    /// Returns the app's version as a string.
    /// - Note: This reads the `CFBundleShortVersionString` from the bundle's info dictionary.
    var appVersion: String {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    /// Returns the app's build number as an integer.
    /// - Note: This reads the `CFBundleVersion` from the bundle's info dictionary.
    /// - Returns: An integer representing the build number. Defaults to `1` if not found.
    var buildNumber: Int {
        let build: NSString = self.infoDictionary?["CFBundleVersion"] as? NSString ?? "1"
        return Int(build.intValue)
    }
    
    /// Returns a string that combines the app version and build number.
    /// - Example: "1.0.0 (1)"
    var appVersionWithBuildNumber: String {
        return "\(appVersion) (\(buildNumber))"
    }
}
