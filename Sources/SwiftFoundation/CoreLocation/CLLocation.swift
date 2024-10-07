//===--- CLLocation.swift -------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import CoreLocation

public extension CLLocation {
    
    /// Checks if the coordinate of the location is valid.
    var isValid: Bool {
        CLLocationCoordinate2DIsValid(coordinate)
    }
    
    /// Checks if the location is at the zero coordinate (latitude and longitude equal to 0).
    var isZero: Bool {
        self.coordinate.latitude == 0 && self.coordinate.longitude == 0
    }
    
    /// Returns a string representation of the location's coordinates in "latitude, longitude" format.
    var string: String {
        String(format: "%.6f", coordinate.latitude) + ", " + String(format: "%.6f", coordinate.longitude)
    }
    
    /// A static property representing the location of the White House.
    static var whiteHouse: CLLocation = CLLocation(latitude: 38.897793, longitude: -77.036616)
    
    /// Checks if the location is at the White House coordinates.
    var isWhiteHouse: Bool { self == Self.whiteHouse }
    
    /// Generates a vCard file for the location.
    /// - Parameter title: An optional title for the vCard. Defaults to "Shared Location".
    /// - Returns: A URL pointing to the saved vCard file.
    func vCard(title: String? = nil) -> URL {
        let vCardFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(title ?? "vCard").loc.vcf")
        
        let vCardString = [
            "BEGIN:VCARD",
            "VERSION:4.0",
            "FN:\(title ?? "Shared Location")",
            "item1.URL;type=pref:http://maps.apple.com/?ll=\(coordinate.latitude),\(coordinate.longitude)",
            "item1.X-ABLabel:map url",
            "END:VCARD"
        ].joined(separator: "\n")
        
        do {
            try vCardString.write(toFile: vCardFileURL.path, atomically: true, encoding: .utf8)
        } catch let error {
            print("Error, \(error.localizedDescription), saving vCard: \(vCardString) to file path: \(vCardFileURL.path).")
        }
        
        return vCardFileURL
    }
}
