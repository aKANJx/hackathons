//
//  Mission.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct Mission: View {
    var title: String
    var badgeName: String
    var subtitle: String
    @State var hasAction = false
    @State var hasProgress = false
    
    var body: some View {
        VStack {
            Badge(name: badgeName)
            Text(title)
                .font(.headline)
                .bold()
            Text(subtitle)
                .font(.footnote)
                .multilineTextAlignment(.center)
            if hasAction {
                MissionAction()
            }
            if hasProgress{
                ProgressBar(progress: 50)
            }
        }
    }
}

struct Mission_Previews: PreviewProvider {
    static var previews: some View {
        Mission(title: "Test", badgeName: "Heart", subtitle: "Test", hasProgress: true)
    }
}
