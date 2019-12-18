//
//  Badge.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct Badge: View {
    var name: String
    
    var body: some View {
        ZStack {
            BadgeBackground()
            
            GeometryReader { geometry in
                Image(self.name)
                .resizable()
                .frame(width: geometry.size.width/2, height: geometry.size.height/2)
                .foregroundColor(Color.white)
                .opacity(0.7)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(name: "Run")
    }
}
