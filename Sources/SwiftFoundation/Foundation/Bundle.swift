//
//  Bundle.swift
//  SwiftFoundation
//
//  Created by  Vladyslav Fil on 22.09.2021.
//

import Foundation

extension Bundle {
    var appVersion: String {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var buildNumber: Int {
        let build: NSString = self.infoDictionary?["CFBundleVersion"] as? NSString ?? "1"
        return Int(build.intValue)
    }
    
    var appVersionWithBuildNumber: String {
        return "\(appVersion) (\(buildNumber))"
    }
}
