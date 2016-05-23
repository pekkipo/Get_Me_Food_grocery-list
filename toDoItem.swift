//
//  toDoListClass.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 31/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//


import Foundation
import UIKit
import Parse

class toDoItem: NSObject {//, Equatable, Hashable, NSCopying {
    
    var itemid:String
    var itemname:String
    var itemnote:String
    var itemimportant:Bool
    var ischecked:Bool
    
    
    init(itemid:String,itemname:String,itemnote:String,itemimportant:Bool,ischecked:Bool) {
        
        self.itemid = itemid
        self.itemname = itemname
        self.itemnote = itemnote
        self.itemimportant = itemimportant
        self.ischecked = ischecked
        
        
        /* self.catId = "DefaultOthers"
        self.catname = Others
        self.catimage = catimage
        self.isCustom = isCustom
        */
        
    }
    
    override var hash: Int {
        return self.hashValue
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return toDoItem(itemid:self.itemid,itemname:self.itemname,itemnote:self.itemnote,itemimportant:self.itemimportant,ischecked:self.ischecked)
    }
    
    
}
// MUST BE OUTSIDE OF EVERYTHING
func == (lhs: toDoItem, rhs: toDoItem) -> Bool {
    return (lhs.itemid == rhs.itemid)
}