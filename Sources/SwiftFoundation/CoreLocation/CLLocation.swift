//
//  CLLocation.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import CoreLocation

public extension CLLocation {

    var isValid: Bool {
        CLLocationCoordinate2DIsValid(coordinate)
    }

    var isZero: Bool {
        self.coordinate.latitude == 0 && self.coordinate.longitude == 0
    }
    
    var string: String {
        String(format: "%.6f", coordinate.latitude) + ", " + String(format: "%.6f", coordinate.longitude)
    }
    
    static var whiteHouse: CLLocation = CLLocation(latitude: 38.897793, longitude: -77.036616)
    
    var isWhiteHouse: Bool { self == Self.whiteHouse }
    
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
