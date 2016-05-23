//
//  TransitionOperator.swift
//  NavTransition
//
//  Created by Tope Abayomi on 21/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.

// Modified by PekkiPo (Aleksei Petukhov) (c) 2015

//

import Foundation
import UIKit


///protocol to send back listid and other parameters
/*
protocol sendBackParametersToShopDelegate
{
    func getshopparameters(isFrom: Bool, listid:String, isreceived: Bool)
}
*/

class TransitionOperator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, passListtoMenuDelegate {
    
    
   // var shoplistdelegate : sendBackParametersToShopDelegate?
    
    
    var snapshot : UIView!
    var isPresenting : Bool = true
    
    var isFromShopList = Bool()
    var shoplistid = String()
    var shoplistisrec = Bool()
    ///my stuff!
    
    func getshoplistparameters(isFrom:Bool,listid:String,isreceived: Bool) {
        
        isFromShopList = isFrom
        shoplistid = listid
        shoplistisrec = isreceived
        print("SO ID IS \(shoplistid)")
        
        //finalize
        
    }

    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
       // return 0.5
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting{
            presentNavigation(transitionContext)
        }else{
            dismissNavigation(transitionContext)
        }
    }
    
    func presentNavigation(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromViewController!.view
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toViewController!.view
        
        toView.transform = getOffsetTransform(toView)
        container!.addSubview(toView)
        
        let duration = self.transitionDuration(transitionContext)
        
       // self.shoplistdelegate?.getshopparameters(self.isFromShopList, listid: self.shoplistid, isreceived: self.shoplistisrec)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            
            toView.transform = CGAffineTransformIdentity
            
           
            
            }, completion: { finished in
                //// MY STUFF
               // self.shoplistdelegate?.getshopparameters(self.shoplistid, iscreated: false, isreceived: false)
                ////
              
                
                transitionContext.completeTransition(true)
               // self.shoplistdelegate?.getshopparameters(self.isFromShopList, listid: self.shoplistid, isreceived: self.shoplistisrec)
        })
        
        
        
        //my part - try to segue to snapshot controller
        //container.add
        //let button   = UIButton(type: UIButtonType.System) as UIButton
        
        //let buttonSizex = Int(container.si
        
       // button.frame = CGRectMake(100, 100, 100, 50)
       // var bounds = container.bounds
        //let button = UIButton(frame: bounds)//(x: 0, y: 0, width: 44, height: 44))
       // button.alpha = 0
       // button.addTarget(self, action: "dismissNavigation:", forControlEvents: .TouchUpInside)
       // container.addSubview(button)
      //  button.addTarget(self, action: "makesegue:", forControlEvents: .TouchUpInside)
        //button.addTarget(self, action: <#Selector#>, forControlEvents: <#UIControlEvents#>)// forControlEvents: .TouchUpInside)
     
        
    }
    
    
    ///my stuff
    func makesegue(controllerFrom: UIViewController, controllerTo: UIViewController) {
     
       // controller.presentViewController(controller, animated: true, completion: nil)
         controllerFrom.presentViewController(controllerTo, animated: true, completion: nil)
    }
    
    
    func dismissNavigation(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        
        
        //let fromViewController = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
        
        
        let fromView = fromViewController!.view
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! MainMenuViewController
        //let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
       // let toViewController = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
        
        let toView = toViewController.view
        
        toView.hidden = false
        
        let duration = self.transitionDuration(transitionContext)
        
        let transform = getOffsetTransform(fromView)
        snapshot = fromView.snapshotViewAfterScreenUpdates(true)
        container!.addSubview(snapshot)
        
        fromView.hidden = true
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.snapshot.transform = transform
            
             //self.getshoplist()

            
            }, completion: { finished in
                transitionContext.completeTransition(true)
                //toViewController.finalizeTransitionWithSnapshot(self.snapshot)
                
                print([self.isFromShopList, self.shoplistid, self.shoplistisrec])
                
                
                //toViewController.finalizeTransitionWithSnapshot(self.snapshot, senderVC: fromViewController!, isFrom: self.isFromShopList, listid: self.shoplistid, isreceived: self.shoplistisrec)
               // toViewController.finalizeTransitionWithSnapshot(self.snapshot, senderVC: fromViewController!)
                toViewController.finalizeTransitionWithSnapshot(self.snapshot, senderVC: fromViewController!)
                  print([self.isFromShopList, self.shoplistid, self.shoplistisrec])
                //isFrom: Bool, listid:String, isreceived: Bool
                //, listid: toViewController.shoplistid) // I add here info about the sender view controller
               // toViewController.getshoplist(isFrom: true, listid: )
        })
    }
    
    func getOffsetTransform(view: UIView) -> CGAffineTransform {
        
        let size = view.frame.size
        var offSetTransform = CGAffineTransformMakeTranslation(size.width - 40, 0)//- 120, 0)
        offSetTransform = CGAffineTransformScale(offSetTransform, 0.9, 0.9)//0.6, 0.6)
        
        return offSetTransform
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = false
        return self
    }
}