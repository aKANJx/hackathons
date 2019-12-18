//
//  ControllerLoad.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class ControllerLoad: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let viewInstance = view as? ViewLoad {
            
            viewInstance.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.dismiss(animated: true, completion: {
                (UIApplication.shared.keyWindow?.rootViewController as! AppTabBarController).selectedIndex = 2
            })
            
        }
    }
}
