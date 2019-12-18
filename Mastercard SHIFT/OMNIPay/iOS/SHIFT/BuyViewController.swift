//
//  BuyViewController.swift
//  SHIFT
//
//  Created by Jean Paul Marinho on 11/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import SwiftQRCode

class BuyViewController: UIViewController {

    let scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.scanner.prepareScan(self.view) { (stringValue) in
            self.scanner.stopScan()
            self.performSegueWithIdentifier("toPaymentViewController", sender: stringValue)
        }
        let frameSize = self.view.frame.size
        self.scanner.scanFrame = CGRect(x: 0, y: 60, width: frameSize.width, height: frameSize.height)
        scan()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PaymentViewController
        vc.codeResult = sender as? String
    }
    
    func scan() {
        scanner.startScan()
    }
}
