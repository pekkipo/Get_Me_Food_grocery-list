//
//  Sendbyemailcell.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 14/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Sendbyemailcell: UITableViewCell, UITextFieldDelegate {
    
    
   
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.superview!.superview?.superview!.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        return
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  emailfield.delegate = self
       // emailfield.leftTextMargin = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
