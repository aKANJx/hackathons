//
//  ProfileAnalyzerViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 21/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import SpriteKit

class ProfileAnalyzerViewController: UIViewController {

    @IBOutlet var bubblesView: CSBubblesView!
    @IBOutlet var finishButton: UIButton!
    var numberSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileAnalyzerViewController.bubbleWasSelected), name: NSNotification.Name(rawValue: "BubbleWasSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileAnalyzerViewController.bubbleWasDeselected), name: NSNotification.Name(rawValue: "BubbleWasDeselected"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bubblesView.dataArray = ["Família",
                                 "Independência",
                                 "Livros",
                                 "Cinema",
                                 "Domir",
                                 "Festas",
                                 "Bares",
                                 "Ambiente Rural",
                                 "Ambiente Urbano",
                                 "Praias",
                                 "Futebol",
                                 "Natação",
                                 "Tênis",
                                 "Passado",
                                 "Presente",
                                 "Futuro",
                                 "Política",
                                 "Religião"]
    }
    
    @IBAction func actionPressed(_ sender: UIButton) {
        
    }
    
    @objc func bubbleWasSelected(notification: NSNotification) {
        print(notification.object as! String)
        numberSelected += 1
        if numberSelected >= 5 {
            finishButton.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.03137254902, blue: 0.1882352941, alpha: 1)
            finishButton.isEnabled = true
        }
    }
    
    @objc func bubbleWasDeselected(notification: NSNotification) {
        print(notification.object as! String)
    }
}
