//
//  MissionAction.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct MissionAction: View {
    var body: some View {
        Button(action: {
        }) {
            VStack {
                Image(systemName: "camera.fill")
                Text("Tirar Foto")
                    .font(.footnote)
                    .bold()
            }
            .foregroundColor(Color.white)
            .padding(20)
            .background(Color("CompMain"))
            .mask(Circle())
        }
    }
}

struct MissionAction_Previews: PreviewProvider {
    static var previews: some View {
        MissionAction()
    }
}
