//
//  Event.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 07/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Foundation
import Parse

class Event: NSObject {
    
    
    
    var eventtype:String
    var eventnote:String
    var eventdate:NSDate
    var eventuser:[AnyObject]
    var eventreceiver:[AnyObject]
    
    var eventid:String?
    
    var eventreceiverimage:UIImage?
    
    
    
    /*
    init(eventtype:String,eventnote:String,eventdate:NSDate,eventuser:[AnyObject]) {
        
        self.eventtype = eventtype
        self.eventnote = eventnote
        self.eventdate = eventdate
        self.eventuser = eventuser

        
    }
    */
    init(eventtype:String,eventnote:String,eventdate:NSDate,eventuser:[AnyObject],eventreceiver:[AnyObject]) {
        
        self.eventtype = eventtype
        self.eventnote = eventnote
        self.eventdate = eventdate
        self.eventuser = eventuser
        self.eventreceiver = eventreceiver
        
        
    }
    
    init(eventtype:String,eventnote:String,eventdate:NSDate,eventuser:[AnyObject],eventreceiver:[AnyObject], eventid:String) {
        
        self.eventtype = eventtype
        self.eventnote = eventnote
        self.eventdate = eventdate
        self.eventuser = eventuser
        self.eventreceiver = eventreceiver
        self.eventid = eventid
        
        
    }
    
    init(eventtype:String,eventnote:String,eventdate:NSDate,eventuser:[AnyObject],eventreceiver:[AnyObject], eventid:String,eventreceiverimage:UIImage) {
        
        self.eventtype = eventtype
        self.eventnote = eventnote
        self.eventdate = eventdate
        self.eventuser = eventuser
        self.eventreceiver = eventreceiver
        self.eventid = eventid
        self.eventreceiverimage = eventreceiverimage
        
        
    }


    
    
    
    
    
}