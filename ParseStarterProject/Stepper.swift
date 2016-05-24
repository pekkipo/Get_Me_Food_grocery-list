//
//  Stepper.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 11/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Stepper: UIStepper {

    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    
    var labelOriginalCenter: CGPoint!
    
    
    
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
        
        var value = 0 {
            didSet {
                label.text = String(value)
            }
        }
        
        leftButton.addTarget(self, action: "leftButtonTouchDown:", forControlEvents: .TouchDown)
        leftButton.addTarget(self, action: "buttonTouchUp:", forControlEvents: .TouchUpInside)
        leftButton.addTarget(self, action: "buttonTouchUp:", forControlEvents: .TouchUpOutside)
        
        backgroundColor = UIColor.blueColor()
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panRecognizer.maximumNumberOfTouches = 1
        label.userInteractionEnabled = true
        label.addGestureRecognizer(panRecognizer)
        
    }
    
    
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Changed:
            var translation = gesture.translationInView(label)
            
            let minimumLabelX = labelOriginalCenter.x - labelSlideLength
            let maximumLabelX = labelOriginalCenter.x + labelSlideLength
            label.center.x = max(minimumLabelX, min(maximumLabelX, label.center.x + translation.x))
            
            if label.center.x == minimumLabelX {
                value -= 1
            } else if label.center.x == maximumLabelX {
                value += 1
            }
            
            gesture.setTranslation(CGPointZero, inView: label)
        case .Ended:
            slideLabelToOriginalPosition()
        default:
            break
            
            
        }
        
        
    }
    
    override func layoutSubviews() {
        let labelWidthWeight: CGFloat = 0.5
        
        let buttonWidth = bounds.size.width * ((1 - labelWidthWeight) / 2)
        let labelWidth = bounds.size.width * labelWidthWeight
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
        
        labelOriginalCenter = label.center
    }
    
  
    // MARK: Button Event Actions
    func leftButtonTouchDown(button: UIButton) {
        value -= 1
        slideLabelLeft()
    }
    
    func rightButtonTouchDown(button: UIButton) {
        value += 1
        slideLabelRight()
    }
    
    func buttonTouchUp(button: UIButton) {
        slideLabelToOriginalPosition()
    }
    
    // MARK: Animations
    let labelSlideLength: CGFloat = 5
    let labelSlideDuration = NSTimeInterval(0.1)
    
    func slideLabelLeft() {
        slideLabel(-labelSlideLength)
    }
    
    func slideLabelRight() {
        slideLabel(labelSlideLength)
    }
    
    func slideLabel(slideLength: CGFloat) {
        UIView.animateWithDuration(labelSlideDuration) {
            self.label.center.x += slideLength
        }
    }
    
    func slideLabelToOriginalPosition() {
        if label.center != labelOriginalCenter {
            UIView.animateWithDuration(labelSlideDuration) {
                self.label.center = self.labelOriginalCenter
            }
        }
    }
    
}
