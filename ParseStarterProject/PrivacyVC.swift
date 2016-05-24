//
//  PrivacyVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 11/02/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {
    
    
    @IBOutlet var privacytext: UITextView!
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        
        
        privacytext.text = NSLocalizedString("privacy", comment: "")
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
