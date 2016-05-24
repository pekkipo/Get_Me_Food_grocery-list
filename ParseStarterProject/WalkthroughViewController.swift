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
    /*
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    */
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var header: UILabel!
    
    
    @IBOutlet var desclabel: UILabel!
    
    
    
    @IBOutlet var getstarted: UIButton!
    
    
    @IBOutlet var nextbutton: UIButton!
 
    
    @IBOutlet var skipbutton: UIButton!
    
    
    @IBOutlet var pageControl: UIPageControl!
    
    
    //login view
    
    
    @IBOutlet var loginview: UIView!
    
    @IBOutlet var signuplogin: UIButton!
    
    @IBOutlet var effectview: UIVisualEffectView!
    
    
    @IBOutlet var yesnoview: UIView!
    
    
    @IBAction func yestake(sender: AnyObject) {
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")

        
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index)
        
    }
    
    
    @IBAction func nothanks(sender: AnyObject) {
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")

        
        
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index+4)
        
    }
    
    @IBOutlet var yesoutlet: UIButton!
    
    
    @IBOutlet var nooutlet: UIButton!
    
    var index = 0
    var headertext = ""
    var imageName = ""
    var descriptiontext = ""
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .Default
    }
    
    @IBOutlet var constr1: NSLayoutConstraint!
    
    
    @IBOutlet var constr2: NSLayoutConstraint!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.text = headertext
        desclabel.text = descriptiontext
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        
        if UIScreen.mainScreen().nativeBounds.height == 960 {
            
            
            constr1.constant = 5
            constr2.constant = 5
        }

        
        // customize the next and start button
        getstarted.hidden = (index == 5) ? false : true
        
        nextbutton.hidden = (index == 5) ? true : false
        
        skipbutton.hidden = (index == 5) ? true : false
        
        
        
        loginview.hidden = (index == 5) ? false : true
        
        header.hidden = (index == 5) ? true : false
        
        effectview.hidden = (index == 0) ? true : false
        
        yesnoview.hidden = (index == 0) ? false : true
        
        getstarted.layer.cornerRadius = 5.0
        getstarted.layer.masksToBounds = true
        
        signuplogin.layer.cornerRadius = 5.0
        signuplogin.layer.masksToBounds = true
        
        yesoutlet.layer.cornerRadius = 5.0
        yesoutlet.layer.masksToBounds = true
        
        nooutlet.layer.cornerRadius = 5.0
        nooutlet.layer.masksToBounds = true
        
        
        if index == 0 {
        
        nextbutton.hidden = true
        skipbutton.hidden = true
        effectview.hidden = true
        }
        
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
        
        var counter : Int = 4 - index
        
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index+counter)
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func startTap(sender: AnyObject)
    {
       
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextTap(sender: AnyObject)
    {
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index)
    }
}

