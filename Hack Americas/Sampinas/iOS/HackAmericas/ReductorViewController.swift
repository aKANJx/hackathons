//
//  ReductorViewController.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import UIKit
import Lottie

class ReductorViewController: UITableViewController {

    @IBOutlet var originalContainerView: UIView!
    @IBOutlet var finalContainerView: UIView!
    @IBOutlet var packageDoneView: UIView!
    
    @IBOutlet var packageView: UIView!
    @IBOutlet var packageView2: UIView!
    @IBOutlet var friendView: UIView!
    @IBOutlet var originalPriceLabel: UILabel!
    @IBOutlet var acceptedChallengeLabel: UILabel!
    var originalPrice: Double {
        return Double(originalPriceLabel.text!.replacingOccurrences(of: ",", with: "."))!
    }
    @IBOutlet var finalPriceLabel: UILabel!
    var finalPrice: Double {
        set {
            finalPriceLabel.text = "\(newValue)"
        }
        get {
            return Double(originalPriceLabel.text!.replacingOccurrences(of: ",", with: "."))!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalContainerView.isHidden = true
        packageView.layer.roundCorners(radius: 12)
        packageView.layer.addShadow()
        packageView2.layer.roundCorners(radius: 12)
        packageView2.layer.addShadow()
        friendView.layer.roundCorners(radius: 12)
        friendView.layer.addShadow()
    }
    
    func decreaseFromValue(amount: Double) {
        var price = originalPrice - amount
        if price <= 0 {
            price = 0
        }
        finalPrice = price
    }
    
    @IBAction func sharePressed(_ sender: UIButton) {
        let text = "Download this awesome app and use my personal code: aIJDASncsawq9131ADS"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        parent?.dismiss(animated: true, completion: nil)
    }
}



extension ReductorViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        acceptedChallengeLabel.isHidden = false
        let animView = LOTAnimationView(name: "checked_done_")
        animView.contentMode = .scaleAspectFit
        animView.frame = packageDoneView.bounds
        packageDoneView.addSubview(animView)
        animView.play()
        decreaseFromValue(amount: 1.3)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            self.originalContainerView.center = CGPoint(x: self.originalContainerView.center.x, y: self.originalContainerView.center.y - 40)
            self.originalContainerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.originalContainerView.alpha = 0.5
        }) { (success) in
            self.finalContainerView.isHidden = false
        }
    }
}
