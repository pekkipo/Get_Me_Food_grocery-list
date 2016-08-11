//
//  menuhelpcell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 06/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

class menuhelpcell: UITableViewCell {

    
    @IBOutlet var shopimage: UIImageView!
    
    @IBOutlet var container: UIView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
      //  if UIScreen.mainScreen().sizeType == .iPhone4 {
           if UIScreen.mainScreen().nativeBounds.height == 960 {    
        
            container.frame.size.height = 34

            
            shopimage.frame.size.width = 22
            shopimage.frame.size.height = 22

        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
