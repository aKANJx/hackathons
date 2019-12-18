//
//  OverlayPresentAnimationController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 15/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class OverlayPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            fromViewController.view.alpha = 0.3
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            fromViewController.view.alpha = 0.3
            transitionContext.completeTransition(true)
        })
    }
}



class OverlayDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0.3
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            fromViewController.view.frame = CGRect(x: 0, y: finalFrameForVC.height, width: finalFrameForVC.width, height: finalFrameForVC.height)
            toViewController.view.alpha = 1.0
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
}



class CoverPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            fromViewController.view.alpha = 0.3
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            fromViewController.view.alpha = 0.3
            transitionContext.completeTransition(true)
        })
    }
}



class CoverDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0.3
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            fromViewController.view.frame = CGRect(x: 0, y: finalFrameForVC.height, width: finalFrameForVC.width, height: finalFrameForVC.height)
            toViewController.view.alpha = 1.0
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
}
