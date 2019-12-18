//
//  CoinsDropScene.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 15/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class CoinsDropScene: SKScene {
    
    var emitter: SKEmitterNode?

    override func didMove(to view: SKView) {
        scaleMode = .resizeFill
        backgroundColor = UIColor.clear
    }

    func droppingCoins() {
        emitter = SKEmitterNode(fileNamed: "CoinsParticle")
        emitter!.position = CGPoint(x:187.5, y:200)
        emitter!.name = "CoinsParticle"
        emitter!.targetNode = self
        emitter?.numParticlesToEmit = 8
        addChild(emitter!)
        emitter?.resetSimulation()
        let wait = SKAction.wait(forDuration: 0.7)
        let run = SKAction.run {
            self.run(SKAction.playSoundFileNamed("Coin-drop3.mp3", waitForCompletion: false))
        }
        self.run(SKAction.sequence([wait, run]))
    }
    
    func stopCoinsDropping() {
        emitter?.particleBirthRate = 0
    }
}
