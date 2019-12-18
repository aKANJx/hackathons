//
//  RootViewController.swift
//  SHIFT
//
//  Created by Jean Paul Marinho on 11/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import AccountKit

class LoginViewController: UIViewController {

    var accountKit: AKFAccountKit?
    var pendingLoginVC: UIViewController?
    var authorizationCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.accountKit == nil {
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.AccessToken)
        }
        self.pendingLoginVC = self.accountKit?.viewControllerForLoginResume()
//        let facebookLoginButton = FBSDKLoginButton()
//        facebookLoginButton.center = self.view.center
//        self.view.addSubview(facebookLoginButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.accountKit!.currentAccessToken != nil) {
            // if the user is already logged in, go to the main screen
            print("User already logged in go to ViewController")
            dispatch_async(dispatch_get_main_queue(), {
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("RootTabBarController")
                self.presentViewController(vc!, animated: false, completion: nil)
            })
        }
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        
        loginViewController.delegate = self
        loginViewController.advancedUIManager = nil
        //Costumize the theme
        let theme:AKFTheme = AKFTheme.defaultTheme()
        theme.headerBackgroundColor = UIColor(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1.0)
        theme.headerTextColor = UIColor.whiteColor()
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .LightContent
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        theme.buttonTextColor = UIColor.whiteColor()
        theme.buttonBackgroundColor = UIColor(red: 70/255.0, green: 170/255.0, blue: 185/255.0, alpha: 1.0)
        loginViewController.theme = theme
    }
    
    @IBAction func phoneLoginButtonPressed(sender: UIButton) {
        //login with Phone
        let inputState: String = NSUUID().UUIDString
        let viewController:AKFViewController = self.accountKit?.viewControllerForPhoneLoginWithPhoneNumber(nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.presentViewController(viewController as! UIViewController, animated: true, completion: nil)
    }
    
    @IBAction func emailLoginButtonPressed(sender: UIButton) {
        //login with Email
        let inputState: String = NSUUID().UUIDString
        let viewController: AKFViewController = self.accountKit?.viewControllerForEmailLoginWithEmail(nil, state: inputState)  as! AKFViewController
        self.prepareLoginViewController(viewController)
        self.presentViewController(viewController as! UIViewController, animated: true, completion: { _ in })
    }
}



extension LoginViewController: AKFViewControllerDelegate {
    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        print("Login succcess with AccessToken")
    }
    func viewController(viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("Login succcess with AuthorizationCode")
    }
    func viewController(viewController: UIViewController!, didFailWithError error: NSError!) {
        print("We have an error \(error)")
    }
    func viewControllerDidCancel(viewController: UIViewController!) {
        print("The user cancel the login")
    }
}