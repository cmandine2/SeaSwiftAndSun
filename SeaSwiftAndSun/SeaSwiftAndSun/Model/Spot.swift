//
//  Spot.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 30/03/2021.
//

import Foundation
import CoreLocation

struct Records: Codable {
    var spots: [Spot]
    
    enum CodingKeys: String, CodingKey {
        case spots = "records"
    }
}

struct Spot: Codable {
    var name: String
    var location: String
    var imageUrl: String
    var coordinates: CLLocation?
    
    enum CodingKeys: String, CodingKey {
        case name = "Surf Break"
        case location = "Address"
        case imageUrl = "Photos"
    }
}
