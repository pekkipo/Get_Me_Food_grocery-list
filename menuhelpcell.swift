//
//  menuhelpcell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 06/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class menuhelpcell: UITableViewCell {

    
    @IBOutlet var shopimage: UIImageView!
    
    @IBOutlet var container: UIView!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.7) // was 0.8
        )
    }
    
    
    @IBOutlet var viewheight: NSLayoutConstraint!
    
    
    @IBOutlet var h1: NSLayoutConstraint!
    
    
    @IBOutlet var w1: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
      //  if UIScreen.mainScreen().sizeType == .iPhone4 {
           if UIScreen.mainScreen().nativeBounds.height == 960 {    
        
            container.frame.size.height = 34
            viewheight.constant = 34
            
            shopimage.frame.size.width = 22
            shopimage.frame.size.height = 22
            
            w1.constant = 22
            h1.constant = 22
        }
        
        container.backgroundColor = UIColorFromRGB(0x2A2F36)
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColorFromRGB(0xFAFAFA).CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
