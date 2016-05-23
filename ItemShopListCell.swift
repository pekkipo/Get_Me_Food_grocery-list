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
    
    
    @IBOutlet var checkedview: UIView!
    
    @IBOutlet var restorebutton: UIButton!
    
    //constraints
    
    @IBOutlet var copybuttonoutlet: UIButton!
 
    @IBOutlet var containerview: UIView!
    
    
    @IBOutlet var nametopconstraint: NSLayoutConstraint!
    
    

    @IBOutlet var amounttopconstraint: NSLayoutConstraint!
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.6) //0.6
        )
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ///add new view, blur it and add restore button
        
       // self.heightconstraint.constant = self.frame.size.height
       // self.widthconstraint.constant = self.frame.size.width
        
        self.layoutMargins = UIEdgeInsetsZero
        
        copybuttonoutlet.hidden = true
        
        checkedview.backgroundColor = UIColorFromRGB(0x2A2F36)//[[UIColor blackColor] colorWithAlphaComponent:.6];
        
       // itemImage.layer.borderColor = UIColorFromRGB(0x898989).CGColor
       // itemImage.layer.borderWidth = 1.0
      
        //var positionx = checkedview.frame.size.width * 0.7 - 10
        //var positiony = (checkedview.frame.size.height * 0.5) - 20
       // restorebutton.frame = CGRectMake(positionx,positiony, 100, 40)
        //CGRect(x: 0, y: yPos, width: buttonWidth-0.5, height: self.buttonHeight)
        
        //restorebutton.backgroundColor = UIColor.whiteColor()
       // restorebutton.layer.borderColor = UIColor.blueColor().CGColor
        //restorebutton.layer.cornerRadius = 10
        //restorebutton.setTitle("Restore", forState: UIControlState.Normal)
        
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero


        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
