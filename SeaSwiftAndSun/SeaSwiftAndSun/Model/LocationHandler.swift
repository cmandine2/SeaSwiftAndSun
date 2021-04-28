//
//  LocationHandler.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 27/04/2021.
//

import Foundation
import CoreLocation

class GeoCoder {
    func getCoordinates(address: String, completionHandler: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                    print("Unable to Forward Geocode Address (\(error))")
                } else {
                    var location: CLLocation?

                    if let placemarks = placemarks, placemarks.count > 0 {
                        location = placemarks.first?.location
                    }

                    if let location = location {
                        completionHandler(location.coordinate)
                    } else {
                        print("Address not found")
                    }
                }
        }
    }
}
