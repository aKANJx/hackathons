//
//  Event.swift
//  App
//
//  Created by Jean Paul Marinho on 29/07/18.
//

import FluentSQLite
import Vapor

final class Event: SQLiteModel {
    
    var id: Int?
    var title: String
//    var category: EventCategory = .LastMinute
    var address: String
    var originalPrice: Double
    var discountedPrice: Double
    var remainingSeats: Int
    var remainingTime: Int
    
    init(title: String,
         address: String,
         originalPrice: Double,
         discountedPrice: Double,
         remainingSeats: Int,
         remainingTime: Int) {
        self.title = title
        self.address = address
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
        self.remainingSeats = remainingSeats
        self.remainingTime = remainingTime
    }
}

extension Event: Migration { }
extension Event: Content { }
extension Event: Parameter { }


enum EventCategory: String, Codable {
    case LastMinute
    case Cinema
    case Football
    case Theater
}
