//
//  ContentView.swift
//  Populus
//
//  Created by Jean Paul Marinho on 16/06/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import SwiftUI

struct HomeView : View {
    
    var services = ["Alistamento Militar",
                    "ENEM",
                    "Eleicao",
                    "IDJovem"]
    
    var body: some View {
        NavigationView {
            List {
                HomeLocationHeader().padding(.leading, 6)
                HomeCell(service: services[0])
                HomeForYouHeader().padding(.leading, 6)
                HomeCell(service: services[1])
                HomeCell(service: services[2])
                HomeCell(service: services[3])
            }.navigationBarItems(trailing: HStack {
                Image("Not.icon")
                Image("ID.icon")
            })
                .navigationBarTitle(Text("Populus"))
        }
    }
}


struct HomeCell: View {
    
    var service: String
    
    var body: some View {
        Image(service.replacingOccurrences(of: " ", with: ".")).resizable()
            .frame(height: 140).cornerRadius(12).clipped()
    }
}


struct HomeLocationHeader: View {
    
    var body: some View {
        VStack {
            Text("Baseado em sua localização")
                .font(.headline)
            Text("Av. Paulista 1350 - São Paulo - SP")
                .font(.footnote)
                .foregroundColor(.gray)
        }.padding(.leading, 4)
    }
}

struct HomeForYouHeader: View {
    
    var body: some View {
        Text("Para você").font(.headline)
            .padding(.leading, 4)
    }
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            HomeCell(service: "Alistamento Militar").previewLayout(.fixed(width: 340, height: 140))
        }
    }
}
#endif
