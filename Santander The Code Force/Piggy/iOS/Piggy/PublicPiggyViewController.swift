//
//  PublicPiggyViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 17/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class PublicPiggyViewController: UIViewController {
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet var piggyImageView: PiggyImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var actionsView: UIView!
    var piggy: Piggy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        self.bottomBackgroundView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        self.view.backgroundColor = UIColor.clear
        self.fillScreen()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.actionsView.frame = self.view.bounds
        self.actionsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.actionsView.insertSubview(blurEffectView, at: 0)
    }
    
    func fillScreen() {
        self.titleLabel.text = self.piggy.title!
        self.piggyImageView.image(image: self.piggy.image!, withType: PiggyType(rawValue: self.piggy.type!.rawValue)!)
        self.descriptionTextView.text = self.piggy.about!
    }
    
    @IBAction func helpPressed(_ sender: UIButton) {
        
    }
}
