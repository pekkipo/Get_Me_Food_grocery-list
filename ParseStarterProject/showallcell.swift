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
    
    @IBOutlet var itemcount: UILabel!
    
    
    @IBOutlet var container: UIView!
    
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

    
    @IBOutlet var viewheight: NSLayoutConstraint!
    
    @IBOutlet var w1: NSLayoutConstraint!
    
    @IBOutlet var h1: NSLayoutConstraint!
    
    
    @IBOutlet var shopimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      //  if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
        // if UIScreen.mainScreen().sizeType == .iPhone4 {
         if UIScreen.mainScreen().nativeBounds.height == 960 {
        
            cellcontainer.frame.size.height = 34
            viewheight.constant = 34
            
            shopimage.frame.size.width = 17
            shopimage.frame.size.height = 20
            
            w1.constant = 17
            h1.constant = 20
        }
        
        cellcontainer.backgroundColor = UIColorFromRGB(0x2A2F36)
        cellcontainer.layer.borderWidth = 1
        cellcontainer.layer.borderColor = UIColorFromRGB(0xFAFAFA).CGColor
        
        //itemname.font = UIFont(name: "Avenir-Black", size: 16)
       // itemname.textColor = UIColor.whiteColor()
        
        itemcount.font = UIFont(name: "Helvetica-Neue", size: 14)
        itemcount.textColor = UIColorFromRGB(0xE0FFB2)//UIColor.whiteColor()
        
        container.backgroundColor = UIColorFromRGB(0x61C791)
        container.layer.cornerRadius = 8
        
        receivedcontainer.backgroundColor = UIColorFromRGB(0xF23D55)
        receivedcontainer.layer.cornerRadius = 8
        
        receiveditemcount.font = UIFont(name: "Helvetica-Neue", size: 8)
        receiveditemcount.textColor = UIColorFromRGB(0xFAFAFA)//UIColor.whiteColor()
        
        
        
        //let myframe = CGRectMake(0, 45, self.frame.width, 2)
       // borderofcell.frame.height = 2
        //borderofcell.frame = myframe
       // borderofcell.backgroundColor = UIColor(patternImage: UIImage(named: "MenuLine")!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
