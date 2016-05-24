//
//  LoginInfoCell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 03/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class LoginInfoCell: UITableViewCell {
    
    
    @IBOutlet var userimage: UIImageView!
    
    @IBOutlet var username: UILabel!
    
    
    @IBOutlet var useremail: UILabel!
    
    @IBOutlet var logincellview: UIView!
    
    
    @IBOutlet var loginimage: UIButton!
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }

    @IBOutlet var logininnerview: UIView!
    
    @IBOutlet var viewheight: NSLayoutConstraint!
    
    @IBOutlet var innerheight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
       // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
       // if UIScreen.mainScreen().sizeType == .iPhone4 {
        
        if UIScreen.mainScreen().nativeBounds.height == 960 {
        
         logincellview.frame.size.height = 60
            logininnerview.frame.size.height = 49
            
            viewheight.constant = 60
            innerheight.constant = 49
        }
        

       // avatarcontainer.layer.cornerRadius = 15
        
        userimage.layer.cornerRadius = userimage.frame.size.width / 2
        userimage.layer.masksToBounds = true
        //userimage.layer.borderWidth = 1.0
        //userimage.layer.borderColor = UIColor.whiteColor().CGColor
        /*
        let visuaEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        visuaEffectView.frame = logincellview.bounds
        visuaEffectView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        visuaEffectView.setTranslatesAutoresizingMaskIntoConstraints(true)
        logincellview.addSubview(visuaEffectView)
        logincellview.sendSubviewToBack(visuaEffectView)
        */
        logincellview.backgroundColor = UIColorFromRGBalpha(0x2A2F36, alp: 0.4)
       // self.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 0.1)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
