//
//  Recruiter.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 06/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class Recruiter: NSObject, MKAnnotation {

    var title: String?
    var name: String?
    var company: String?
    var photoID: String?
    var coordinate: CLLocationCoordinate2D
    var companyDescription: String?
    var abilities: String?
    var companyImageID: String?
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.company = json["company"].stringValue
        self.photoID = json["photoID"].stringValue
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(json["latitude"].floatValue), longitude: CLLocationDegrees(json["longitude"].floatValue))
        self.companyDescription = json["description"].stringValue
        self.abilities = json["abilities"].stringValue
        self.companyImageID = json["companyImage"].stringValue
    }
}
