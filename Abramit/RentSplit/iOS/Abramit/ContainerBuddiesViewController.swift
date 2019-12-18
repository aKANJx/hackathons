//
//  ContainerBuddiesViewController.swift
//  Abramit
//
//  Created by Jean Paul Marinho on 15/11/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class ContainerBuddiesViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    let renanText = ""
    let jairoText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buddyChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.textView.text = self.renanText
        case 1:
            self.textView.text = self.jairoText
        default:
            self.textView.text = ""
        }
    }
    
}
