//
//  File.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 02/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//


import Foundation
import UIKit

class TransitionOperator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate{
    
    var snapshot : UIView!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -&gt; NSTimeInterval {
    return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -&gt; UIViewControllerAnimatedTransitioning? {
    
    return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -&gt; UIViewControllerAnimatedTransitioning? {
    
    return self
    }
}