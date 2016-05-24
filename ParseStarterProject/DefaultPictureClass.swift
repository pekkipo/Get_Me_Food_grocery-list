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

class DefaultPicture: NSObject {
    
    

    var itemimage:UIImage
    var imagename:String

    
    
    
    init(itemimage:UIImage,imagename:String) {
        
        self.itemimage = itemimage
        self.imagename = imagename

        
        
    }
    

    

    
}


