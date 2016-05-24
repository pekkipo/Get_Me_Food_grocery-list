//
//  FavItemCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 28/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FavItemCell: UITableViewCell {

    
    @IBOutlet weak var favproductimage: UIImageView!
    
    @IBOutlet weak var favproductname: UILabel!
    
    
    @IBOutlet weak var favitemadded: UILabel!
    
    @IBOutlet weak var addfavitem: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
