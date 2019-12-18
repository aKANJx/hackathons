//
//  LoginViewController.swift
//  fiesp5th
//
//  Created by Jean Paul Marinho on 15/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit
import AccountKit

class IntroViewController: UIViewController {
    
    var accountKit: AKFAccountKit?
    var pendingLoginVC: UIViewController?
    var authorizationCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.accountKit == nil {
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        }
        self.pendingLoginVC = self.accountKit?.viewControllerForLoginResume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        
        loginViewController.delegate = self
        loginViewController.advancedUIManager = nil
        loginViewController.theme = AKFTheme.basicTheme()
    }
    
    @IBAction func phoneLoginButtonPressed(_ sender: UIButton) {
        let inputState: String = NSUUID().uuidString
        let viewController:AKFViewController = self.accountKit?.viewControllerForPhoneLogin(with: nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(loginViewController: viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
    }
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        UIApplication.rootViewController(vcName: "RootNavigationController", storyboard: self.storyboard)
    }
    
    @IBAction func emailLoginButtonPressed(sender: UIButton) {
        let inputState: String = NSUUID().uuidString
        let viewController: AKFViewController = self.accountKit?.viewControllerForEmailLogin(withEmail: nil, state: inputState)  as! AKFViewController
        self.prepareLoginViewController(loginViewController: viewController)
        self.present(viewController as! UIViewController, animated: true, completion: { _ in })
    }
}



extension IntroViewController: AKFViewControllerDelegate {
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("Login succcess with AccessToken")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PairViewController")
        guard vc != nil else {
            return
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("Login succcess with AuthorizationCode")
    }
    
    func viewController(_ viewController: UIViewController!, didFailWithError error: Error!) {
        print("We have an error \(error)")
    }
    
    func viewControllerDidCancel(_ viewController: UIViewController!) {
        print("The user cancel the login")
    }
}
