//
//  MenuViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 03/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let transitionManager = MenuTransitionManager()

    
    @IBOutlet weak var textPostIcon: UIImageView!
    
    
    @IBOutlet weak var textPostLabel: UILabel!
    
    @IBOutlet weak var quotePostIcon: UIImageView!
    
    
    @IBOutlet weak var quotePostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self.transitionManager

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
