//
//  ViewController.swift
//  Abramit
//
//  Created by Jean Paul Marinho on 15/11/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}



extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProfileCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Pagamentos"
            cell.iconImageView.image = UIImage(named: "receipt-icon")!
        case 1:
            cell.titleLabel.text = "Contrato"
            cell.iconImageView.image = UIImage(named: "agreement-icon")!
        case 2:
            cell.titleLabel.text = "Reportar Problemas"
            cell.iconImageView.image = UIImage(named: "report-icon")!
        default:
            break
        }
        return cell
    }
}



extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "PaymentSegue", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "AgreementSegue", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "ReportSegue", sender: nil)
        default:
            break
        }
    }
}


