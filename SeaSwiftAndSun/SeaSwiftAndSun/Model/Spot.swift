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
    var id: String?
    var fields: Fields
}

struct Fields: Codable {
    var name: String
    var location: String
    var photos: [Photo]?
    var surfBreak: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "Destination"
        case location = "Destination State/Country"
        case photos = "Photos"
        case surfBreak = "Surf Break"
    }
}

struct Photo: Codable {
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
}

enum SurfBreak: String {
    case beach = "Beach Break"
    case reef = "Reef Break"
    case point = "Point Break"
}
