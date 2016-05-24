//
//  NewOptCell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 16/03/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class NewOptCell: UITableViewCell {
    
    
    @IBOutlet var prodpicture: UIImageView!
    
    @IBOutlet var prodname: UILabel!
    
    
    
    @IBOutlet var plusimage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
