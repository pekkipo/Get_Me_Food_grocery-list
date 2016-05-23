//
//  receptioninfocell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 23/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class receptioninfocell: UITableViewCell {

    
    @IBOutlet weak var listsquantity: UILabel!
    
    @IBOutlet weak var havereceived: UILabel!
    
    
    @IBOutlet weak var newlists: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
