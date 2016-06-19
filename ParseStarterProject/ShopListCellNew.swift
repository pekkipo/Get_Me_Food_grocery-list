//
//  ShopListCellNew.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 04/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ShopListCellNew: UITableViewCell {
    
    
    @IBOutlet var ListTypeImage: UIImageView!
    
   
    
    //@IBOutlet var addToFavOutlet: UIButton!
    
    @IBOutlet var addToFavOutlet: UIImageView!
    
    
    @IBOutlet var ShopListNameButton: UILabel!
    
    
   

    
    
    @IBOutlet var creationDate: UILabel!
    
    @IBOutlet var ShareButtonOutlet: UIButton!
    
    @IBOutlet var itemscount: UILabel!
    

    @IBOutlet var container: UIView!
    

    
    @IBOutlet var percents: UILabel!
   
    @IBOutlet var colorcodeviewoutlet: UIView!
    
    
    @IBOutlet var progresscircle: KDCircularProgress!
    
    @IBOutlet var storyline: UIView!
    
    
    @IBOutlet var newlisttype: UIImageView!
    
    
    
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
       // container.layer.borderWidth = 1
       // container.layer.borderColor = UIColorFromRGB(0xCFCFCF).CGColor
        //self.layoutMargins = UIEdgeInsetsZero
        
       /* let path = UIBezierPath()
       
        
        let dashes: [CGFloat] = [3,3]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        
        path.stroke()
*/
        
        //container.addDashedBorder()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
