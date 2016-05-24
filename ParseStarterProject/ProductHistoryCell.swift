//
//  ProductHistoryCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 17/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ProductHistoryCell: UITableViewCell {

    @IBOutlet weak var prodimage: UIImageView!
    
    @IBOutlet weak var prodname: UILabel!
    
    @IBOutlet weak var addedlabel: UILabel!
    
    @IBOutlet weak var plus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
