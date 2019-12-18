//
//  Category.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 17/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    var title: String?
    var about: String?
    var piggies: [Piggy]?
    var banners: [Banner]?
    
    init(dictionary: [String:Any]) {
        
        self.title = dictionary["title"] as? String
        self.about = dictionary["about"] as? String
        self.piggies = dictionary["piggies"] as? [Piggy]
        self.banners = dictionary["banners"] as? [Banner]
    }
    
    override init() {
        super.init()
    }
}
