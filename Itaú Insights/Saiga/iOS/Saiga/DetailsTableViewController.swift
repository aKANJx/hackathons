//
//  DetailsTableViewController.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    @IBOutlet weak var button: UIButton!{
        didSet{
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Vila Olímpia"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func directionWaze(_ sender: Any) {
       
    }
}
