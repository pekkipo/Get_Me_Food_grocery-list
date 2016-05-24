//
//  CustomItemsCell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 17/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class CustomItemsCell: UITableViewCell {
    
    
    @IBOutlet var itemimage: UIImageView!
    
   
    @IBOutlet var itemname: UITextField!
    
    
   
    
    @IBOutlet var itemdelete: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
