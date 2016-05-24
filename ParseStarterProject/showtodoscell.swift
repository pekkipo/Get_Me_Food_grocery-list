//
//  showtodoscell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 04/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class showtodoscell: UITableViewCell {

    @IBOutlet var itemimage: UIImageView!
    
    @IBOutlet var itemname: UILabel!
    
    @IBOutlet var itemcount: UILabel!
    
    
    @IBOutlet var container: UIView!
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        itemname.font = UIFont(name: "Avenir-Black", size: 16)
        itemname.textColor = UIColor.whiteColor()
        
        itemcount.font = UIFont(name: "Avenir-Black", size: 13)
        itemcount.textColor = UIColor.whiteColor()
        
        container.backgroundColor = UIColorFromRGB(0xFF8000)
        container.layer.cornerRadius = 15
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
