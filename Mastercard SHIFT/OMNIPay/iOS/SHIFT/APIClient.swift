//
//  AppData.swift
//  HzCasting
//
//  Created by Jean Paul Marinho on 03/05/16.
//  Copyright © 2016 Iterative. All rights reserved.
//

import Foundation

final class APIClient {
    
    static let sharedInstance = APIClient()
    var creditCardUsed = false
    var transactionsArray: [Transaction] = []
}