//
//  RecentListsCell.swift
//  ParseStarterProject
//
//  Created by Created by PekkiPo (Aleksei Petukhov) on 08/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class RecentListsCell: UITableViewCell {

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var recentListName: UILabel!
    @IBAction func addtofav(sender: AnyObject) {
    }
    @IBOutlet weak var creationdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
