//
//  ControllerFeedback.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class ControllerFeedback: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let viewInstance = view as? ViewFeedback {
            
            viewInstance.setupData(with: "João")
        }
    }
}
