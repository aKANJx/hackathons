//
//  Piggy.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import UIKit

enum PiggyType: Int {
    case personal = 0
    case event
}

class Piggy: NSObject {
    
    var type: PiggyType?
    var image: UIImage?
    var title: String?
    var alias: String?
    var about: String?
    var isPublic: Bool?
    var seeders: Int?
    var savingsTier: Int?
    
    
    init(dictionary: [String:Any]) {
        
        self.type = PiggyType(rawValue: (dictionary["type"] as! Int))
        self.image = dictionary["image"] as? UIImage
        //self.image = UIImage(named: "JeanPaulMarinhoPhoto")
        self.title = dictionary["title"] as? String
        self.alias = dictionary["alias"] as? String
        self.about = dictionary["about"] as? String
        self.isPublic = dictionary["isPublic"] as? Bool
        self.seeders = dictionary["seeders"] as? Int
        self.savingsTier = dictionary["savingsTier"] as? Int
    }
    
    override init() {
        super.init()
    }
}
