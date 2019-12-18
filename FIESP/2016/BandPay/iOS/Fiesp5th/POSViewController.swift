//
//  POSViewController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class POSViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RingReaderViewController
        var value: String = self.displayLabel.text!
        value = value.replacingOccurrences(of: ",00", with: "")
        vc.amount = Int(value)
        print(vc.amount)
    }
    
    @IBAction func valueButtonPressed(_ sender: UIButton) {
        var value: String = self.displayLabel.text!
        if value == "0,00" {
            value = ""
        }
        value = value.replacingOccurrences(of: ",00", with: "")
        value = "\(value)\(sender.titleLabel!.text!)\(",00")"
        self.displayLabel.text = value
    }
    
    @IBAction func eraseButtonPressed(_ sender: UIButton) {
        var value: String = self.displayLabel.text!
        if value.characters.count == 4 {
        }
        value = value.replacingOccurrences(of: ",00", with: "")
        value = "\(value)\(sender.titleLabel!.text!)\(",00")"
        self.displayLabel.text = value
    }
    
    @IBAction func sellButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toRingReaderVC", sender: nil)
    }
}
