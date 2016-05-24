//
//  EventCell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 07/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    
    
    //@IBOutlet var userimage: UIImageView!
    
    @IBOutlet var receiverimage: UIImageView!
    
    @IBOutlet var nameandevent: UILabel!
    
    @IBOutlet var receiveremail: UILabel!
    
   
    @IBOutlet var eventnote: UITextView!
    
    @IBOutlet var eventtext: UILabel!
    
    @IBOutlet var eventdate: UILabel!
    
    @IBOutlet var eventhours: UILabel!
    
    @IBOutlet var blockuseroutlet: UIButton!
    
    @IBOutlet var container: UIView!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // container.layer.borderWidth = 1
       // container.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        container.layer.cornerRadius = 8

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
