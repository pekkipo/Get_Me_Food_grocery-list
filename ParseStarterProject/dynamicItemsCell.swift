//
//  dynamicItemsCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 28/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class dynamicItemsCell: UITableViewCell {

    @IBOutlet var itemimage: UIImageView!
    
    @IBOutlet var itemname: UILabel!
    
    
    @IBOutlet var deleteitem: UIButton!
    
    @IBOutlet var edititem: UIButton!
    
    @IBOutlet weak var itemnamebutton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
