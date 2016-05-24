//
//  sendemail.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 14/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class sendemail: UITableViewCell {
    
    
    @IBOutlet var email: UITextField!
    
    
    @IBOutlet var sendbutton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
