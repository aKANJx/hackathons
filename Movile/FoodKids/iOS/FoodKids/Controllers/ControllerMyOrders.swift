//
//  ControllerMyOrders.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class ControllerMyOrders: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ControllerMyOrders {

   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderHeaderCell") as! OrderHeaderCell
        switch section {
        case 0:
            cell.titleLabel.text = "Em Revisão"
        case 1:
            cell.titleLabel.text = "Histórico"
        default:
            cell.titleLabel.text = ""
        }
        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return 1
    }
        return 3
    }
    
  override  func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
  override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if(indexPath.section == 0 ){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellReview") as! CellReview
            cell.delegate = self
            cell.lbDate.text = "20/08/2018"
            cell.lbDetailPrice.text = "37,50 por dia"
            cell.lbTotalPrice.text = "187,50 por semana"
            
            return cell
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHistoric") as! CellHistoric
    
        cell.lbDate.text = "20/08/2018"
        cell.lbDetailPrice.text = "37,50 por dia"
        cell.lbTotalPrice.text = "187,50 por semana"
    
        return cell
    }
}




extension ControllerMyOrders: CellReviewDelegate {
    
    func buttonClicked() {
        let alert = UIAlertController(title: "Finalizado", message: "Obrigado por comprar conosco! :)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
