//
//  CatalogItem.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 19/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation
import Parse

class CatalogItem: NSObject {//, Equatable, Hashable {


    var itemId:String
    var itemname:String
    var itemimage:UIImage
    var itemcategory:Category
    //var itemcategory:String
    
    var itemischecked:Bool? //only for catalog purposes
    var itemaddedid:String? //only for catalog purposes
    
    var imagePath = String()
    
    var userscategories = [String]()
    
    
    
    init(itemId:String,itemname:String,itemimage:UIImage,itemcategory:Category) {
        
        self.itemId = itemId
        self.itemname = itemname
        self.itemimage = itemimage
        self.itemcategory = itemcategory


        
    }
    
    init(itemId:String,itemname:String,itemimage:UIImage,itemcategory:Category, itemischecked:Bool) {
        
        self.itemId = itemId
        self.itemname = itemname
        self.itemimage = itemimage
        self.itemcategory = itemcategory
        self.itemischecked = itemischecked
        
        
    }
    
    init(itemId:String,itemname:String,itemimage:UIImage,itemcategory:Category, itemischecked:Bool, itemaddedid:String) {
        
        self.itemId = itemId
        self.itemname = itemname
        self.itemimage = itemimage
        self.itemcategory = itemcategory
        self.itemischecked = itemischecked
        self.itemaddedid = itemaddedid
        
        
    }


    
    override var hash: Int {
        return self.hashValue
    }

}



func == (lhs: CatalogItem, rhs: CatalogItem) -> Bool {
    return (lhs.itemId == rhs.itemId)
}