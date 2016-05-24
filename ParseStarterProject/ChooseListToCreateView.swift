//
//  ChooseListToCreateView.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 06/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ChooseListToCreateView: UIViewController {
    
    
    
    @IBAction func shoplist(sender: AnyObject) {
        
        performSegueWithIdentifier("createShopList", sender: self)
     //   performSegueWithIdentifier("createShopList", sender: AllListsVC())
        
    }
    
    
    @IBAction func todolist(sender: AnyObject) {
        
         performSegueWithIdentifier("createToDoList", sender: self)
       // performSegueWithIdentifier("createToDoList", sender: AllListsVC())
    }
    
    
    @IBOutlet var shopoutlet: UIButton!
    
    @IBOutlet var todooutlet: UIButton!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createShopList" {
            
            //  let shopNav = segue.destinationViewController as! UINavigationController
            //let shopVC = shopNav.viewControllers.first as! ShoppingListCreation
            
            let shopVC = segue.destinationViewController as! ShoppingListCreation
            
            shopVC.senderVC = self
            shopVC.justCreatedList = true
            shopVC.isReceivedList = false
            
            
            
        }
        
        if segue.identifier == "createToDoList" {
            
            //  let shopNav = segue.destinationViewController as! UINavigationController
            //let shopVC = shopNav.viewControllers.first as! ShoppingListCreation
            
            let shopVC = segue.destinationViewController as! ToDoListCreation
            
            shopVC.senderVC = self
            shopVC.justCreated = true
            shopVC.isReceived = false
            
            
            
        }


    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        //view.addSubview(blurEffectView)
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        view.alpha = 0.70
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
