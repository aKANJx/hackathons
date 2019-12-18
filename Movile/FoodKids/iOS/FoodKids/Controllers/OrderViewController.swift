//
//  OrderViewController.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    let weekdays = [
        "Domingo",
        "Segunda",
        "Terça",
        "Quarta",
        "Quinta",
        "Sexta",
        "Sábado,"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnReturn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderHeaderCell") as! OrderHeaderCell
        switch section {
        case 0:
            cell.titleLabel.text = "Café da manhã"
        case 1:
            cell.titleLabel.text = "Almoço"
        case 2:
            cell.titleLabel.text = "Jantar"
        default:
            cell.titleLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell") as! OrderTableCell
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        return cell
    }
}




extension OrderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weekdays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCollectionCell", for: indexPath) as! OrderCollectionCell
        cell.circleImageView.image = UIImage(named: "homeCell\(Int.random(in: 1 ... 7))")
        cell.titleLabel.text = self.weekdays[indexPath.row]
        cell.priceLabel.text = "R$\(Int.random(in: 10 ... 18))-\(Int.random(in: 19 ... 28))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ENTROU")
    }
}
