//
//  Policy.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Policy: Identifiable {
    
    var id: String = UUID().uuidString
    var owner: Owner
    var car: Car
    var price: Int
}
