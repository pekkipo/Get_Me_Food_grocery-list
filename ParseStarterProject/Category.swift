//
//  Category.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 11/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Category: NSObject {//, Equatable, Hashable {
    
    var catId:String
    var catname:String
    var catimage:UIImage
    var isCustom:Bool
    
    var imagePath = String()
    
    var userscategories = [String]()
    
    var isAllowed:Bool?
    
   
    
    init(catId:String,catname:String,catimage:UIImage,isCustom:Bool) {
        
        self.catId = catId
        self.catname = catname
        self.catimage = catimage
        self.isCustom = isCustom

        
       /* self.catId = "DefaultOthers"
        self.catname = Others
        self.catimage = catimage
        self.isCustom = isCustom
*/
        
    }
    //for custom allowed categories
    init(catId:String,catname:String,catimage:UIImage,isCustom:Bool, isAllowed:Bool) {
        
        self.catId = catId
        self.catname = catname
        self.catimage = catimage
        self.isCustom = isCustom
        self.isAllowed = isAllowed
        
        
        /* self.catId = "DefaultOthers"
        self.catname = Others
        self.catimage = catimage
        self.isCustom = isCustom
        */
        
    }
    
    override var hash: Int {
        return self.hashValue
    }
    
    /*
    func saveImageLocally(imageData:NSData!) -> String {
        var imageuuid = NSUUID().UUIDString
        //let time =  NSDate().timeIntervalSince1970
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        //.stringByAppendingPathComponent(subDirForImage) as String
        
        if !fileManager.fileExistsAtPath(dir) {
            var error: NSError?
            if !fileManager.createDirectoryAtPath(dir, withIntermediateDirectories: true, attributes: nil, error: &error) {
                print("Unable to create directory: \(error)")
                return ""
            }
        }
        
        let pathToSaveImage = dir.stringByAppendingPathComponent("category\(imageuuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "category\(imageuuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    */
    
    func getuserscategories(thisuser:String) -> [String] {
        
        let queryuser:PFQuery = PFUser.query()!
        queryuser.fromLocalDatastore()
        queryuser.whereKey("objectId", equalTo: thisuser)//PFUser.currentUser()!.objectId!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        queryuser.getFirstObjectInBackgroundWithBlock() {
            (user: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let user = user {
                self.userscategories = user["userCategories"] as! [String]
               // shopList.pinInBackground()
                //shopList.saveInBackground()
               // shopList.saveEventually()
            }
            
        }
        
        return self.userscategories
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func saveImageLocally(imageData:NSData!) -> String {
        var uuid = NSUUID().UUIDString
        //let time =  NSDate().timeIntervalSince1970
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //.stringByAppendingPathComponent(subDirForImage) as String
        
        if !fileManager.fileExistsAtPath(dir) {
            do{
                try NSFileManager.defaultManager().createDirectoryAtPath(dir, withIntermediateDirectories: false, attributes: [:])
            } catch {
                print("Error creating SwiftData image folder")
                imagePath = ""
                return imagePath//""
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    
    var imageToLoad = UIImage()
    
    /*
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let path = (dir as NSString).stringByAppendingPathComponent(imageName)
        
        if(!path.isEmpty){
            let image = UIImage(contentsOfFile: path)
            print(image);
            if(image != nil){
                //return image!;
                self.imageToLoad = image!
                return imageToLoad
            }
        }
        
        return imagestochoose[0].itemimage//UIImage(named: "activity.png")!
    }
    */
    
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //try for ios9.2
        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(imageName)
        
        // if(!path.isEmpty){
        if path != "" {
            
            let data = NSData(contentsOfURL:path)
            if (data != nil) {
                let image = UIImage(data:data!)
                //}
                print(image);
                if(image != nil){
                    //return image!;
                    self.imageToLoad = image!
                    // return imageToLoad
                } else {
                    self.imageToLoad = imagestochoose[0].itemimage
                }
                
            } else {
                self.imageToLoad = imagestochoose[0].itemimage
            }
            
        } else {
            self.imageToLoad = imagestochoose[0].itemimage
        }
        
        return imageToLoad
    }


    
    var scaledpicture = UIImage()
    
    func imageResize (imageObj:UIImage)-> UIImage{
        
        // Automatically use scale factor of main screen
        
        let avsize = CGSizeMake(100, 100)
        UIGraphicsBeginImageContextWithOptions(avsize, true, 1.0)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: avsize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        scaledpicture = scaledImage
        return scaledpicture
    }

    
    func addCategory(newcategory: Category, isdefaultpict: Bool, defaultpictname: String?) {
        
        //shopcategory = ["CatId":catId,"CatName":catname,"CatImage":catimage,"CatCustom":isCustom]
       // shopcategories.append(shopcategory)
        catalogcategories.append(newcategory)
        customcategories.append(newcategory)
        
        
        ///NOW Store this to Parse
        //dispatch_async(dispatch_get_main_queue(), {
            
        var customcategory = PFObject(className:"shopListsCategory")
        customcategory["categoryUUID"] = newcategory.catId
        customcategory["catname"] = newcategory.catname
        customcategory["isCustom"] = true
        customcategory["CatbelongsToUser"] = PFUser.currentUser()!.objectId!
        customcategory["isDeleted"] = false
        customcategory["ShouldShowInCatalog"] = true
            
        customcategory["defaultpicture"] = isdefaultpict
        customcategory["OriginalInDefaults"] = defaultpictname
        var date = NSDate()
        customcategory["CreationDate"] = date
        customcategory["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        //image part start
       // let imageData = UIImagePNGRepresentation(newcategory.catimage)
        //let imageFile = PFFile(name:"categoryImage.png", data:imageData)
        //customcategory["catimage"] = imageFile
        //image part end
        
        //newcategory.catimage.
        
        
       
            if isdefaultpict == true {
                
                customcategory["catimage"] = NSNull()
                customcategory["imagePath"] = ""
                
            } else {
                
              //  imageResize(newcategory.catimage)
             //   let imageData = UIImagePNGRepresentation(scaledpicture)
                
                let imageData = UIImagePNGRepresentation(newcategory.catimage)
               // let imageFile = PFFile(name:"categoryimage", data:imageData!)
                
                self.saveImageLocally(imageData)
                customcategory["catimage"] = NSNull()//imageFile
                customcategory["imagePath"] = self.imagePath
            }
        
        //saveImageLocally(newcategory.catimage)
        //self.saveImageLocally(imageData)
        
       // customcategory["imagePath"] = ""//self.imagePath
        
        customcategory.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                print("saved category")
                /*
                self.getuserscategories(PFUser.currentUser()!.objectId!)
                //Now save add category to array of the user's categories
                var query:PFQuery = PFUser.query()!
                query.fromLocalDatastore()
                query.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)//
                query.getFirstObjectInBackgroundWithBlock() {
                    (user: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        println(error)
                    } else if let user = user {
                        self.userscategories = user["userCategories"] as! [String]
                        // shopList.pinInBackground()
                        //shopList.saveInBackground()
                        // shopList.saveEventually()
                    }
                    
                }
                */
            } else {
                print("category wasn't saved")
            }
        })
      //  customcategory.saveInBackground()
    
    //}) // end of dispatch
    }

}
// MUST BE OUTSIDE OF EVERYTHING
func == (lhs: Category, rhs: Category) -> Bool {
    return (lhs.catId == rhs.catId)
}