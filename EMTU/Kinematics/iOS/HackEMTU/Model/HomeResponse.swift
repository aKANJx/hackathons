//
//  HomeResponse.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation

struct HomeResponse: Codable {
    var keepers: [KeepersResponse]
    var history: [String]
    
    init() {
        self.keepers = [KeepersResponse]()
        self.history = [String]()
    }
}

struct KeepersResponse: Codable {
    let url: String
    let address: String
    let available: String
}
