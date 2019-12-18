//
//  ContentView.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 24/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI
import RealityKit


struct CatalogView: View {
    let catalog = TestData.catalog()
    let bounds = UIScreen.main.bounds
    @State var showingMissions = false
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(catalog) { category in
                        ZStack {
                            CategoryView(category: category)
                                .padding(.horizontal, 10)
                                .frame(width: self.bounds.width, height: 500)
                            NavigationLink(destination: FoodOrderView()) {
                                Rectangle()
                                    .hidden()
                            }
                        }
                    }
                }
            }.navigationBarTitle("Cardápio")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingMissions.toggle()
                    }) {
                        HStack(spacing: 2) {
                            Image("Mission")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text("Missões")
                                .font(.footnote)
                                .bold()
                        }                                .foregroundColor(Color.white)
                            .frame(width: 100, height: 30)
                            
                            .padding(5)
                            .background(Color("Main"))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }.sheet(isPresented: $showingMissions, content: {
                        MissionView(dismissFlag: self.$showingMissions)
                    })
            )
        }
    }
}


struct CategoryView: View {
    let category: FoodCategory
    
    var body: some View {
        VStack {
            Image(category.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350)
            Text(category.name)
                .font(.title)
            .bold()
            Text(category.about)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            .frame(height:100)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
