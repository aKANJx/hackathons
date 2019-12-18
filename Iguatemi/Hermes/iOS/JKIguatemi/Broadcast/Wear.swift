//
//  Wear.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import UIKit

struct AlgorithmiaResponse: Codable {
    let imageURL: String?
    let articles: [Wear]
    
    init?(imageURL: String, articles: [Wear]) {
        self.imageURL = imageURL
        self.articles = articles
    }
}

struct Wear: Codable {
    let name: String
    let confidence: Float
    let boundingBox: BoundingBox
    var primaryColor: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "article_name"
        case confidence = "confidence"
        case boundingBox = "bounding_box"
        case primaryColor = "primaryColor"
    }
}

struct BoundingBox: Codable {
    let y0: Int
    let x1: Int
    let x0: Int
    let y1: Int
}
