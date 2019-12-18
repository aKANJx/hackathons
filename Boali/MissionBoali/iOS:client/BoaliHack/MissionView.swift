//
//  MissionView.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    @Binding var dismissFlag: Bool
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("Disponíveis")
                        .font(.title)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Mission(title: "Sou influencer", badgeName: "Influencer", subtitle: "Tire uma selfie em frente a uma unidade Boali e compartilhe nas redes sociais com a hashtag #MissaoBoali", hasAction: true)
                            .frame(width: 350, height: 300)
                            Mission(title: "Maratonista 100% saúde", badgeName: "Heart", subtitle: "Ande no mínimo 1Km em uma semana", hasProgress: true)
                            .frame(width: 350, height: 300)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Completadas")
                        .font(.title)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            AchievementBadge(name: "Corredor nato", badgeName: "Run")
                            AchievementBadge(name: "Alimentação ❤️ Saúde", badgeName: "Food")
                            AchievementBadge(name: "Eu + Amigos", badgeName: "Social")
                            AchievementBadge(name: "Corrida 10Km", badgeName: "Run")
                            AchievementBadge(name: "Corrida 30Km", badgeName: "Run")
                        }
                    }
                    .frame(height: 140)
                }
            }.navigationBarTitle("Missões")
            .navigationBarItems(trailing:
                Button(action: {
                    self.dismissFlag = false
                    UIApplication.shared.windows[0].rootViewController!
                        .dismiss(animated: true, completion: nil)
                }) {
                    Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.gray)
            })
        }
    }
}


//struct MissionView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        MissionView(dismissFlag: $showingMissions)
//    }
//}
