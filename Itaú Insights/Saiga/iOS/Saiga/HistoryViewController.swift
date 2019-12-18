//
//  HistoryViewController.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var titles = ["Vila Olímpia - São Paulo, SP", "Paulista - São Paulo, SP", "Morumbi - São Paulo, SP"]
    var addresses = ["Rua Gomes de Carvalho 446", "Rua Consolação, 1850", "Rua Monsenhor Andrade, 32"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
}



extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryCell
        cell.placeImageView.image = UIImage(named: "history\(indexPath.section+1)")
        cell.titleLabel.text = self.titles[indexPath.section]
        cell.addressLabel.text = self.addresses[indexPath.section]
        let lower : UInt32 = 250
        let upper : UInt32 = 1000
        let randomNumber = arc4random_uniform(upper - lower) + lower
        cell.priceLabel.text = "R$\(randomNumber)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
