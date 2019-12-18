//
//  HomeViewController.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 11/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var investments = [Investment]()
    var blurredEffectView: UIVisualEffectView?
    @IBOutlet weak var totalValueLabel: UILabel!
    var sellerTypes = [String]()
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.sellerTypes = ["seller1","seller2","seller3","seller4"]
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self, action: #selector(HomeViewController.loadData), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func loadData() {
        APIClient.purchaseHistory(user: "1191827364") { (success,investments,totalValue) in
            print(investments!)
            self.investments = investments!
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = ""
            self.totalValueLabel.text = formatter.string(from: NSNumber(value: totalValue))
            self.tableView.reloadData()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func removeBlur() {
        UIView.animate(withDuration: 1, animations: {
            self.blurredEffectView!.alpha = 0
        }, completion: {(_) -> Void in
            self.blurredEffectView?.removeFromSuperview()
            self.blurredEffectView = nil
        })
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    @IBAction func friendPressed(_ sender: UIButton) {
        let blurEffect = UIBlurEffect(style: .dark)
        self.blurredEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurredEffectView?.frame = self.view.frame
        view.addSubview(blurredEffectView!)
    }
}


extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.investments.count == 0 {
            return 0
        }
        else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! InvestmentTableViewCell
        let investment = self.investments[indexPath.row]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        cell.purchasePriceLabel.text = "R$\(formatter.string(from: NSNumber(value: investment.purchasePrice))!)"
        cell.valueLabel.text = "R$\(formatter.string(from: NSNumber(value: investment.value))!)"
        cell.sellerTypeImageView.image = UIImage(named: self.sellerTypes[self.randomInt(min: 0, max: self.sellerTypes.count-1)])
        return cell
    }
}



extension HomeViewController: UITableViewDelegate {
    
}
