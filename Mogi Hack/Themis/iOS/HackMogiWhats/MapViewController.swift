//
//  WebViewController.swift
//  HackMogiWhats
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import UIKit
import WebKit

class MapViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let url = URL(string:"https://temis.mybluemix.net")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}



extension MapViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
