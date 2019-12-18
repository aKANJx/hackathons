//
//  ProgressBar.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    var gradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [Color("CompMain"), Color.white]),
            startPoint: .init(x: 0, y: 0),
            endPoint: .init(x: 0.5, y: 0)
        )
    }
    var progressAnimation: Animation {
        Animation
            .spring(response: 43, dampingFraction: 3.2, blendDuration: 3)
            .speed(3)
            .delay(0.07)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Distance")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("500 / 1000m")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, -8)
            .padding(.horizontal, 4)
            ZStack {
                GeometryReader { geometry in
                    Capsule()
                        .fill(
                            Color(.displayP3,
                                  red: 150 / 255,
                                  green: 150 / 255,
                                  blue: 150 / 255,
                                  opacity: 0.1)
                    )
                        .overlay(
                            ZStack(alignment: .leading) {
                                Circle()
                                    .fill(self.gradient)
                                    .position(x: 7, y: 7)
                                Capsule()
                                    .size(
                                        width: geometry.size.width * self.progress,
                                        height: geometry.size.height)
                                    .fill(self.gradient)
                                    .animation(self.progressAnimation)
                            }
                    )
                }
            }
            .frame(width: nil, height: 14, alignment: .leading)
        }
        .padding()
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 50)
    }
}
