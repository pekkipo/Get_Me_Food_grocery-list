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

    
    @IBOutlet var desclabel: UILabel!
    
    
    
    @IBOutlet var getstarted: UIButton!
    
    
    
    @IBOutlet var loginview: UIView!
    
    @IBOutlet var signuplogin: UIButton!
    
    @IBOutlet var PageControl: UIPageControl!

    
    @IBOutlet var yesoutlet: UIButton!
    
    
    var index = 0
    var headertext = ""
    var imageName = ""
    var descriptiontext = ""
    

    
    @IBOutlet var constr1: NSLayoutConstraint!
    
    
    @IBOutlet var constr2: NSLayoutConstraint!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        desclabel.text = descriptiontext
        imageView.image = UIImage(named: imageName)
        PageControl.currentPage = index
        
        if UIScreen.mainScreen().nativeBounds.height == 960 {

        }

        
        // customize the next and start button
        getstarted.hidden = (index == 1) ? false : true
        
        loginview.hidden = (index == 1) ? false : true
        
    }
    
    
    @IBAction func signupTap(sender: AnyObject) {
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        if loggedIn == true {
             self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            
            // self.dismissViewControllerAnimated(true, completion: nil)
            
            if let loginViewController = storyboard?.instantiateViewControllerWithIdentifier("loginVC") as? PageViewController {
                
                self.presentViewController(loginViewController, animated: true, completion: nil)
                
            }
            
            
        }

      //  signuporloginsegue
        
    }
    
    
    
    
    @IBAction func skipTap(sender: AnyObject) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        //var counter : Int = 4 - index
        
        let pageViewController = self.parentViewController as! PageViewController
       // pageViewController.nextPageWithIndex(index+counter)
        pageViewController.nextPageWithIndex(1)
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func startTap(sender: AnyObject)
        
    {
       
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

