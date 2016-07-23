//
//  choosedatescell.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 09/07/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class choosedatescell: UITableViewCell {

    
    
    @IBOutlet var fromdate: UITextField!
    
    @IBOutlet var fromdateline: UIView!
    
    
    @IBOutlet var duedate: UITextField!
    
    @IBOutlet var duedateline: UIView!
    
    @IBOutlet var frombutton: UIButton!
    
    @IBOutlet var duebutton: UIButton!
    
    @IBOutlet var datepicker: UIDatePicker!
    
    @IBOutlet var donebutton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
