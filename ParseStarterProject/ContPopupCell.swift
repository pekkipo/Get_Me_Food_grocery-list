//
//  ContPopupCell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 07/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class ContPopupCell: UITableViewCell {

    
    @IBOutlet var contimage: UIImageView!
    
    @IBOutlet var contlabel: UILabel! //name
    
    @IBOutlet var contemail: UILabel!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        contimage.layer.cornerRadius = contimage.frame.size.width / 2
        contimage.layer.masksToBounds = true
        contimage.layer.borderWidth = 1
        contimage.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
