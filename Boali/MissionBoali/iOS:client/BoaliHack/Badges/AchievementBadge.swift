//
//  AchievementBadge.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct AchievementBadge: View {
    var name: String
    var badgeName: String
    
    var body: some View {
        VStack(alignment: .center) {
            Badge(name: badgeName)
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibility(label: Text("Badge for \(name)."))
        }
    }
}

struct AchievementBadge_Previews: PreviewProvider {
    static var previews: some View {
        AchievementBadge(name: "Preview Testing", badgeName: "Run")
    }
}
