//
//  Point.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import CoreLocation
struct Point{
    let latitude:Double
    let longiute:Double
    let numberPopCorn:Int
    let numberCandy:Int
    let name:String
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longiute)
        }
    }
    
    static func fetchAll() -> [Point]{
        var points = [Point] ()
        let povo = Point(latitude: -23.588030, longiute: -46.686633, numberPopCorn: 5, numberCandy: 5, name: "Parque do Povo")
        let cubo = Point(latitude: -23.594427, longiute: -46.690628, numberPopCorn: 0, numberCandy: 5, name: "Região da Vila Olimpia")
        let morumbi = Point(latitude: -23.592726, longiute: -46.684545, numberPopCorn: 1, numberCandy: 3, name: "Itaim Bibi")
        let paulista = Point(latitude: -23.595297, longiute: -46.681782, numberPopCorn: 3, numberCandy: 5, name: "Região da Bela Vista")
        points.append(contentsOf: [cubo, povo, morumbi, paulista])
        return points
    }
}
