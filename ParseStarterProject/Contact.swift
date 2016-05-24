//
//  Contact.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 07/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Contact: NSObject {
    
    
    var contactid:String
    var contactimage:UIImage
    var contactname:String //just displayname
    var contactemail:String //also a username
    
    
    
    
    init(contactid:String,contactimage:UIImage,contactname:String, contactemail:String) {
        
        self.contactid = contactid
        self.contactimage = contactimage
        self.contactname = contactname
        self.contactemail = contactemail
        
        
        
        
    }
    
    
    
    
    
}

