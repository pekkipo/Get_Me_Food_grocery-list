//
//  settingscell.swift
//  ParseStarterProject
//
//  Created by PekkiPo (Aleksei Petukhov) on 02/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation

class settingscell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var settingimage: UIImageView!
    
    
    @IBOutlet weak var settingsname: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBOutlet weak var countContainer: UIView!

    override func awakeFromNib() {
        
        settingsname.font = UIFont(name: "Avenir-Black", size: 16)
        settingsname.textColor = UIColor.whiteColor()
        
        countLabel.font = UIFont(name: "Avenir-Black", size: 13)
        countLabel.textColor = UIColor.whiteColor()
        
        countContainer.backgroundColor = UIColor(red: 0.33, green: 0.62, blue: 0.94, alpha: 1.0)
        countContainer.layer.cornerRadius = 15
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        let countNotAvailable = countLabel.text == nil
        
        countContainer.hidden = countNotAvailable
        countLabel.hidden = countNotAvailable
        
    }
}
