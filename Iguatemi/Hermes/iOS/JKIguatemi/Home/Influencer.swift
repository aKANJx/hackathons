//
//  Influencer.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation


struct Influencer: Codable {
    let name: String
    let imageHero: String
    let looks: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageHero = "image-hero"
        case looks = "looks"
    }
}
