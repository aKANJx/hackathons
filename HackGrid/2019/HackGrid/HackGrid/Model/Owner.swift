//
//  Card.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation
import MapKit

struct Owner: Identifiable, Equatable {
    static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String = UUID().uuidString
    var name: String
    var age: Int
    var score: Double
    var location: CLLocationCoordinate2D
}
