//
//  ContentView.swift
//  DynamicAR
//
//  Created by Jean Paul Marinho on 14/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
        
    var arContainerView = ARViewContainer()
    
    var body: some View {
        return ZStack(alignment: .topLeading) {
            arContainerView.edgesIgnoringSafeArea(.all)
            Button(action: {
                UIApplication.shared.open(URL(string: "dynamicar-main://")!, options: [:], completionHandler: nil)
            }) {
                HStack {
                    Image(systemName: "arrowtriangle.left.square.fill").resizable().frame(width: 25, height: 25, alignment: .center).foregroundColor(Color.white)
                    Text("Voltar").foregroundColor(Color.white)
                }

            }.offset(x: 30, y: 30)
            Spacer()
            Button(action: {
                self.arContainerView.toggleDebug()
            }) {
                Text("Iniciar modo Debug")
            }.offset(x: 500, y: 30)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let arView = ARView(frame: .zero)

    func makeUIView(context: Context) -> ARView {

        let objectAnchor = AnchorEntity(.object(group: "Machines", name: "SiloMachine"))
        let experienceAnchor = try! Experience.loadScene()

        experienceAnchor.anchoring = objectAnchor.anchoring
        arView.scene.addAnchor(experienceAnchor)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func toggleDebug() {
        arView.debugOptions = .showFeaturePoints
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
