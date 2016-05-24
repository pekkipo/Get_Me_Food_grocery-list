//
//  QuantityStepper.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 11/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class QuantityStepper: UIView {

    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        leftButton.setTitle("-", forState: .Normal)
        leftButton.backgroundColor = UIColor.blueColor()
        addSubview(leftButton)
        
        rightButton.setTitle("+", forState: .Normal)
        rightButton.backgroundColor = UIColor.blueColor()
        addSubview(rightButton)
        
        label.text = "0"
        label.textAlignment = .Center
        label.backgroundColor = UIColor.redColor()
        addSubview(label)
        
    }
    
    override func layoutSubviews() {
        let labelWidthWeight: CGFloat = 0.5
        
        let buttonWidth = bounds.size.width * ((1 - labelWidthWeight) / 2)
        let labelWidth = bounds.size.width * labelWidthWeight
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
    }
   
}
