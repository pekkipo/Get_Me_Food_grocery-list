//
//  List.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 04/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class UserList: NSObject {//, Equatable, Hashable, NSCopying {//, Comparable {
    
    var listid:String!
    var listname:String!
    var listnote:String!
    var listcreationdate:NSDate!
    var listisfavourite:Bool!
    var listisreceived:Bool!
    var listbelongsto:String!
    var listreceivedfrom:[String]!
    var listissaved:Bool!
    var listconfirmreception:Bool!
    var listisdeleted:Bool!
    var listisshared:Bool!
    var listsharedwith:[[AnyObject]]!
    var listitemscount:Int!
    var listcheckeditemscount:Int!
    var listtype:String!
   
    //for shop
    //var listcurrency:String?
    var listcurrency:AnyObject?
    var listcategories:Bool?
    
    //optional
    var listcolorcode:String!
    
    
    
    init(
        listid:String,
        listname:String,
        listnote:String,
        listcreationdate:NSDate,
        listisfavourite:Bool,
        listisreceived:Bool,
        listbelongsto:String,
        listreceivedfrom:[String],
        listissaved:Bool,
        listconfirmreception:Bool,
        listisdeleted:Bool,
        listisshared:Bool,
        listsharedwith:[[AnyObject]],
        listitemscount:Int,
        listcheckeditemscount:Int,
        listtype:String,
        listcolorcode:String
        ) {
        
            self.listid = listid
            self.listname = listname
            self.listnote = listnote
            self.listcreationdate = listcreationdate
            self.listisfavourite = listisfavourite
            self.listisreceived = listisreceived
            self.listbelongsto = listbelongsto
            self.listreceivedfrom = listreceivedfrom
            self.listissaved = listissaved
            self.listconfirmreception = listconfirmreception
            self.listisdeleted = listisdeleted
            self.listisshared = listisshared
            self.listsharedwith = listsharedwith
            self.listitemscount = listitemscount
            self.listcheckeditemscount = listcheckeditemscount
            self.listtype = listtype
            self.listcolorcode = listcolorcode

    }
    
    init( // INIT FOR SHOP
        listid:String,
        listname:String,
        listnote:String,
        listcreationdate:NSDate,
        listisfavourite:Bool,
        listisreceived:Bool,
        listbelongsto:String,
        listreceivedfrom:[String],
        listissaved:Bool,
        listconfirmreception:Bool,
        listisdeleted:Bool,
        listisshared:Bool,
        listsharedwith:[[AnyObject]],
        listitemscount:Int,
        listcheckeditemscount:Int,
        listtype:String,
        listcurrency:AnyObject,//String,
        listcategories:Bool,
        listcolorcode:String
        ) {
            
            self.listid = listid
            self.listname = listname
            self.listnote = listnote
            self.listcreationdate = listcreationdate
            self.listisfavourite = listisfavourite
            self.listisreceived = listisreceived
            self.listbelongsto = listbelongsto
            self.listreceivedfrom = listreceivedfrom
            self.listissaved = listissaved
            self.listconfirmreception = listconfirmreception
            self.listisdeleted = listisdeleted
            self.listisshared = listisshared
            self.listsharedwith = listsharedwith
            self.listitemscount = listitemscount
            self.listcheckeditemscount = listcheckeditemscount
            self.listtype = listtype
            self.listcurrency = listcurrency
            self.listcategories = listcategories
            self.listcolorcode = listcolorcode

            
    }
    

    
 
    

    
    override var hash: Int {
        return self.hashValue
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return UserList(listid:self.listid,listname:self.listname,listnote:self.listnote,listcreationdate:self.listcreationdate,listisfavourite:self.listisfavourite,listisreceived:self.listisreceived,listbelongsto:self.listbelongsto,listreceivedfrom:self.listreceivedfrom,listissaved:self.listissaved,listconfirmreception:self.listconfirmreception,listisdeleted:self.listisdeleted,listisshared:self.listisshared,listsharedwith:self.listsharedwith,listitemscount:self.listitemscount,listcheckeditemscount:self.listcheckeditemscount,listtype:self.listtype,listcurrency:self.listcurrency!,listcategories:self.listcategories!,listcolorcode:self.listcolorcode)

    }
    
    
}
// MUST BE OUTSIDE OF EVERYTHING
func == (lhs: UserList, rhs: UserList) -> Bool {
    return (lhs.listid == rhs.listid)
}
/*
func > (lhs: UserList, rhs: UserList) -> Bool {
    return (lhs.listcreationdate > rhs.listcreationdate)
}
*/
//func <=(lhs: Self, rhs: Self) -> Bool

//func >=(lhs: Self, rhs: Self) -> Bool