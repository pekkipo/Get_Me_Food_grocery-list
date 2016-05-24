//
//  ShopListCell.swift
//  ParseStarterProject
//
//  Created by Created by PekkiPo (Aleksei Petukhov) on 01/08/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ShopListCell: UITableViewCell {
    
   // var tapped: ((ShopListCell) -> Void)?
    
    // MARK: Properties

    @IBOutlet weak var ShopListNameButton: UIButton!
    
    @IBOutlet var ShopListName: UILabel!
    
    @IBOutlet var ShopListNote: UILabel!
    
    @IBOutlet var DeleteOutlet: UIButton!
    
    @IBOutlet var ShareButtonOutlet: UIButton!
    
    @IBOutlet var addToFavOutlet: UIButton!
    
    @IBOutlet var creationDate: UILabel!
    
    @IBOutlet weak var itemscount: UILabel!
    
    @IBOutlet weak var checkeditemscount: UILabel!
    
    
    @IBAction func ShareAction(sender: AnyObject) {
    }
    
    @IBAction func DeleteAction(sender: AnyObject) {
        //tapped?(self)
        
       // let button = sender as! UIButton
       
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
