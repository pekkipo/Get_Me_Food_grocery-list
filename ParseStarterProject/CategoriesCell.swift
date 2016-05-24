//
//  CategoriesCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 10/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var catalogCatImage: UIImageView!
    
    @IBOutlet weak var catalogCatName: UILabel!
    
    
    @IBOutlet var catalogcustom: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
