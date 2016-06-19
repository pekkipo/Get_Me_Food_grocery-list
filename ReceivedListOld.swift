//
//  ReceivedListOld.swift
//  ParseStarterProject
//
//  Created by Created by PekkiPo (Aleksei Petukhov) on 20/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ReceivedListOld: UITableViewCell {

   

    
    @IBOutlet var receivedlistdate: UILabel!
    

    
    @IBOutlet var sendername: UILabel!
    
    
    @IBOutlet var acceptlist: UIButton!
   // @IBOutlet var sharereceivedlist: UIButton! //Means SAVE, don't want to reassign button
    


    
    @IBOutlet var addtofavs: UIImageView!
   
    
    @IBOutlet var receivedlistnamebutton: UILabel!

    
    @IBOutlet var container: UIView!
    
    
    @IBOutlet weak var itemscount: UILabel!
    
    
    @IBOutlet var colorcodeviewoutlet: UIView!
    
    
    @IBOutlet var newlisttype: UIImageView!
    
    @IBOutlet var storyline: UIView!
    
    
    @IBOutlet var progresscircle: KDCircularProgress!

    @IBOutlet var percents: UILabel!
    
    @IBOutlet var acceptlabel: UILabel!
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //container.layer.borderWidth = 1
        //container.layer.borderColor = UIColorFromRGB(0xCFCFCF).CGColor
        //rowHeight = 44.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
