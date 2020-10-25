//
//  CNMutablePostalAddress.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation
import CoreLocation
import Contacts

public extension CNMutablePostalAddress {
    /// Constructs a `CNMutablePostalAddress` from a `CLPlacemark`
    convenience init(placemark: CLPlacemark) {
        self.init()
        self.street = (placemark.subThoroughfare ?? "") + " " + (placemark.thoroughfare ?? "")
        self.city = placemark.locality ?? ""
        self.state = placemark.administrativeArea ?? ""
        self.postalCode = placemark.postalCode ?? ""
        self.country = placemark.country ?? ""
    }
}
