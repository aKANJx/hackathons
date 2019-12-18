//
//  OwnerAnnotation.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation
import MapKit


final class OwnerAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(owner: Owner) {
        self.id = owner.id
        self.title = owner.name
        self.coordinate = owner.location
    }
}
