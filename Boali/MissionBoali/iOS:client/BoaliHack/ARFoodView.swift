//
//  ARFoodView.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI
import SceneKit
import ARKit
import UIKit

struct ARFoodView: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {

    let sceneView = ARSCNView(frame: .zero)

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> ARSCNView {

        let scene = SCNScene(named: "Experience.scnassets/Food.scn")!
        sceneView.scene = scene
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        let node = self.sceneView.scene.rootNode.childNode(withName: "Food", recursively: true)
        node?.isHidden = true
        sceneView.delegate = context.coordinator
        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        print()
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        
        var arViewContainer: ARViewContainer
        let centerScreen = CGPoint(x: UIScreen.main.bounds.maxX / 2.0, y: UIScreen.main.bounds.maxY / 2.0)

        init(_ arViewContainer: ARViewContainer) {
            self.arViewContainer = arViewContainer
        }

        func startHitTest() {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                let hitTest = self.arViewContainer.sceneView.hitTest(self.centerScreen, types: .estimatedHorizontalPlane)
                if let hitResult = hitTest.first {
                    let scnMatrix = SCNMatrix4(hitResult.worldTransform)
                    let position = SCNVector3Make(scnMatrix.m41, scnMatrix.m42, scnMatrix.m43)
                    self.updateNode(position: position)
                    timer.invalidate()
                }
            }
        }
        
        func updateNode(position: SCNVector3) {
            let node = self.arViewContainer.sceneView.scene.rootNode.childNode(withName: "Food", recursively: true)
            node?.position = position
            node?.isHidden = false
        }
        
        func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
            
            switch camera.trackingState {
            case .normal:
                self.startHitTest()
            default:
                return
            }
        }
    }

}

struct ARFoodView_Previews: PreviewProvider {
    static var previews: some View {
        ARFoodView()
    }
}
