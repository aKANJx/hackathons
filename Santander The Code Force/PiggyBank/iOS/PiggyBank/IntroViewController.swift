//
//  IntroViewController.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 11/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class IntroViewController: UIPageViewController {

    var introVC = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "IntroVC", ofType: "plist")
        introVC = NSArray(contentsOfFile: path!) as! [String]
        self.dataSource = self
        self.delegate = self
        let vc = self.viewController(0)
        self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    func viewController(_ index: Int) -> IntroContentViewController {
        let vc = IntroContentViewController(nibName: self.introVC[index], bundle: nil)
        vc.index = index
        vc.delegate = self
        return vc
    }
    
    func toRootNavigationVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}



extension IntroViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! IntroContentViewController).index!
        guard index > 0 else {
            return nil
        }
        let vc = self.viewController(index-1)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! IntroContentViewController).index!
        guard index < self.introVC.count-1 else {
            return nil
        }
        let vc = self.viewController(index+1)
        return vc
    }
}



extension IntroViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return introVC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


extension IntroViewController: IntroContentViewControllerDelegate {
    func continuePressed(_ vc: IntroContentViewController) {
        self.toRootNavigationVC()
    }
}
