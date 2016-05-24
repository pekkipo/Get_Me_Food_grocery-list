//
//  NewOptionsController.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 15/03/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit
import Foundation
import Parse

class NewOptionsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {
    
     var currentlist = String()
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: - Declare catalog
    
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    
    var newcatalogcategories = [Category]()
    
    var filteredcategories = [Category]()
    
     var shouldShowSearchResults = false
    
    var shoplistdelegate : RefreshListDelegate?
    
    // var currentcataloglist = String()
    
    var tappedcategory : Category?
    // var tappedcategory : String?
    var tappedcategoryindex = Int()
    
    func onlydefaults() { /// AND CUSTOMS ALLOWED TO BE SHOWN
        
        for category in catalogcategories {
            if (category.catId as NSString).containsString("Default")  || (category.isAllowed != nil && category.isAllowed == true) {
                
                newcatalogcategories.append(category)
                
            } else {
                print("This is custom category!")
            }
            
        }
        tableView.reloadData()
    }
    
    // end catalog
    
    
    // MARK: - declare favs
    
  //  var thiscurrentlist: String?
    
    var favwaschosen = [Bool]()
   // var favwaschosen = [false]
    
    var productsNames = [String]()
    
    var productsImages = [PFFile]()
    
    var productsCategories = [String]()
    
    var imageToLoad = UIImage()
    var imagesToLoad = [UIImage]()
    
    var imagePath = String()
    var imagePaths = [String]()
    
    var itemsiscatalog = [Bool]()
    var itemsoriginal = [String]()
    
    var productscategoriesnames = [String]()
    
    var itemsQuantity = [String]()
    var itemsPrices = [String]()
    var itemsNotes = [String]()
    var itemsTotalSums = [String]()
    var itemsUnits = [String]()
    var itemsisfav = [Bool]()
    var itemsPerUnit = [String]()
    
    var itemisdefaultpict = [Bool]()
    var itemoriginalindefaults = [String]()
    
    //for unchecking
   // var itemwasadded = [Bool]()
    var itemwasaddedid = [String]()
    
    
    
