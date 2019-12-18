//
//  TestData.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation

struct TestData {
    static let owner1: Owner = Owner(name: "Jean Paul", age: 18, score: 5.6, location: .init(latitude: -22.898917, longitude: -43.180523))
    static let owner2: Owner = Owner(name: "Jairo Iglesias", age: 23, score: 2.2, location: .init(latitude: -22.900499, longitude: -43.188845))
    static let owner3: Owner = Owner(name: "Emerson Silva", age: 49, score: 8.2, location: .init(latitude: -22.908849, longitude: -43.194041))
    static let owner4: Owner = Owner(name: "Samella", age: 21, score: 4, location: .init(latitude: -22.912881, longitude: -43.172850))
    static let owner5: Owner = Owner(name: "Juliana", age: 23, score: 8, location: .init(latitude: -22.912643, longitude: -43.201762))


    
    static func policies() -> [Policy] {
        return [
            Policy(owner: owner1, car: Car(brand: "Toyota", model: "Corolla", year: 2016, odometer: 12344), price: 980),
            Policy(owner: owner2, car: Car(brand: "Honda", model: "Civic", year: 2016, odometer: 12344), price: 750),
            Policy(owner: owner3, car: Car(brand: "Jeep", model: "Cherokee", year: 2016, odometer: 12344), price: 1240),
            Policy(owner: owner4, car: Car(brand: "Volkswagen", model: "Gol", year: 2016, odometer: 12344), price: 350),
            Policy(owner: owner5, car: Car(brand: "Chevrolet", model: "Mustang", year: 2016, odometer: 12344), price: 1700)
        ]
    }
}
