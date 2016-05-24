//
//  EditFavItemsCell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 19/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class EditFavItemsCell: UITableViewCell {
    
    
    
    @IBOutlet var favitemimage: UIImageView!
    
    
    @IBOutlet var favitemname: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
