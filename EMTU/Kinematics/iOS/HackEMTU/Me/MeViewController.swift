//
//  MeViewController.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var settingsCount = 3
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.tabBarController?.viewControllers?.count == 3 && self.settingsCount == 3 {
            self.settingsCount = self.settingsCount - 1
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! KeeperAdViewController
        destinationVC.tabBarControllerRef = sender as! UITabBarController
    }
}



extension MeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return self.settingsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")!
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell")
                return cell!
            default:
                return UITableViewCell()
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
            cell.delegate = self
            switch indexPath.row {
            case 0:
                cell.actionButton.setTitle("Notifications", for: .normal)
            case 1:
                cell.actionButton.setTitle("Settings", for: .normal)
            case 2:
                cell.actionButton.setTitle("Become a Keeper", for: .normal)
            default:
                cell.actionButton.setTitle("", for: .normal)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 60
        default:
            return 180
        }
    }
}



extension MeViewController: SettingsCellDelegate {
    
    func actionPressed(button: UIButton) {
        self.performSegue(withIdentifier: "ToKeeperAdVC", sender: self.tabBarController)
    }
}
