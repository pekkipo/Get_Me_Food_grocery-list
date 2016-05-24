//
//  CategoryCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 10/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var newcategoryname: UITextField!
    
    @IBOutlet weak var newcategoryimage: UIImageView!
    
    @IBOutlet weak var chooseimageoutlet: UIButton!
    
    @IBOutlet weak var addcategoryoutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
