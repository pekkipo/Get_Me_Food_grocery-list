//
//  ItemShopListCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 23/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ItemShopListCell: UITableViewCell {

    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemNote: UILabel!
    @IBOutlet var itemQuantity: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemUnit: UILabel!
    @IBOutlet weak var checkedButtonOutlet: UIButton!
  
    @IBAction func editButton(sender: AnyObject) {
    }
   
    @IBAction func checkButton(sender: AnyObject) {
    }
    @IBOutlet weak var editItemOutlet: UIButton!
    
    @IBOutlet var deleteItemOutlet: UIButton!
    @IBAction func deleteButton(sender: AnyObject) {
    }
    
    @IBOutlet var checkedheight: NSLayoutConstraint!
    
    @IBOutlet var checkedview: UIView!
    
    @IBOutlet var restorebutton: UIButton!
    
    //constraints
    
    @IBOutlet var copybuttonoutlet: UIButton!
 
    @IBOutlet var containerview: UIView!
    
    
    @IBOutlet var nametopconstraint: NSLayoutConstraint!
    
    
    @IBOutlet var checkedwidth: NSLayoutConstraint!

    @IBOutlet var amounttopconstraint: NSLayoutConstraint!
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.86) //0.6
        )
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
       // self.checkedheight.constant = 0
        

        self.layoutMargins = UIEdgeInsetsZero
        
        // copybuttonoutlet.hidden = true
        
        checkedview.backgroundColor = UIColorFromRGB(0xFFFFFF)
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero


        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
