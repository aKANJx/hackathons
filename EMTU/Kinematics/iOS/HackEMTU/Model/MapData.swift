//
//  MapPath.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import CoreLocation

enum MapPathType: String, Codable {
    case walk
    case bike
    case bus
}

enum POIType: String, Codable {
    case keeper
    case home
    case company
    case gym
    case general
}
struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}

struct Route: Codable {
    
    var type: String
    var pois: [POI]
    var points: [Coordinate]
    
    enum CodingKeys: String, CodingKey {
        case type
        case pois
        case points
    }
}
