//
//  ToDoListCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 31/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ToDoListCell: UITableViewCell {
    
    
    
    @IBOutlet weak var importantimage: UIImageView!
    
    
    @IBOutlet weak var itemname: UILabel!
    
    
    @IBOutlet weak var itemnote: UILabel!
    
    
    @IBOutlet weak var edititemoutlet: UIButton!
    
    @IBOutlet weak var checkitem: UIButton!
    
    
    @IBOutlet var checkview: UIView!
    
    
    @IBOutlet var restoreitem: UIButton!
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.6)
        )
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        //CGRect(x: 0, y: yPos, width: buttonWidth-0.5, height: self.buttonHeight)
        
      checkview.backgroundColor = UIColorFromRGB(0x2A2F36)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
