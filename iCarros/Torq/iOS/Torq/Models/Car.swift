//
//  Car.swift
//  Torq
//
//  Created by Felipe Antonio Cardoso on 21/10/2018.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation

struct Car {
    let id: Int
    let idClient: Int
    let model: String
    let brand: String
    let plate: String
    let year: Int
    let km: Int
    let estimatePrice: Int
    let value: Int
    let score: Int
    let imageURL: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case idClient = "IdCliente"
        case brand = "Brand"
        case model = "Modelo"
        case plate = "Placa"
        case year = "Ano"
        case km = "Quilometragem"
        case estimatePrice = "ValorEstimado"
        case value = "ValorDaCompra"
        case score = "Score"
        case imageURL = "ImageUrl"
    }
    
    init(id: Int, idClient: Int, model: String, brand: String, plate: String, year: Int, km: Int, estimatePrice: Int, value: Int, score: Int, imageURL: String) {
        self.id = id
        self.idClient = idClient
        self.model = model
        self.brand = brand
        self.plate = plate
        self.year = year
        self.km = km
        self.estimatePrice = estimatePrice
        self.value = value
        self.score = score
        self.imageURL = imageURL
    }
    
    init(brand: String, model: String, year: Int) {
        self.init(
            id: 0,
            idClient: 0,
            model: model,
            brand: brand,
            plate: "",
            year: year, km: 0,
            estimatePrice: 0,
            value: 0,
            score: 0,
            imageURL: "")
    }
}

extension Car: Encodable
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(idClient, forKey: .idClient)
        try container.encode(model, forKey: .model)
        try container.encode(brand, forKey: .brand)
        try container.encode(plate, forKey: .plate)
        try container.encode(year, forKey: .year)
        try container.encode(km, forKey: .km)
        try container.encode(estimatePrice, forKey: .estimatePrice)
        try container.encode(value, forKey: .value)
        try container.encode(score, forKey: .score)
        try container.encode(imageURL, forKey: .imageURL)
    }
}

extension Car: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        idClient = try values.decode(Int.self, forKey: .idClient)
        model = try values.decode(String.self, forKey: .model)
        brand = try values.decodeIfPresent(String.self, forKey: .brand) ?? ""
        plate = try values.decode(String.self, forKey: .plate)
        year = try values.decode(Int.self, forKey: .year)
        km = try values.decode(Int.self, forKey: .km)
        estimatePrice = try values.decode(Int.self, forKey: .estimatePrice)
        value = try values.decode(Int.self, forKey: .value)
        score = try values.decode(Int.self, forKey: .score)
        imageURL = try values.decode(String.self, forKey: .imageURL)
    }
}
