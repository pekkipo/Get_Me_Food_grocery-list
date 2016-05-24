//
//  ReceivedListCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 18/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ReceivedListCell: UITableViewCell {

    
    @IBOutlet weak var receivedListName: UILabel!
    
    @IBOutlet weak var receivedListNote: UILabel!
    
    
    @IBOutlet weak var receivedListDate: UILabel!
    
    @IBOutlet weak var receivedFrom: UILabel!
    
    @IBOutlet weak var deleteReceivedList: UIButton!
    
    
    @IBOutlet weak var addReceivedToFav: UIButton!
    
    @IBOutlet weak var shareReceivedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
