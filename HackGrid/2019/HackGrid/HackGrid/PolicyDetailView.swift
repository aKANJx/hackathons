//
//  PolicyDetailView.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct PolicyDetailView: View {
    
    var policy: Policy
    
    var body: some View {
        VStack {
            HStack(spacing: 30) {
                OwnerCellView(owner: policy.owner)
                HStack(spacing: 20) {
                    Button(action: {
                        UIApplication.shared.open(URL(string: "whatsapp://phone=+5511971801555")!)
                    }) {
                        VStack {
                            Image("message.icon")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Whatsapp")
                                .foregroundColor(.black)
                                .font(.caption)
                        }
                    }
                    Button(action: {
                    }) {
                        VStack {
                            Image("trash.icon")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }
            }
            Spacer()
            CarDetails()
            Spacer()
            VStack(alignment: .center) {
                Text("Estimativa").font(.subheadline).foregroundColor(.gray)
                Text("R$980,00/mês").font(.title)
            }
            Spacer()
            Image("\(policy.car.model.lowercased()).image")
        }.padding(.vertical, 15)
    }
}


struct CarDetails: View {
    
    var carInfo = [
        "Marca":"Toyota",
        "Modelo":"Corolla",
        "Série":"XEI",
        "Combustível": "Alcool/Gasolina",
        "Cor": "Branca",
        "Ano-Fabricação": "2016",
        "Ano-Modelo": "2017",
        "Carroceria":"Sedan",
        "Potência":"154CV",
        "Cilindradas": "1987cc",
        "Sinistro":"Nada consta",
        "Chassi":"9C2KC08106R918325",
        "Tipo remarcação Chassi":"Normal",
        "Situação":"Em circulação",
        "Exercício Licenciamento": "20180",
    ]
    
    var body: some View {
        let carInfoKeys = carInfo.map{$0.key}
        let carInfoValues = carInfo.map {$0.value}
        return VStack(alignment: .leading, spacing: 5) {
            ForEach(carInfoKeys.indices) { index in
                HStack(spacing: 30) {
                    Text(carInfoKeys[index]).bold().font(.headline)
                    Text("\(carInfoValues[index])").foregroundColor(.gray)
                }
            }
        }
    }
}

struct PolicyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyDetailView(policy: TestData.policies().first!)
    }
}

