//
//  HelpSharing.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 22/01/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class HelpSharing: UIViewController {
    

    @IBOutlet var text1: UITextView!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        text1.text = NSLocalizedString("helpsh1", comment: "TapInfo")
        
      

        
        
        
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
