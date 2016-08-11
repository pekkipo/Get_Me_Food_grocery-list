//
//  menueventscell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 06/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class menueventscell: UITableViewCell {

    @IBOutlet var redview: UIView!
    
    @IBOutlet var eventscountlabel: UILabel!
    
    
    @IBOutlet var container: UIView!
    


    
    @IBOutlet var shopimage: UIImageView!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        redview.layer.cornerRadius = redview.layer.frame.width / 2
        

        
           if UIScreen.mainScreen().nativeBounds.height == 960 {
        
            container.frame.size.height = 34

            
            shopimage.frame.size.width = 22
            shopimage.frame.size.height = 20

        }
        

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
