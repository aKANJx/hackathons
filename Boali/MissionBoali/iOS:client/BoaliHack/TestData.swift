//
//  TestData.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 24/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation

struct TestData {
    static func catalog() -> [FoodCategory] {
        [FoodCategory(name: "Bowl", about: "Tigela recheada com uma proteína e combinações de saladas e/ou macarrão orgânico."),
         FoodCategory(name: "Burrito", about: "Prato tradicional da culinária do México consistindo de uma tortilla de farinha geralmente recheada de diversos ingredientes."),
         FoodCategory(name: "Crepe", about: "Tipo de panqueca feito a base de farinha de trigo, leite e ovos. A massa é preparada no fundo de uma frigideira e apenas pincelada com manteiga."),
         FoodCategory(name: "Salada", about: "As saladas são de baixas calorias, são fontes de vitaminas, minerais e fibras – o que auxilia no funcionamento do sistema digestório."),
         FoodCategory(name: "Suco", about: "Ótima fonte de nutrientes, possuem ação antioxidante, auxiliam na prevenção de doenças, além de serem ricos em fibras."),
         FoodCategory(name: "Wrap", about: "Alimento feito com massa de pão achatado enrolado em torno de um recheio. Feitos com tortillas de trigo, lavash, ou pita;")]
    }
}
