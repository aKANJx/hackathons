//
//  LoginViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var authenticationContext = LAContext()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "loggedUser") {
            self.loginWithTouchID()
        }
    }
    
    @IBAction func proceedPressed(_ sender: UIButton) {
        self.removeKeyboard()
        guard self.cpfTextField.text != "" && self.passwordTextField.text != "" else {
            return
        }
        NotificationController.shared.showLoadingIndicator(view: self.view)
        APIClient.sendLogin(cpf: self.cpfTextField.text!, password: self.passwordTextField.text!) { (error, newUser) in
            NotificationController.shared.removeLoadingIndicator()
            guard error == nil else {
                let errorAlert = UIAlertController(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                errorAlert.addAction(alertAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.contentView.alpha = 0
            }, completion: { (success) in
                if newUser! {
                    self.performSegue(withIdentifier: "ToPiggyAdvisorVC", sender: nil)
                }
                else {
                    self.loggedExistentUser()
                }
            })
        }
    }
    
    @IBAction func backgroundViewTapped(_ sender: UITapGestureRecognizer) {
        self.removeKeyboard()
    }
    
    func removeKeyboard() {
        self.cpfTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func loggedExistentUser() {
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RootTabBarController")
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
    
    func loginWithTouchID() {
        var error:NSError?
        guard self.authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return
        }
        self.authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Acesso aos seus Piggies",
            reply: { [unowned self] (success, error) -> Void in
                if( success ) {
                    self.loggedExistentUser()
                }
        })
    }
}



extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.removeKeyboard()
        return true
    }
}
