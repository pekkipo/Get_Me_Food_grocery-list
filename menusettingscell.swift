//
//  menusettingscell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 06/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class menusettingscell: UITableViewCell {

    
    
    @IBOutlet var container: UIView!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.7) // was 0.8
        )
    }
    
    @IBOutlet var shopimage: UIImageView!
    
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
       // if UIScreen.mainScreen().sizeType == .iPhone4 {
            if UIScreen.mainScreen().nativeBounds.height == 960 {   
            container.frame.size.height = 34
 
            shopimage.frame.size.width = 24
            shopimage.frame.size.height = 24
            

        }
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
