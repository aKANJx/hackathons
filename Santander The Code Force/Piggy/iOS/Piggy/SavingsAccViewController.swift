//
//  PaymentViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 15/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class SavingsAccViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createSavingsAcc: UIButton!
    let cellHeight = 44
    var selectedRow: Int?
    var savingsAcc = [["Account":"4839-4", "Agency":"43.231-2"], ["Account":"7489-4", "Agency":"93.817-2"]]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tableViewFrame = self.tableView.frame
        self.tableView.frame = CGRect(x: tableViewFrame.origin.x, y: tableViewFrame.origin.y, width: tableViewFrame.width, height: CGFloat(self.cellHeight*3))
        let buttonFrame = self.createSavingsAcc.frame
        self.createSavingsAcc.frame = CGRect(x: buttonFrame.origin.x, y: tableViewFrame.origin.y + self.tableView.frame.height + 20, width: buttonFrame.width, height: buttonFrame.height)
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 1
        })
    }

    @IBAction func proceedPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
        }, completion: { (success) in
            self.performSegue(withIdentifier: "ToWelcomeVC", sender: nil)
        })
    }
}



extension SavingsAccViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savingsAcc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SavingsTableViewCell
        cell.agencyLabel.text = self.savingsAcc[indexPath.row]["Agency"]
        cell.accountLabel.text = self.savingsAcc[indexPath.row]["Account"]
        if self.selectedRow == indexPath.row {
            cell.accessoryType = .checkmark
        }
        cell.accessoryType = .none
        return cell
    }
}



extension SavingsAccViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.selectedRow = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        self.selectedRow = nil
    }
    
}
