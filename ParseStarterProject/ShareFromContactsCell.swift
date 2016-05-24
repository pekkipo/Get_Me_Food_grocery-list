//
//  ShareFromContactsCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 25/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ShareFromContactsCell: UITableViewCell {

    @IBOutlet weak var contactsimageintable: UIImageView!
    
    
    @IBOutlet weak var contactsnameintable: UILabel!
    
    @IBOutlet weak var contactsemailintable: UILabel!
    
    @IBOutlet weak var contactsavatarintable: UIImageView!
    
    @IBOutlet weak var shareintable: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
