//===--- CNMutablePostalAddress.swift -------------------------------------===//
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
import CoreLocation
import Contacts

public extension CNMutablePostalAddress {
    
    /// Initializes a `CNMutablePostalAddress` from a `CLPlacemark`.
    /// - Parameter placemark: A `CLPlacemark` object containing the postal address information.
    convenience init(placemark: CLPlacemark) {
        self.init()
        self.street = (placemark.subThoroughfare ?? "") + " " + (placemark.thoroughfare ?? "")
        self.city = placemark.locality ?? ""
        self.state = placemark.administrativeArea ?? ""
        self.postalCode = placemark.postalCode ?? ""
        self.country = placemark.country ?? ""
    }
}
