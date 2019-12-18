//
//  DashboardView.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    let bounds = UIScreen.main.bounds
    @State var selectedOwner: Owner? = nil
    @State var showDetail = false
    @State var showMap = false
    @State var owners: [Owner] = [
        TestData.owner1, TestData.owner2, TestData.owner3, TestData.owner4, TestData.owner5]

    private func selectNextOwner() {
        if let selectedLandmark = selectedOwner, let currentIndex = owners.firstIndex(where: { $0 == selectedOwner }), currentIndex + 1 < owners.endIndex {
            self.selectedOwner = owners[currentIndex + 1]
        } else {
            selectedOwner = owners.first
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    GraphContainerView()
                }
                HStack {
                    Text("Visitas Pendentes")
                        .font(.title)
                    Spacer()
                    Button(action: {
                        self.showMap = true
                    })
                    {
                        HStack(spacing: 5) {
                            Image(systemName: "map.fill")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("Rotas de hoje")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(7)
                        .background(Color.black)
                        .frame(width: 120)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                    .sheet(isPresented: $showMap, onDismiss: {
                    }) {
                        ZStack {
                            MapView(owners: self.$owners,
                                    selectedOwner: self.$selectedOwner)
                                .edgesIgnoringSafeArea(.vertical)
                            VStack {
                                Spacer()
                                Button(action: {
                                    self.selectNextOwner()
                                }) {
                                    Text("Próximo Cliente")
                                        .foregroundColor(.white)
                                        .padding(7)
                                    .background(Color.black)
                                    .frame(width: 120)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                        .padding(.bottom, 30)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 5)
                PoliciesContainerView(showDetail: $showDetail)
            }
            .navigationBarTitle("Olá Sr. Jean Paul")
        }
    }
}


struct GraphContainerView: View {
    
    var body: some View {
        VStack {
            GraphView().frame(height: 200)
            HStack(spacing: 20) {
                HStack(spacing: 2) {
                    Rectangle()
                        .foregroundColor(Color("base"))
                        .cornerRadius(8)
                        .frame(width: 20, height: 20)
                    Text("Rendimento").font(.footnote)
                }
                HStack(spacing: 2) {
                    Rectangle()
                        .foregroundColor(Color("sec"))
                        .cornerRadius(8)
                        .frame(width: 20, height: 20)
                    Text("Visitas").font(.footnote)
                }
            }
        }
    }
}


struct PoliciesContainerView: View {
    
    @Binding var showDetail: Bool
    let policies = TestData.policies()
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 50) {
                ForEach(policies) { policy in
                    CardView(policy: policy)
                        .onTapGesture {
                            self.showDetail.toggle()
                    }
                    .sheet(isPresented: self.$showDetail, onDismiss: {
                    }) {
                        PolicyDetailView(policy: TestData.policies().first!)
                    }
                }
            }.padding(15)
        }
    }
}


struct CardView: View {
    
    var policy: Policy
    
    
    var body: some View {
        VStack(spacing: 30) {
            OwnerCellView(owner: policy.owner)
            Image("\(policy.car.model.lowercased()).image").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 200)
            VStack {
                Text("R$\(policy.price)/mês").font(.title)
                Text("Hoje").font(.headline).foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color(white: 0.8), radius: 10, x: 0, y: 0)
    }
}

struct OwnerCellView: View {
    
    var owner: Owner
    
    
    var body: some View {
        HStack {
            Image("\(owner.name.replacingOccurrences(of: " ", with: ""))")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .clipShape(Circle())
            VStack {
                Text(owner.name).font(.title)
                HStack {
                    Text("\(owner.age) anos")
                        .font(.footnote)
                    Text(String(format:"%.1f pontos", owner.score))
                        .font(.footnote)
                }
            }
        }
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            CardView(policy: TestData.policies().first!)
                .previewLayout(.fixed(width: 300, height: 300))
        }
    }
}
