//
//  AboutVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 11/02/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet var back: UIBarButtonItem!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func backaction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBOutlet var imageh1: NSLayoutConstraint! //32
    
    @IBOutlet var texth1: NSLayoutConstraint! //37
    
    @IBOutlet var texth2: NSLayoutConstraint! //27
    
    @IBOutlet var texth3: NSLayoutConstraint! //8
    
    @IBOutlet var texth4: NSLayoutConstraint! //8
    
    
    
    @IBOutlet var menuitem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        menuitem.target = self.revealViewController()
        menuitem.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        */
      //  if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
     
      //  if UIScreen.mainScreen().sizeType == .iPhone4 {
        
           if UIScreen.mainScreen().nativeBounds.height == 960 {
        
            imageh1.constant = 10
            texth1.constant = 15
            
            texth2.constant = 10
            texth3.constant = 4
            texth4.constant = 4
        }
        
        // Do any additional setup after loading the view.
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