    var dictionary = Dictionary<String, AnyObject>()
    
    
    func getcategoriesnames(categoryIds: [String]) -> [String] {
        
        for categoryid in categoryIds {
            
            if (categoryid as NSString).containsString("custom") {
                //CASE IF CATEGORY IS CUSTOM
                print(categoryIds)
                
                //PIZDEC, BUT MUST WORK
                
                let querycat = PFQuery(className:"shopListsCategory")
                querycat.fromLocalDatastore()
                querycat.whereKey("categoryUUID", equalTo: categoryid)
                let categories = querycat.findObjects()
                if (categories != nil) {
                    for category in categories! {
                        if let thiscatname = category["catname"] as? String {
                            print("NAME IS \(thiscatname)")

                            self.productscategoriesnames.append(thiscatname)
                        }
                    }
                } else {
                    print("No custom cats yet")
                }
                
                
            } else {
                // CASE IF IT IS DEFAULT CATEGORY
                

                
                if let foundcategory = catalogcategories.map({ $0.catId }).indexOf(categoryid) {
                    
                    let catalogname = catalogcategories[foundcategory].catname
                    
                    
                    self.productscategoriesnames.append(catalogname)
                    
                    
                }
                
                
            }
            
            
        }
        
        return productscategoriesnames
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
                //return ""
                imagePath = ""
                return imagePath
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
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
    
    func saveImageLocally1(imageData:NSData!) -> String {
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
                //return ""
                imagePath1 = ""
                return imagePath1
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath1 = "item\(uuid).png"
        
        return imagePath1//"item\(Int(time)).png"
    }
    
    func loadImageFromLocalStore1(imageName: String) -> UIImage {
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
                    self.imageToLoad1 = image!
                    // return imageToLoad
                } else {
                    self.imageToLoad1 = imagestochoose[0].itemimage
                }
                
            } else {
                self.imageToLoad1 = imagestochoose[0].itemimage
            }
            
        } else {
            self.imageToLoad1 = imagestochoose[0].itemimage
        }
        
        return imageToLoad1
    }


    
    func favitemsretrieval() {

        var query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isFav", equalTo: true)
        query.whereKey("chosenFromFavs", equalTo: false)
        query.whereKey("chosenFromHistory", equalTo: false)
        query.orderByDescending("CreationDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                //print("Successfully retrieved \(objects!.count) scores.")
                
                self.productsNames.removeAll(keepCapacity: true)
                self.productsImages.removeAll(keepCapacity: true)
                self.imagePaths.removeAll(keepCapacity: true)
                self.imagesToLoad.removeAll(keepCapacity: true)
                self.itemsiscatalog.removeAll(keepCapacity: true)
                self.itemsoriginal.removeAll(keepCapacity: true)
                self.itemsQuantity.removeAll(keepCapacity: true)
                self.itemsNotes.removeAll(keepCapacity: true)
                self.itemsTotalSums.removeAll(keepCapacity: true)
                self.itemsUnits.removeAll(keepCapacity: true)
                self.itemsPrices.removeAll(keepCapacity: true)
                self.itemsisfav.removeAll(keepCapacity: true)
                self.itemsPerUnit.removeAll(keepCapacity: true)
                self.favwaschosen.removeAll(keepCapacity: true)
                self.itemwasaddedid.removeAll(keepCapacity: true)
                
                self.itemisdefaultpict.removeAll(keepCapacity: true)
                self.itemoriginalindefaults.removeAll(keepCapacity: true)
                
                if let lists = objects as? [PFObject] {
                    for object in lists {

                      //  print(object["itemUUID"] as! String)
                        
                        self.favwaschosen.append(false)
                        
                        self.itemwasaddedid.append("")
                        
                        
                        self.productsNames.append(object["itemName"] as! String)

                        self.productsCategories.append(object["Category"] as! String)

                        
                        self.imagePaths.append(object["imageLocalPath"] as! String)
                        //self.imagePaths.append("")
                        self.itemsiscatalog.append(object["isCatalog"] as! Bool)
                        
                        self.itemisdefaultpict.append(object["defaultpicture"] as! Bool)
                        self.itemoriginalindefaults.append(object["OriginalInDefaults"] as! String)
                        
                        if object["isCatalog"] as! Bool == false {
                            
                            
                            if object["defaultpicture"] as! Bool == false {
                                
                                self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                
                                
                                
                                self.imagesToLoad.append(self.imageToLoad)
     
                            } else {
                                
                                var imagename = object["OriginalInDefaults"] as! String
                                
                                if (UIImage(named: "\(imagename)") != nil) {
                                    self.imagesToLoad.append(UIImage(named: "\(imagename)")!)
                                } else {
                                    self.imagesToLoad.append(imagestochoose[0].itemimage)
                                }
                                
                            }

                        } else {
   
                            if var founditem = catalogitems.map({ $0.itemId }).indexOf((object["originalInCatalog"] as! String))  {
                                var catalogitem = catalogitems[founditem]
                                
                                self.imagesToLoad.append(catalogitem.itemimage)
                            }
                        }
                        
                        
                        
                        self.itemsoriginal.append(object["originalInCatalog"] as! String)
                        
                        self.itemsQuantity.append(object["itemQuantity"] as! String)
                        
                        self.itemsNotes.append(object["itemNote"] as! String)
                        
                        self.itemsTotalSums.append(object["TotalSumS"] as! String)
                        
                        self.itemsUnits.append(object["itemUnit"] as! String)
                        
                        self.itemsPerUnit.append(object["perUnit"] as! String)
                        
                        self.itemsPrices.append(object["itemPriceS"] as! String)
                        
                        self.itemsisfav.append(object["isFav"] as! Bool)
                        
                        
                        self.tableView.reloadData()
                    }
                }
                
                self.getcategoriesnames(self.productsCategories)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    
    func addItemToTheListSelection(indexPathProduct: NSIndexPath) {

        
        //pause()
        
        if favwaschosen[indexPathProduct.row] == false {

        
        var shopItem = PFObject(className:"shopItems")
        
        var itemuuid = NSUUID().UUIDString
        
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = productsNames[indexPathProduct.row]
        
        favwaschosen[indexPathProduct.row] = true
            
        itemwasaddedid[indexPathProduct.row] = itemuuid
        
        // shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        
        shopItem["defaultpicture"] = itemisdefaultpict[indexPathProduct.row]
        
        shopItem["OriginalInDefaults"] = itemoriginalindefaults[indexPathProduct.row]
        
        if itemisdefaultpict[indexPathProduct.row] == true {
            shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        } else {
            shopItem["itemImage"] = NSNull()//imageFile
            
        }
        
        
        
        shopItem["ItemsList"] = currentlist//thiscurrentlist
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = itemsNotes[indexPathProduct.row]
        shopItem["itemQuantity"] = itemsQuantity[indexPathProduct.row]
        shopItem["itemPriceS"] = itemsPrices[indexPathProduct.row]
        shopItem["TotalSumS"] = itemsTotalSums[indexPathProduct.row]
        shopItem["chosenFromHistory"] = true//false
        shopItem["itemUnit"] = itemsUnits[indexPathProduct.row]
        shopItem["isChecked"] = false
        shopItem["imageLocalPath"] = imagePaths[indexPathProduct.row]
        
        shopItem["Category"] = productsCategories[indexPathProduct.row]
        shopItem["isCatalog"] = itemsiscatalog[indexPathProduct.row]
        
        shopItem["originalInCatalog"] = self.itemsoriginal[indexPathProduct.row]
        
        shopItem["isFav"] = self.itemsisfav[indexPathProduct.row]
        
        shopItem["chosenFromFavs"] = true
        
        shopItem["perUnit"] = itemsPerUnit[indexPathProduct.row]
        
        var itemdate = NSDate()
        
        shopItem["CreationDate"] = itemdate
        shopItem["UpdateDate"] = itemdate
        
        shopItem["ServerUpdateDate"] = itemdate.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        
        // shopItem.pinInBackground()
       
               // self.restore()
                print("saved item")
                var itemId = itemuuid
                
                var itemname = self.productsNames[indexPathProduct.row]
                var itemnote = self.itemsNotes[indexPathProduct.row]
                var itemquantity = self.itemsQuantity[indexPathProduct.row]
                var itemprice = self.itemsPrices[indexPathProduct.row]
                //var itemimage = imageFile
                var itemischecked = false
                var itemimagepath = self.imagePaths[indexPathProduct.row]
                var itemunit = self.itemsUnits[indexPathProduct.row]
                var itemperunit = self.itemsPerUnit[indexPathProduct.row]
                var itemimage2 = self.imagesToLoad[indexPathProduct.row]
                var itemcategory = self.productsCategories[indexPathProduct.row]
                
                var itemiscatalog = self.itemsiscatalog[indexPathProduct.row]
                var originalincatalog = self.itemsoriginal[indexPathProduct.row]
                
                var categoryname = self.productscategoriesnames[indexPathProduct.row]
                
                var itemtotalsum = self.itemsTotalSums[indexPathProduct.row]
                
                var thisitemisfav = self.itemsisfav[indexPathProduct.row]
                
                var isdefaultpict = self.itemisdefaultpict[indexPathProduct.row]
                var originalindefaults = self.itemoriginalindefaults[indexPathProduct.row]//self.itemisdefaultpict[indexPathProduct.row]
                
                
                self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalsum,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":itemdate,"ItemUpdate":itemdate,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
                
                
                itemsDataDict.append(self.dictionary)
                
                shoppingcheckedtocopy.append(false)
                
                itemsorderarray.append(itemuuid)
        
                //itemwasaddedid.append(itemuuid)
                
                tableView.reloadData()
        
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                
                print("Id on local data store is \(itemId)")
            } else {
                print("no id found")
            }
        })
        
    } else {
            
             favwaschosen[indexPathProduct.row] = false
            
            var idtodelete = itemwasaddedid[indexPathProduct.row]
            
            let queryitem = PFQuery(className:"shopItems")
            queryitem.fromLocalDatastore()
            queryitem.whereKey("itemUUID", equalTo: idtodelete)
            queryitem.getFirstObjectInBackgroundWithBlock() {
                (item: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let item = item {
                    item.unpinInBackground()
                    
                }
                
            }
            
            
            for ( var i = 0; i < itemsDataDict.count; i++ ) {
                if itemsDataDict[i]["ItemId"] as? String == idtodelete {
                    
                    itemsDataDict.removeAtIndex(i)
                    
                    break;
                    
                    
                }
            }
            
            
            if let founditem = itemsorderarray.map({ $0}).indexOf(idtodelete) {
                
                itemsorderarray.removeAtIndex(founditem)
                
                
            }
            
            itemwasaddedid[indexPathProduct.row] = ""
            
            shoppingcheckedtocopy.removeLast()
            
            tableView.reloadData()
            
    
    }

    
    }
    
    // end favs
    
    
    // MARK: - declare history
    
   // var thiscurrentlist1: String?
    
    var histwaschosen = [Bool]()
   // var histwaschosen = [false]
    
    var productsNames1 = [String]()
    
    var productsImages1 = [PFFile]()
    
    var productsCategories1 = [String]()
    
    //var imagesPaths = [String]()
    
    var imageToLoad1 = UIImage()
    var imagesToLoad1 = [UIImage]()
    
    var imagePath1 = String()
    var imagePaths1 = [String]()
    
    var itemsiscatalog1 = [Bool]()
    var itemsoriginal1 = [String]()
    
    var productscategoriesnames1 = [String]()
    
    //add this stuff
    var itemsQuantity1 = [String]()
    var itemsPrices1 = [String]()
    var itemsNotes1 = [String]()
    var itemsTotalSums1 = [String]()
    var itemsUnits1 = [String]()
    var itemsisfav1 = [Bool]()
    var itemschosenfromfavs1 = [Bool]()
    var itemsPerUnit1 = [String]()
    
    var itemisdefaultpict1 = [Bool]()
    var itemoriginalindefaults1 = [String]()

    
    //for unchecking1
   // var itemwasadded1 = [Bool]()
    var itemwasaddedid1 = [String]()
    
    
    
    var dictionary1 = Dictionary<String, AnyObject>()
    var itemsFromAddItemOptions1 = [Dictionary<String,AnyObject>()]
    
    
    func getcategoriesnames1(categoryIds: [String]) -> [String] {
        
        for categoryid in categoryIds {

            
            if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(categoryid) {
                let catalogname = catalogcategories[foundcategory].catname
                
                
                self.productscategoriesnames1.append(catalogname)

                
            }

            
        }
        
        return productscategoriesnames1
    }
    
    let progressHUDload = ProgressHUD(text: NSLocalizedString("loading", comment: ""))
    
    func pauseload() {
        
        
        self.view.addSubview(progressHUDload)
        
        progressHUDload.setup()
        progressHUDload.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    func restoreload() {
        
        progressHUDload.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }

    
    func histitemsretrieval() {
        
      //  pauseload()
        // var userquery = PF
        var query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("chosenFromHistory", equalTo: false)
        query.limit = 200
        query.orderByDescending("CreationDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
               // print("Successfully retrieved \(objects!.count) scores.")
                
                self.productsNames1.removeAll(keepCapacity: true)
                self.productsImages1.removeAll(keepCapacity: true)
                self.imagePaths1.removeAll(keepCapacity: true)
                self.imagesToLoad1.removeAll(keepCapacity: true)
                self.itemsiscatalog1.removeAll(keepCapacity: true)
                self.itemsoriginal1.removeAll(keepCapacity: true)
                self.itemsQuantity1.removeAll(keepCapacity: true)
                self.itemsNotes1.removeAll(keepCapacity: true)
                self.itemsTotalSums1.removeAll(keepCapacity: true)
                self.itemsUnits1.removeAll(keepCapacity: true)
                self.itemsPrices1.removeAll(keepCapacity: true)
                self.itemsisfav1.removeAll(keepCapacity: true)
                self.itemschosenfromfavs1.removeAll(keepCapacity: true)
                self.itemsPerUnit1.removeAll(keepCapacity: true)
                self.itemisdefaultpict1.removeAll(keepCapacity: true)
                self.itemoriginalindefaults1.removeAll(keepCapacity: true)
                self.histwaschosen.removeAll(keepCapacity: true)
                self.itemwasaddedid1.removeAll(keepCapacity:true)
                
                if let lists = objects as? [PFObject] {
                    for object in lists {
                        //println(object.objectId)
                      //  print(object["itemUUID"] as! String)
                        
                        self.histwaschosen.append(false)
                        
                        self.itemwasaddedid1.append("")
                        
                        self.productsNames1.append(object["itemName"] as! String)
                        
                        self.productsCategories1.append(object["Category"] as! String)
                        
                        self.imagePaths1.append(object["imageLocalPath"] as! String)
                        
                        self.itemsiscatalog1.append(object["isCatalog"] as! Bool)
                        
                        self.itemisdefaultpict1.append(object["defaultpicture"] as! Bool)
                        self.itemoriginalindefaults1.append(object["OriginalInDefaults"] as! String)
                        
                        if object["isCatalog"] as! Bool == false {
                            
                            if object["defaultpicture"] as! Bool == false {

                                self.loadImageFromLocalStore1(object["imageLocalPath"] as! String)
                                self.imagesToLoad1.append(self.imageToLoad1)
                                
                            } else {
                                
                                var imagename = object["OriginalInDefaults"] as! String
                                
                                if (UIImage(named: "\(imagename)") != nil) {
                                    self.imagesToLoad1.append(UIImage(named: "\(imagename)")!)
                                } else {
                                    self.imagesToLoad1.append(imagestochoose[0].itemimage)
                                }
                                
                            }
                            

                        } else {

                            if var founditem = catalogitems.map({ $0.itemId }).lazy.indexOf((object["originalInCatalog"] as! String)) {
                                var catalogitem = catalogitems[founditem]
                                
                                self.imagesToLoad1.append(catalogitem.itemimage)
                            }
                        }
                        
                        
                        
                        self.itemsoriginal1.append(object["originalInCatalog"] as! String)
                        
                        self.itemsQuantity1.append(object["itemQuantity"] as! String)
                        
                        self.itemsNotes1.append(object["itemNote"] as! String)
                        
                        self.itemsTotalSums1.append(object["TotalSumS"] as! String)
                        
                        self.itemsUnits1.append(object["itemUnit"] as! String)
                        
                        self.itemsPerUnit1.append(object["perUnit"] as! String)
                        
                        self.itemsPrices1.append(object["itemPriceS"] as! String)
                        
                        self.itemsisfav1.append(object["isFav"] as! Bool)
                        
                        self.itemschosenfromfavs1.append(object["chosenFromFavs"] as! Bool)

                        
                        self.tableView.reloadData()
                    }
                    
                   // self.restoreload()
                }
                
                self.getcategoriesnames1(self.productsCategories1)
                
            } else {
                //self.restoreload()
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    
    func histaddItemToTheListSelection(indexPathProduct: NSIndexPath) {
        
        if histwaschosen[indexPathProduct.row] == false {

        let imageData = UIImagePNGRepresentation(imagesToLoad1[indexPathProduct.row])

        let imageFile = PFFile(name:"itemImage.png", data:imageData!)
        
        var shopItem = PFObject(className:"shopItems")
        
        var itemuuid = NSUUID().UUIDString
        
        histwaschosen[indexPathProduct.row] = true
        
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = productsNames1[indexPathProduct.row]
            
        itemwasaddedid1[indexPathProduct.row] = itemuuid
        
        shopItem["defaultpicture"] = itemisdefaultpict1[indexPathProduct.row]
        
        shopItem["OriginalInDefaults"] = itemoriginalindefaults1[indexPathProduct.row]
        
        if itemisdefaultpict1[indexPathProduct.row] == true {
            shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        } else {
            shopItem["itemImage"] = imageFile
            
        }
        
        shopItem["ItemsList"] = currentlist//thiscurrentlist1
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = itemsNotes1[indexPathProduct.row]
        shopItem["itemQuantity"] = itemsQuantity1[indexPathProduct.row]
        shopItem["itemPriceS"] = itemsPrices1[indexPathProduct.row] //must convert string to DOUBLE
        shopItem["TotalSumS"] = itemsTotalSums1[indexPathProduct.row] //complicated stuff
        shopItem["chosenFromHistory"] = true
        shopItem["itemUnit"] = itemsUnits1[indexPathProduct.row]
        shopItem["isChecked"] = false
        shopItem["imageLocalPath"] = imagePaths1[indexPathProduct.row]
        
        shopItem["Category"] = productsCategories1[indexPathProduct.row]
        shopItem["isCatalog"] = itemsiscatalog1[indexPathProduct.row]
        
        shopItem["originalInCatalog"] = self.itemsoriginal1[indexPathProduct.row]
        
        shopItem["isFav"] = self.itemsisfav1[indexPathProduct.row]
        
        shopItem["chosenFromFavs"] = self.itemschosenfromfavs1[indexPathProduct.row]
        
        shopItem["perUnit"] = itemsPerUnit1[indexPathProduct.row]
        
        var date = NSDate()
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
        
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        
        var itemId = itemuuid
        
        var itemname = self.productsNames1[indexPathProduct.row]
        var itemnote = self.itemsNotes1[indexPathProduct.row]
        var itemquantity = self.itemsQuantity1[indexPathProduct.row]
        var itemprice = self.itemsPrices1[indexPathProduct.row]
        //var itemimage = imageFile
        var itemischecked = false
        var itemimagepath = self.imagePaths1[indexPathProduct.row]
        var itemunit = self.itemsUnits1[indexPathProduct.row]
        var itemperunit = self.itemsPerUnit1[indexPathProduct.row]
        
        var itemimage2 = self.imagesToLoad1[indexPathProduct.row]
        var itemcategory = self.productsCategories1[indexPathProduct.row]
        
        var itemiscatalog = self.itemsiscatalog1[indexPathProduct.row]
        var originalincatalog = self.itemsoriginal1[indexPathProduct.row]
        
        var categoryname = self.productscategoriesnames1[indexPathProduct.row]
        
        var itemtotalsum = self.itemsTotalSums1[indexPathProduct.row]
        
        var thisitemisfav = self.itemsisfav1[indexPathProduct.row]
        
        var isdefaultpict = self.itemisdefaultpict1[indexPathProduct.row]
        var originalindefaults = self.itemoriginalindefaults1[indexPathProduct.row]//self.itemisdefaultpict[indexPathProduct!.row]
        
        self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalsum,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
        
        
        itemsDataDict.append(self.dictionary)
        
        shoppingcheckedtocopy.append(false)
        
        itemsorderarray.append(itemuuid)
            
       
        
        tableView.reloadData()
        
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                //self.restore()
                print("saved item")

                
                print("Id on local data store is \(itemId)")
            } else {
                print("no id found")
            }
        })
        
    } else {
            
            histwaschosen[indexPathProduct.row] = false
            
            var idtodelete = itemwasaddedid1[indexPathProduct.row]
            
            let queryitem = PFQuery(className:"shopItems")
            queryitem.fromLocalDatastore()
            queryitem.whereKey("itemUUID", equalTo: idtodelete)
            queryitem.getFirstObjectInBackgroundWithBlock() {
                (item: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let item = item {
                    item.unpinInBackground()
                    
                }
                
            }
            
            
            for ( var i = 0; i < itemsDataDict.count; i++ ) {
                if itemsDataDict[i]["ItemId"] as? String == idtodelete {
                    
                    itemsDataDict.removeAtIndex(i)
                    
                    break;
                    
                    
                }
            }
            
            
            if let founditem = itemsorderarray.map({ $0}).indexOf(idtodelete) {
                
                itemsorderarray.removeAtIndex(founditem)
                
                
            }
            
            itemwasaddedid1[indexPathProduct.row] = ""
            
            shoppingcheckedtocopy.removeLast()
            
            tableView.reloadData()

    
    }
    
    }

    
    // end of history
    
    // MARK: - SEARCH
    
    @IBAction func showsearch(sender: AnyObject) {
        
        configureCustomSearchController()
    }
    
    @IBAction func doneediting(sender: AnyObject) {
        
        
        shoplistdelegate?.refreshtable()
        
        performSegueWithIdentifier("newbacktocreationafteroptions", sender: self)
    }
    
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 40.0), searchBarFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!, searchBarTextColor: UIColorFromRGB(0x61C791), searchBarTintColor: UIColorFromRGB(0x2A2F36))
        
        customSearchController.customSearchBar.placeholder = NSLocalizedString("Search1", comment: "Search")
        tableView.tableHeaderView = customSearchController.customSearchBar
        customSearchController.customDelegate = self
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = NSLocalizedString("Search2", comment: "Search")
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    
    func didStartSearching() {

        filteredcategories.removeAll(keepCapacity: true)
        shouldShowSearchResults = true
        filteredcategories.appendContentsOf(newcatalogcategories)
        tableView.reloadData()

    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true

            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false

        tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {

        filteredcategories.removeAll(keepCapacity: true)
        
        filteredcategories = newcatalogcategories.filter({ (category:Category) -> Bool in
            let catText: NSString = category.catname
            
            return (catText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })

        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text

        filteredcategories = newcatalogcategories.filter({ (category:Category) -> Bool in
            
            let catText: NSString = category.catname

            return (catText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        tableView.reloadData()

    }
    
    //// END OF SEARCH STUFF
    
    // end of search
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
    @IBOutlet var segmentedcontrol: UISegmentedControl!
    
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var searchoutlet: UIBarButtonItem!
    
    @IBAction func controlchanged(sender: AnyObject) {
        
        
        
        switch(segmentedcontrol.selectedSegmentIndex) {
        case 0:
            
            
                searchoutlet.enabled = true
                searchoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
                
        
            
            break;
        case 1:
            
            searchoutlet.enabled = false
            searchoutlet.tintColor = UIColorFromRGB(0x31797D)
            
            
            
            
            break;
        case 2:
            searchoutlet.enabled = false
            searchoutlet.tintColor = UIColorFromRGB(0x31797D)
            break;
        default:
            break
        }

        
        tableView.reloadData()
    }
    
    @IBOutlet var segmview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedcontrol.setTitle(NSLocalizedString("newcat", comment: ""), forSegmentAtIndex: 0)
        segmentedcontrol.setTitle(NSLocalizedString("newfavs", comment: ""), forSegmentAtIndex: 1)
        segmentedcontrol.setTitle(NSLocalizedString("newhist", comment: ""), forSegmentAtIndex: 2)
        
         favitemsretrieval()
        histitemsretrieval()
         onlydefaults()
        
        segmview.layer.cornerRadius = 8
         tableView.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        var returnValue = 0
        
        switch(segmentedcontrol.selectedSegmentIndex) {
        case 0:
            
            if shouldShowSearchResults {
                
                returnValue = filteredcategories.count
                
            } else {
                
                returnValue = newcatalogcategories.count
            }

            break;
        case 1:
            
            
            returnValue = productsNames.count
            break;
        case 2:
            returnValue = productsNames1.count
            break;
        default:
            break
        }
        
        return returnValue//
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "optcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! NewOptCell
        
        
        switch(segmentedcontrol.selectedSegmentIndex) {
        case 0:
            
             cell.selectionStyle = UITableViewCellSelectionStyle.Default
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            if shouldShowSearchResults == false {
                
                cell.prodpicture.image = newcatalogcategories[indexPath.row].catimage
                cell.prodname.text = newcatalogcategories[indexPath.row].catname
            } else {
                cell.prodpicture.image = filteredcategories[indexPath.row].catimage
                cell.prodname.text = filteredcategories[indexPath.row].catname
            }
            
            cell.plusimage.hidden = true
            
            // cell.prodqty.hidden = true

            
            break;
        case 1:
            
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if favwaschosen[indexPath.row] == true {
                
                cell.plusimage.image = checkimage
                
            } else {
                 cell.plusimage.image = notcheckimage
            }
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var qty = itemsQuantity[indexPath.row]
            
            var unit = itemsUnits[indexPath.row]
            
            var qu : String = "\(qty) \(unit)"
            
            if qu != " " {
                 cell.prodname.text = "\(productsNames[indexPath.row]), \(qu)"
            } else {
                 cell.prodname.text = "\(productsNames[indexPath.row]) \(qu)"
            }
           // cell.prodname.text = "\(productsNames[indexPath.row]) \(qty) \(unit)"
            cell.prodpicture.image = imagesToLoad[indexPath.row]
            
            cell.plusimage.hidden = false
            
          //  cell.prodqty.hidden = false
            
           
            
           // cell.prodqty.text = "\(qty) \(unit)"
            
            
            break;
        case 2:
            
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if histwaschosen[indexPath.row] == true {
                
                cell.plusimage.image = checkimage
                
            } else {
                cell.plusimage.image = notcheckimage
            }
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var qty = itemsQuantity1[indexPath.row]
            
            var unit = itemsUnits1[indexPath.row]
            
            var qu : String = "\(qty) \(unit)"
            
            if qu != " " {
                cell.prodname.text = "\(productsNames1[indexPath.row]), \(qu)"
            } else {
                cell.prodname.text = "\(productsNames1[indexPath.row]) \(qu)"
            }

            
           // cell.prodname.text = "\(productsNames1[indexPath.row]) \(qty) \(unit)"

            cell.prodpicture.image = imagesToLoad1[indexPath.row]
            
            cell.plusimage.hidden = false
            
            
            
           // cell.prodqty.hidden = false
            
           // cell.prodqty.text = "\(qty) \(unit)"
            
            break;
        default:
            break
        }

        
        return cell
    }
    
    var checkimage = UIImage(named: "CheckPath") as UIImage!
    
    let notcheckimage = UIImage(named: "BlackPlus") as UIImage!
    
    
    var catwaschosen: Category?
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let ItemCellIdentifier = "optcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! NewOptCell
        
        
        switch(segmentedcontrol.selectedSegmentIndex) {
        case 0:
            
            //perfromsegue!
            if shouldShowSearchResults == false {
           catwaschosen = newcatalogcategories[indexPath.row]
            } else {
               catwaschosen = filteredcategories[indexPath.row]
            }
            
            performSegueWithIdentifier("newshowsubcatalog", sender: cell)
            
            break;
        case 1:
            
            addItemToTheListSelection(indexPath)
            
            cell.plusimage.image = checkimage
            
            break;
        case 2:
            
            histaddItemToTheListSelection(indexPath)
            
            cell.plusimage.image = checkimage

            
            break;
        default:
            break
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newshowsubcatalog" {
          
            
            let subcatalogVC = segue.destinationViewController as! SubCatalogTableViewController
            
           
            
           // if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) { // doesnt work here since segue is from VC rather than from table view cell as it was before
            
                    
                    subcatalogVC.currentcategory = catwaschosen//newcatalogcategories[indexPath.row]//catalogcategories[indexPath.row]
                    subcatalogVC.currentsubcataloglist = currentlist//currentcataloglist

                
         //   }
            
            subcatalogVC.shopdelegate = shoplistdelegate
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
