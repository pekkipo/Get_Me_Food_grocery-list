//
//  LanguageCell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 11/01/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    
    
    
    @IBOutlet var flag: UIImageView!
    
    
    @IBOutlet var langname: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
