//
//  CarCategoryDetailViewController.swift
//  Torq
//
//  Created by Felipe Antonio Cardoso on 20/10/2018.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Charts

class CarCategoryDetailViewController: UIViewController {
    
    var category: CarCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = category?.category
    }
}
