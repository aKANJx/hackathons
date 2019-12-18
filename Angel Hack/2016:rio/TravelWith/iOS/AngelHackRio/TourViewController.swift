//
//  TourViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 25/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func itemButtonPressed(_ sender: UIButton) {
        let vc = UIAlertController(title: "Sucesso!", message: "Aguarde a chegada de seu guia...", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        vc.addAction(okAction)
        self.present(vc, animated: true) { 
        }
    }
}
