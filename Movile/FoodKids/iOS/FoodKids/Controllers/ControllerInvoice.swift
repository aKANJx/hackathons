//
//  ControllerInvoice.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class ControllerInvoice: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if let viewInstance = view as? ViewInvoice {
            
            viewInstance.setupData(with: "João", restaurant: "MariaKids", totalPrice: "187,50", detailedPrice: "37,50")
        }
    }
}
