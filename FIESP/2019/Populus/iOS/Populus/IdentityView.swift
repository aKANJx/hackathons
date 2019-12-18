//
//  IdentityView.swift
//  Populus
//
//  Created by Jean Paul Marinho on 16/06/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import SwiftUI

struct IdentityView : View {
    
    @State var hasQRCode = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Identidade")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Text(" ")
            if !hasQRCode {
                Text("Você é dono de seus dados. Compartilhe somente o que achar necessário. Foi solicitado os seguintes dados:")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Text(" ")
                HStack(alignment: .top) {
                    Image("fiesp.image").cornerRadius(10)
                        .frame(width: 60.0, height: 60.0)
                    VStack(alignment: .leading) {
                        Text("FIESP")
                            .font(.headline)
                        Text("CNPJ: 00001.2342342-32")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text("Rua Lorem Ipsum 457 - São Paulo - SP")                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                Text(" ")
                HStack {
                    Image("map.image").cornerRadius(10)
                }
                List {
                    HStack {
                        Text("NOME")
                        Spacer()
                        Text("Jean Paul Marinho")
                        Spacer()
                        Image("Check.marked")
                    }
                    HStack {
                        Text("RG")
                        Spacer()
                        Text("123.4536.453-34      ")
                        Spacer()
                        Image("Check.blank")
                    }
                    HStack {
                        Text("Título Eleitor")
                        Spacer()
                        Text("23424342545")
                        Spacer()
                        Image("Check.blank")
                    }
                    HStack {
                        Text("Idade")
                        Spacer()
                        Text("28 anos                  ")
                        Spacer()
                        Image("Check.marked")
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.hasQRCode = true
                    }) {
                        Text("Gerar")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 100.0, height: 45.0)
                    .background(Color.green)
                    .cornerRadius(5)
                    Spacer()
                }
            }
            else {
                VStack {
                    Text(" ")
                    Text(" ")
                    Text(" ")
                    Text(" ")
                    Image("Profile.photo").clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                    Text("Jean Paul Marinho")
                        .font(.title)
                    Text("124.123.543-45")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Image("QRCode.image")
                    Spacer()
                }
                
            }
        }.padding()
    }
}

#if DEBUG
struct IdentityView_Previews : PreviewProvider {
    static var previews: some View {
        IdentityView()
    }
}
#endif
