//
//  SettingsViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}



extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        }
}



extension SettingsViewController: UITableViewDelegate {
    
}
