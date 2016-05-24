//
//  DeleteBar.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 26/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class DeleteBar: UIBarButtonItem {
   
    //deleteAction.backgroundColor = UIColorFromRGB(0x1695A3)
    
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
    
    var appearance = UIBarButtonItem.appearance()
    
    
    var redcolor = UIColorFromRGB(0xF23D55)
    
    
    //navigationBarAppearace.tintColor = UIColor(CGColor: newColor)
    }
    
}
