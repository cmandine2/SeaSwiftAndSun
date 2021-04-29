//
//  Spot.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 30/03/2021.
//

import Foundation

struct Records: Codable {
    var spots: [Spot]
    
    enum CodingKeys: String, CodingKey {
        case spots = "records"
    }
}

struct Spot: Codable {
    var id: String
    var fields: Fields
}

struct Fields: Codable {
    var name: String
    var location: String
    var photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case name = "Destination"
        case location = "Address"
        case photos = "Photos"
    }
}

struct Photo: Codable {
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
}
