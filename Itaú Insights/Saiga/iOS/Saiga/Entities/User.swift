//
//  User.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

class User: Codable {
    let name:String
    let cnpj:Int
    let career:String
    
    enum CodingKeys: String, CodingKey {
        case name
        case cnpj
        case career
    }
    
    init() {
        name = ""
        cnpj = 0
        career = ""
    }
}
