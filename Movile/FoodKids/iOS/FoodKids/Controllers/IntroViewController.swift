//
//  IntroChildViewController.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var introChildView: IntroChildView!
    @IBOutlet var introRestrictionView: IntroRestrictionView!
    @IBOutlet var proceedButton: AppButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.introChildView.nameLabel.delegate = self
        self.containerView.addSubview(self.introChildView)
        self.introChildView.alpha = 0
        self.introChildView.center.y += 100
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(IntroViewController.keyboardWillShowNotification(_:)),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(IntroViewController.keyboardWillHideNotification(_:)),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
            self.introChildView.alpha = 1
            self.introChildView.center.y -= 100
        }, completion: nil)
        self.proceedButton.isHidden = true
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard self.introRestrictionView.superview == nil else {
            (UIApplication.shared.delegate as! AppDelegate).showHome()
            return
        }
        self.introChildView.removeFromSuperview()
        self.containerView.addSubview(self.introRestrictionView)
        self.introRestrictionView.alpha = 0
        self.introRestrictionView.center.y += 100
        self.proceedButton.center.y += 200
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
            self.introRestrictionView.alpha = 1
            self.introRestrictionView.center.y -= 100
        }, completion: { (success) in
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
            }, completion: nil)
            self.proceedButton.center.y -= 200
        })
    }
    
    @objc
    func keyboardWillShowNotification(_ notification: NSNotification) {
        if self.introChildView.wieghtTextField.isEditing {
            self.proceedButton.isHidden = false
            self.view.window?.frame.origin.y = -1 * 220
        }
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            self.view.window?.frame.origin.y += 220
        }
    }
}



extension IntroViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
