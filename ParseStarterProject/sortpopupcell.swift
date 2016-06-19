//
//  sortpopupcell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 06/04/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView

class sortpopupcell: UITableViewCell {
    
    @IBOutlet var actindicator: NVActivityIndicatorView!
    
    @IBOutlet var caption: UILabel!

    @IBOutlet var checkmark: UIImageView!
    
    
    @IBOutlet var errormark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
