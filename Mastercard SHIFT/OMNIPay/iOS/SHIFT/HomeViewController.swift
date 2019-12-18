//
//  HomeViewController.swift
//  SHIFT
//
//  Created by Jean Paul Marinho on 11/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var chartView: ARPieChart!
    @IBOutlet weak var tableView: UITableView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.chartView.dataSource = self
        self.chartView.outerRadius = self.chartView.frame.size.height/2.0
        self.chartView.innerRadius = 10
        self.chartView.labelFont = UIFont.boldSystemFontOfSize(12)
        self.chartView.showDescriptionText = true
        self.chartView.animationDuration = 1
        self.chartView.reloadData()
        if APIClient.sharedInstance.transactionsArray.count > 0 {
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        }
        else {
            let backgroundLabel = UILabel(frame: CGRectMake(0, 20, 280, 20))
            backgroundLabel.textColor = UIColor.whiteColor()
            backgroundLabel.numberOfLines = 0;
            backgroundLabel.textAlignment = NSTextAlignment.Center;
            backgroundLabel.font = UIFont.systemFontOfSize(11)
            backgroundLabel.sizeToFit()
            backgroundLabel.text = "You don't have transactions to show."
            self.tableView.backgroundView = backgroundLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
    }
}


extension HomeViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIClient.sharedInstance.transactionsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? TransactionTableViewCell
        guard cell != nil else {
            return UITableViewCell()
        }
        let transaction = APIClient.sharedInstance.transactionsArray[indexPath.row]
        cell?.vendorLabel.text = transaction.vendor
        cell?.priceLabel.text = "R$\(transaction.totalPrice!)0"
        cell?.dateLabel.text = transaction.dateString!
        return cell!
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}


extension HomeViewController: ARPieChartDataSource {
    func numberOfSlicesInPieChart(pieChart: ARPieChart) -> Int {
        return 2
    }
    
    func pieChart(pieChart: ARPieChart, colorForSliceAtIndex index: Int) -> UIColor {
        switch index {
        case 0:
            return UIColor(red: 70/255.0, green: 170/255.0, blue: 185/255.0, alpha: 1.0)
        case 1:
            return UIColor(red: 145/255.0, green: 203/255.0, blue: 58/255.0, alpha: 1.0)
        default:
            return UIColor.whiteColor()
        }
    }
    
    func pieChart(pieChart: ARPieChart, valueForSliceAtIndex index: Int) -> CGFloat {
        switch index {
        case 0:
            return 30
        case 1:
            return 70
        default:
            return 0
        }
    }
    
    func pieChart(pieChart: ARPieChart, descriptionForSliceAtIndex index: Int) -> String {
        switch index {
        case 0:
            return "R$150,00"
        case 1:
            return "Limite disponível: R$450,00"
        default:
            return ""
        }
    }
}