//
//  TestTableCell.swift
//  ParseStarterProject
//
//   Created by PekkiPo (Aleksei Petukhov) on 20/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class TestTableCell: UITableViewCell {

    @IBOutlet weak var nameofsender: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
