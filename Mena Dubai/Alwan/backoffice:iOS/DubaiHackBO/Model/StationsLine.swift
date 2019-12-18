//
//  StationsLine.swift
//  DubaiHackBO
//
//  Created by Jean Paul Marinho on 21/04/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation

struct StationsLine: Codable {
    
    let name: String
    let stations: [Station]
}