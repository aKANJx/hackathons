//
//  PaymentViewController.swift
//  SHIFT
//
//  Created by Jean Paul Marinho on 11/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class PaymentViewController: UIViewController {

    var codeResult: String?
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorProfileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var transaction = Transaction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        let data = NSData(base64EncodedString: codeResult!, options: NSDataBase64DecodingOptions(rawValue: 0))
        let json = (JSON(data: data!))
        print(json)
        self.transaction.vendor = json["vendorName"].stringValue
        self.vendorNameLabel.text = self.transaction.vendor!
        self.transaction.totalPrice = Float(json["total"].stringValue)
        self.totalPriceLabel.text = "R$\(self.transaction.totalPrice!)0"
        var productsArray: [Product] = []
        for object in json["products"].arrayValue {
            let product = Product()
            product.name = object["productName"].stringValue
            product.price = "R$\(object["productPrice"].stringValue)"
            productsArray.append(product)
        }
        self.transaction.productsArray = productsArray
        self.transaction.dateString = "12/06"
        APIClient.sharedInstance.transactionsArray.append(self.transaction)
        self.vendorProfileImageView.af_setImageWithURL(NSURL(string: json["vendorImg"].stringValue)!)
    }
    
    @IBAction func paymentButtonPressed(sender: UIButton) {
        let chargeVC = SIMChargeCardViewController(publicKey: "sbpb_MmQzNTVjOWQtZTMzYy00NmNkLTk3NjEtNDUwMzE2ZThhYWRi")
        chargeVC.delegate = self
        if APIClient.sharedInstance.creditCardUsed {
            creditCardHandler()
        }
        else {
            self.presentViewController(chargeVC, animated: true, completion: nil)
            APIClient.sharedInstance.creditCardUsed = true
        }
    }
    
    func creditCardHandler() {
        SweetAlert().showAlert("Thank you!", subTitle: "Your payment has been processed successfully", style: AlertStyle.Success)
        self.tabBarController?.selectedIndex = 0
    }
}



extension PaymentViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transaction.productsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? ProductTableViewCell
        guard cell != nil else {
            return UITableViewCell()
        }
        cell?.nameLabel.text = self.transaction.productsArray[indexPath.row].name!
        cell?.priceLabel.text = self.transaction.productsArray[indexPath.row].price!
        return cell!
    }
}



extension PaymentViewController: UITableViewDelegate {
    
}



extension PaymentViewController: SIMChargeCardViewControllerDelegate {
    func creditCardTokenProcessed(token: SIMCreditCardToken!) {
        print("Token: \(token)")
        creditCardHandler()
    }
    
    func chargeCardCancelled() {
    }
    
    func creditCardTokenFailedWithError(error: NSError!) {
    }
}