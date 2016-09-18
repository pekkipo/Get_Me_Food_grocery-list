//
//  WalkthroughViewController.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 09/02/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController
{

    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var smalltip: UILabel!
    
    @IBOutlet var swipeleft: UILabel!
    
    
    
    @IBOutlet var getstarted: UIButton!
    
    
    
    @IBOutlet var loginview: UIView!
    
    @IBOutlet var signuplogin: UIButton!
    
    @IBOutlet var PageControl: UIPageControl!

    
    @IBOutlet var yesoutlet: UIButton!
    
    
    
    
    var index = 0
    var headertext = ""
    var imageName = ""
    var descriptiontext = ""
    


   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        imageView.image = UIImage(named: imageName)
        PageControl.currentPage = index
        
        if UIScreen.mainScreen().nativeBounds.height == 960 {

        }

        
        // customize the next and start button
        //getstarted.hidden = (index == 1) ? false : true
        
        loginview.hidden = (index == 1) ? false : true // basically switched this off for now
        
        yesoutlet.hidden = (index == 0) ? false : true
        
        imageView.hidden = (index == 0) ? false : true
        
        smalltip.hidden = (index == 0) ? false : true
        
        swipeleft.hidden = (index == 0) ? false : true
        
    }
    
    
    @IBAction func signupTap(sender: AnyObject) {
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        if loggedIn == true {
             self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            /*
            if let loginViewController = storyboard?.instantiateViewControllerWithIdentifier("loginVC") as? PageViewController {
                
                self.presentViewController(loginViewController, animated: true, completion: nil)
                
            }
            */
            let menu = storyboard?.instantiateViewControllerWithIdentifier("SideMenu") as? MainMenuViewController
            performSegueWithIdentifier("signuporloginsegue", sender: menu)
            
            
        }

      //  signuporloginsegue
        
    }
    
    
    
    
    @IBAction func skipTap(sender: AnyObject) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        //var counter : Int = 4 - index
        
        let pageViewController = self.parentViewController as! PageViewController
       // pageViewController.nextPageWithIndex(index+counter)
        pageViewController.nextPageWithIndex(index) //SWITCHED OFF
        
      //  self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func startTap(sender: AnyObject)
        
    {
       
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "signuporloginsegue" {
            
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let  toViewController = navVC.viewControllers.first as! LoginViewController
            
            
            toViewController.senderVC = "tutorial"
        }
    }

}

