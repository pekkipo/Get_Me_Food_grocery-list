//
//  NewShareContactCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 10/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class NewShareContactCell: UITableViewCell {

    
    
    
    @IBOutlet var contactimage: UIImageView!
    
    
    @IBOutlet var contactname: UILabel!
    
    
    @IBOutlet var contactemail: UILabel!
    
    
    @IBOutlet var sharebutton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contactimage.layer.cornerRadius = contactimage.frame.size.width / 2
        contactimage.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
