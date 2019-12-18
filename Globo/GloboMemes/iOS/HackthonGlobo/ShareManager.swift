//
//  ShareManager.swift
//  HackthonGlobo
//
//  Created by Bruno Faganello Neto on 13/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import Social


class ShareManager{

    class func shareOnFB(view:UIViewController,url:URL){
        let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookSheet.add(url)
        facebookSheet.setInitialText("Se você esta lendo isso, significa que meu projeto no hackthon está funcionando <3")
        view.present(facebookSheet, animated: true, completion: nil)
    }
    
    class func shareOnTW(view:UIViewController,url:URL){
        let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookSheet.add(url)
        facebookSheet.setInitialText("Share on Facebook")
        view.present(facebookSheet, animated: true, completion: nil)
    }
    
    



}
