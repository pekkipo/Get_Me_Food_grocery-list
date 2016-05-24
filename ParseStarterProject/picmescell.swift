//
//  picmescell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 18/03/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class picmescell: UITableViewCell {

    @IBOutlet var label: UILabel!
    
    @IBOutlet var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
