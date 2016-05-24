//
//  SharingHistoryCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 22/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class SharingHistoryCell: UITableViewCell {

    
    @IBOutlet weak var listname: UILabel!
    
    @IBOutlet weak var listdate: UILabel!
    
    @IBOutlet weak var receivername: UILabel!
    
    @IBOutlet weak var receiveremail: UILabel!
    
    @IBOutlet weak var issavedlabel: UILabel!
    
    @IBOutlet weak var checkifreceived: UIButton!
    
    @IBOutlet var iconimage: UIImageView!
    
    @IBOutlet var listtype: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
