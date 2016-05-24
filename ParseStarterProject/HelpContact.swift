//
//  HelpContact.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 15/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class HelpContact: UIViewController {
    
    
    
    @IBOutlet var helptext: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        helptext.text = NSLocalizedString("helpcontact", comment: "")
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
