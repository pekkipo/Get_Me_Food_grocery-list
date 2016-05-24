//
//  ContactsCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 15/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    
    @IBOutlet weak var contactnameoutlet: UILabel!
    
    @IBOutlet weak var contactemailoutlet: UILabel!
    
    
    
    @IBOutlet weak var contactavatar: UIImageView!
    
    
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
        contactavatar.layer.cornerRadius = contactavatar.frame.size.width / 2
        contactavatar.layer.masksToBounds = true
       // contactavatar.layer.borderWidth = 2
       // contactavatar.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
