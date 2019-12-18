//
//  IntroContentViewController.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 11/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

protocol IntroContentViewControllerDelegate {
    func continuePressed(_ vc: IntroContentViewController)
}

class IntroContentViewController: UIViewController {
    var index: Int!
    var delegate: IntroContentViewControllerDelegate?
    
    @IBAction func continuePressed(_ sender: UIButton) {
        self.delegate?.continuePressed(self)
    }
}
