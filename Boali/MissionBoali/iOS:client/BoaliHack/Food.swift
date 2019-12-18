//
//  Food.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 24/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation


struct FoodCategory: Identifiable {
    
    var id: String = UUID().uuidString
    let name: String
    let about: String
    let foods: [Food] = []
}


struct Food: Identifiable {
    
    var id: String = UUID().uuidString
    let name: String
}
