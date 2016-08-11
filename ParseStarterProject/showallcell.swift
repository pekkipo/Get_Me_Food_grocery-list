//
//  showallcell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 04/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class showallcell: UITableViewCell {
    
    
    @IBOutlet var itemimage: UIImageView!
    
    @IBOutlet var itemname: UILabel!
    

    
    @IBOutlet var receivedcontainer: UIView!
    
    @IBOutlet var receiveditemcount: UILabel!
    
    @IBOutlet var borderofcell: UIView!
    
    @IBOutlet var cellcontainer: UIView!
    
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
        
      //  if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
        // if UIScreen.mainScreen().sizeType == .iPhone4 {
         if UIScreen.mainScreen().nativeBounds.height == 960 {
        
            cellcontainer.frame.size.height = 34
            
            shopimage.frame.size.width = 17
            shopimage.frame.size.height = 20

        }
        

        

        
       // receivedcontainer.backgroundColor = UIColorFromRGB(0x31797D)
        receivedcontainer.layer.cornerRadius = receivedcontainer.layer.frame.width / 2
        
        //receiveditemcount.font = UIFont(name: "Helvetica-Neue", size: 8)
        receiveditemcount.textColor = UIColorFromRGB(0xFAFAFA)//UIColor.whiteColor()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
