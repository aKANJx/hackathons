//
//  AddPiggyViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class NewPiggyViewController: UIViewController {
    
    let piggy = Piggy()
    var savingsAcc = 1
    var selectedSavingsRow: Int?
    var savingsAcc2 = [["Account":"4839-4", "Agency":"43.231-2"], ["Account":"7489-4", "Agency":"93.817-2"]]

    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}



extension NewPiggyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return self.savingsAcc
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! AddPiggyTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! AddPiggyTableViewCell
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "privacyCell") as! AddPiggyTableViewCell
            cell.delegate = self
            return cell
        case 3:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "savingsAccButtonCell") as! AddPiggyTableViewCell
                cell.delegate = self
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "savingsAccCell") as! AddPiggySavingsCell
                cell.agencyLabel.text = self.savingsAcc2[indexPath.row-1]["Agency"]
                cell.accountLabel.text = self.savingsAcc2[indexPath.row-1]["Account"]
                cell.delegate = self
                if self.selectedSavingsRow == indexPath.row {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
                cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
                return cell
            }
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "createCell") as! AddPiggyTableViewCell
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 144
        case 1:
            return 82
        case 2:
            return 123
        case 3:
            return 44
        case 4:
            return 100
        default:
            return 1
        }
    }
}



extension NewPiggyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.cellForRow(at: indexPath) as! AddPiggySavingsButtonCell
                cell.plusImageView.isHidden = true
                cell.selectionStyle = .none
                self.savingsAcc = 3
                tableView.insertRows(at: [IndexPath(row: 1, section: 3), IndexPath(row: 2, section: 3)], with: .top)
            }
            else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.selectedSavingsRow = indexPath.row
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row != 0 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.selectedSavingsRow = nil
        }
    }
    
}



extension NewPiggyViewController: AddPiggyDelegate {
    
    func createPressed(sender: UIButton) {
        if piggy.isPublic == nil {
            piggy.isPublic = true
        }
        guard self.piggy.title != nil else {
            return
        }
        self.piggy.alias = self.piggy.title!
        UserDefaults.standard.set(UIImagePNGRepresentation(self.piggy.image!), forKey: self.piggy.alias!)
        APIClient.newPiggy(piggy: self.piggy) { (error) in
            guard error == nil else {
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    func piggyUpdated(sender: AddPiggyTableViewCell) {
        switch sender {
        case is AddPiggyHeaderCell:
            self.piggy.title = (sender as! AddPiggyHeaderCell).nameTextField.text
            self.piggy.image = (sender as! AddPiggyHeaderCell).imageButton.imageView?.image
        case is AddPiggyDescriptionCell:
            self.piggy.about = (sender as! AddPiggyDescriptionCell).textView.text
        case is AddPiggyPrivacyCell:
            self.piggy.isPublic = (sender as! AddPiggyPrivacyCell).isPublic.isOn
        default:
            print("")
        }
    }
    
    func changedImagePressed(sender: UIButton) {
        PickerController.shared.showPicker(in: self) { (image) in
            sender.setImage(image, for: .normal)
            self.piggy.image = image
        }
    }
}
