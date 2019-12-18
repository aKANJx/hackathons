//
//  PaymentView.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI
import UIKit
import PassKit

struct PaymentButton: UIViewRepresentable {
    
    func makeCoordinator() -> () {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> UIView {
        let paymentButton = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .black)
        return paymentButton
    }
    func updateUIView(_ uiView: UIView, context: Context) { }
}


struct PaymentViewController: UIViewControllerRepresentable {
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    func makeUIViewController(context: Context) -> UIViewController {
        let paymentNetworks:[PKPaymentNetwork] = [.amex,.masterCard,.visa]
        let request = PKPaymentRequest()
        
        request.merchantIdentifier = "merchant.com.aKANJ.Boali"
        request.countryCode = "BR"
        request.currencyCode = "BRL"
        request.supportedNetworks = paymentNetworks
        request.requiredShippingContactFields = [.name, .postalAddress]
        let salad = PKPaymentSummaryItem(label: "Salada", amount: NSDecimalNumber(decimal:27), type: .final)
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(decimal:27), type: .final)
        request.paymentSummaryItems = [salad, total]
        
        let vc = PKPaymentAuthorizationViewController(paymentRequest: request)!
        vc.delegate = context.coordinator
        UIApplication.shared.windows[0].rootViewController!.present(vc, animated: true, completion: nil)
        return vc
    }
    
    func show() {
        let paymentNetworks:[PKPaymentNetwork] = [.amex,.masterCard,.visa]
        let request = PKPaymentRequest()
        
        request.merchantIdentifier = "merchant.com.aKANJ.JKIguatemi.applepay"
        request.countryCode = "BR"
        request.currencyCode = "BRL"
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.supportedNetworks = paymentNetworks
        request.requiredShippingContactFields = [.name, .postalAddress]
        let salad = PKPaymentSummaryItem(label: "Salada", amount: NSDecimalNumber(decimal:27.50), type: .final)
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(decimal:27.50), type: .final)
        request.paymentSummaryItems = [salad, total]
        
        let vc = PKPaymentAuthorizationViewController(paymentRequest: request)!
        vc.delegate = makeCoordinator()
        UIApplication.shared.windows[0].rootViewController!.present(vc, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            APIClient.postOrder(using: "Salada com: Ovo, salmão e alface")
            UIApplication.shared.windows[0].rootViewController!.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
    }
    
    class Coordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
