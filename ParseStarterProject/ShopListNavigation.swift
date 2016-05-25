//
//  ShopListNavigation.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 21/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ShopListNavigation: UINavigationController {

    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      UINavigationBar.appearance().barTintColor = UIColorFromRGB(0xEEEEEE)//UIColorFromRGB(0x020811)//(0x2A2F36) //after clculationg adjustments must me : 020811
        
      UINavigationBar.appearance().tintColor = UIColorFromRGB(0x0B6065) // FAFAFA = F9F9F9 during the rendering
        
       UIBarButtonItem.appearance().tintColor = UIColorFromRGB(0x0B6065)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColorFromRGB(0x0B6065),NSFontAttributeName:UIFont(name: "AvenirNext-UltraLight", size: 14)!]

        
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
