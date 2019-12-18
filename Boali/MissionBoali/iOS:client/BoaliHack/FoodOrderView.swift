//
//  PlateView.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct FoodOrderView: View {
    
    @State var showingAR = false
    @State var dragPosition: CGPoint = .zero
    
    fileprivate func arButton() -> some View {
        Button(action: {
            self.showingAR.toggle()
        }) {
            HStack {
                Image("AR").resizable().frame(width: 35, height: 35)
                Text("Ver em AR").bold().font(.footnote)
            }.foregroundColor(Color.white)
                .frame(height: 30)
        }.sheet(isPresented: $showingAR) {
            ARFoodView()
        }
        .padding(10)
        .background(Color("Main"))
        .cornerRadius(8)
    }
    
    fileprivate func priceView() -> some View {
        VStack {
            Text("Preço Total").font(.footnote)
            Text("R$27").font(.title)
            Button(action: {
                
            }) {
                Text("Informação Nutricional")
                .font(.caption)
                .foregroundColor(Color("CompMain"))
            }
        }.multilineTextAlignment(.center)
    }
    
    var body: some View {
        NavigationView {
            VStack() {
                PlateView().padding(.top, -80)
                Spacer()
                HStack {
                    arButton()
                    priceView()
                    PaymentButton().frame(width: 100, height: 50)
                    .gesture(TapGesture().onEnded({ _ in
                        PaymentViewController().show()
                    }))
                }.padding(.horizontal, 10)
                .padding(.trailing, 20)
                Spacer()
                VStack(spacing: 5) {
                    HStack(spacing: 50) {
                        IngredientView(name: "Camarão")
                        IngredientView(name: "Alface")
                        IngredientView(name: "Tomate")
                    }
                    HStack(spacing: 50) {
                        IngredientView(name: "Ovos")
                        IngredientView(name: "Cebola")
                        IngredientView(name: "Salmon")
                    }
                }
                Spacer()
            }
        }.navigationBarTitle("Saladas", displayMode: .inline)
    }
}


struct PlateView: View {
    var body: some View {
        Image("Plate")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
    }
}

struct IngredientView: View {
    var name: String
    @State private var draggablePosition: CGPoint = .zero
    @State private var draggableOpacity: Double = 0
    
    var body: some View {
        let drag = DragGesture()
            .onChanged {
                self.draggablePosition = $0.location
                self.draggableOpacity = 1
        }.onEnded { (value) in
            APIClient.shared.items.append(self.name)
        }
        
        return VStack(spacing: 10) {
            ZStack {
                Image(name)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .opacity(draggableOpacity)
                    .position(draggablePosition)
                Image("Plate.Square")
                    .resizable()
                    .frame(width: 100, height: 100)
                Image(name)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            Text(name)
                .font(.footnote)
        }
        .gesture(drag)
    }
}

struct Ingredient: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var position: CGPoint = .zero
}
struct FoodOrderView_Previews: PreviewProvider {
    static var previews: some View {
        FoodOrderView()
    }
}
