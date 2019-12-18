//
//  CreatePersonalPiggyViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class CreatePersonalPiggyViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var aliasTextField: UITextField!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.alpha = 0
        self.imageButton.layer.cornerRadius = self.imageButton.frame.width / 2.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 1
        })
    }
    
    @IBAction func imagePressed(_ sender: UIButton) {
        PickerController.shared.showPicker(in: self) { (image) in
            sender.setImage(image, for: .normal)
            self.placeholderImageView.isHidden = true
        }
    }
    
    @IBAction func proceedPressed(_ sender: UIButton) {
        self.removeKeyboard()
        UserDefaults.standard.set(UIImagePNGRepresentation(self.imageButton.image(for: .normal)!), forKey: self.aliasTextField.text!)
        let alias = self.aliasTextField.text
        guard alias != "" else {
            return
        }
        NotificationController.shared.showLoadingIndicator(view: self.view)
        let image = self.imageButton.image(for: .normal)
        APIClient.createPersonalPiggy(alias: alias!, image: image) { (error) in
            NotificationController.shared.removeLoadingIndicator()
            guard error == nil else {
                NotificationController.shared.showAlert(viewController: self, title: "Erro", message: (error?.localizedDescription)!)
                return
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.contentView.alpha = 0
            }, completion: { (success) in
                self.performSegue(withIdentifier: "ToSavingsVC", sender: nil)
            })
        }
    }
    
    @IBAction func backgroundViewTapped(_ sender: UITapGestureRecognizer) {
        self.removeKeyboard()
    }
    
    func removeKeyboard() {
        self.aliasTextField.resignFirstResponder()
    }
}
