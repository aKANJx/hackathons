//
//  ReviewViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 21/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import PassKit

class ReviewViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var carLabel: UILabel!
    @IBOutlet var applePayContainerView: UIView!
    @IBOutlet var panelHeightConstraint: NSLayoutConstraint!
    var car: Car!
    var carImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //car = AppInfo.shared.car
        carLabel.text = "\(car.brand) \(car.model)"
        imageView.af_setImage(withURL: URL(string: car.imageURL)!)
        let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        applePayButton.addTarget(self, action: #selector(applePayPressed), for: .touchUpInside)
        applePayContainerView.addSubview(applePayButton)
        panelHeightConstraint.constant = 50
    }
    
    @objc func applePayPressed(sender: UIButton) {
        let paymentNetworks: [PKPaymentNetwork] = [.masterCard, .visa]
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.com.aKANJ.Plantae.applepay"
            request.countryCode = "BR"
            request.currencyCode = "BRL"
            request.supportedNetworks = paymentNetworks
            request.merchantCapabilities = .capabilityCredit
            let summaryItem = PKPaymentSummaryItem(label: "Plantae", amount: NSDecimalNumber(value: 15.50), type: .final)
            let taxSummaryItem = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(value: 1.30), type: .final)
            let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: 16.80), type: .final)
            request.paymentSummaryItems = [summaryItem, taxSummaryItem, total]
            let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request)
            authorizationViewController?.delegate = self
            present(authorizationViewController!, animated: true, completion: nil)
        }
    }
    
    @IBAction func visitValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            panelHeightConstraint.constant = 214
        }
        else {
            panelHeightConstraint.constant = 50
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ReviewViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: false, completion: nil)
    }
}

