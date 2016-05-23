//
//  FavouriteItems.swift
//  ParseStarterProject
//
//  Created by PekkiPo (Aleksei Petukhov) on 28/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class FavouriteItems: UITableViewController {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    var shoplistdelegate : RefreshListDelegate?
    
    
    @IBAction func doneediting(sender: AnyObject) {
        
        
         shoplistdelegate?.refreshtable()
        
        performSegueWithIdentifier("backtolistfromfav", sender: self)
    }
   
    
    
    
    var thiscurrentlist: String?
    
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

    
    var dictionary = Dictionary<String, AnyObject>()
    //var itemsFromAddItemOptions = [Dictionary<String,AnyObject>()]
    
    
    func pause() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func restore() {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
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
                            //self.shoppingListItemsCategoriesNames.append(thiscatname)
                            self.productscategoriesnames.append(thiscatname)
                        }
                    }
                } else {
                    print("No custom cats yet")
                }
                
                
            } else {
                // CASE IF IT IS DEFAULT CATEGORY
                
                
               // if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), categoryid) {
                
                if let foundcategory = catalogcategories.map({ $0.catId }).indexOf(categoryid) {
                    
                    let catalogname = catalogcategories[foundcategory].catname
                    
                    print(catalogname)
                    
                    self.productscategoriesnames.append(catalogname)
                    
                    //self.shoppingListItemsCategoriesNames.append(catalogname)
                    // println("Names are \(shoppingListItemsCategoriesNames)")
                    
                }
                
                
            }
            
            
        }
        
        return productscategoriesnames
    }
    
    
    func addItemToTheListSelection(indexPathProduct: NSIndexPath) {
        //use thiscurrentlist variable
        
        pause()
        //basically duplicating the of an itemlist but with different list attached
        
        // let imageData = UIImagePNGRepresentation(imagesToLoad[indexPathProduct.row])
        //let imageData = UIImagePNGRepresentation(chosenPicture)
       // let imageFile = PFFile(name:"itemImage.png", data:imageData!)
        
        var shopItem = PFObject(className:"shopItems")
        
        var itemuuid = NSUUID().UUIDString
        
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = productsNames[indexPathProduct.row]
        
        
        // shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        
        shopItem["defaultpicture"] = itemisdefaultpict[indexPathProduct.row]
        
        shopItem["OriginalInDefaults"] = itemoriginalindefaults[indexPathProduct.row]
        
        if itemisdefaultpict[indexPathProduct.row] == true {
            shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        } else {
            shopItem["itemImage"] = NSNull()//imageFile
            
        }
        
        
        
        shopItem["ItemsList"] = thiscurrentlist
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = itemsNotes[indexPathProduct.row]
        shopItem["itemQuantity"] = itemsQuantity[indexPathProduct.row]
        shopItem["itemPriceS"] = itemsPrices[indexPathProduct.row]
        shopItem["TotalSumS"] = itemsTotalSums[indexPathProduct.row]
        shopItem["chosenFromHistory"] = false
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
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                self.restore()
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
                var originalindefaults = self.itemisdefaultpict[indexPathProduct.row]
                
                
                self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalsum,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":itemdate,"ItemUpdate":itemdate,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
                
                HistoryitemsDataDict.append(self.dictionary)
                
                itemsDataDict.append(self.dictionary)
                
                shoppingcheckedtocopy.append(false)
                
                itemsorderarray.append(itemuuid)
                
                
                print("Id on local data store is \(itemId)")
            } else {
                print("no id found")
            }
        })
        
        
        
        //shopItem.saveEventually() {
        /*
        shopItem.saveInBackgroundWithBlock {
        (success: Bool, error: NSError?) -> Void in
        if (success) {
        
        print("SAVE ALSO TO SERVER")
        } else {
        // There was a problem, check error.description
        }
        }
        */
        //cell.favitemadded.hidden = false
       // var checkimage = UIImage(named: "CheckPath") as UIImage!
        // cell.addfavitem.setImage(checkimage, forState: UIControlState.Normal)
        
    }
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellIdentifier = "favitemscell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FavItemCell
        
        addItemToTheListSelection(indexPath)
        
        
        cell.favitemadded.hidden = false
        var checkimage = UIImage(named: "CheckPath") as UIImage!
        cell.addfavitem.setImage(checkimage, forState: UIControlState.Normal)
        
    }
    */
    
    func addItemToTheList(sender: UIButton!) {
        //use thiscurrentlist variable
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! FavItemCell
        let indexPathProduct = tableView.indexPathForCell(cell)
        
        pause()
        //basically duplicating the of an itemlist but with different list attached
        
        //let imageData = UIImagePNGRepresentation(imagesToLoad[indexPathProduct!.row])
        //let imageData = UIImagePNGRepresentation(chosenPicture)
        //let imageFile = PFFile(name:"itemImage.png", data:imageData!)
        
        let imageData = UIImagePNGRepresentation(imagesToLoad[indexPathProduct!.row])
        //let imageData = UIImagePNGRepresentation(chosenPicture)
        let imageFile = PFFile(name:"itemImage.png", data:imageData!)
        
        var shopItem = PFObject(className:"shopItems")
        
        var itemuuid = NSUUID().UUIDString
        
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = productsNames[indexPathProduct!.row]
        
        
       // shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        
        shopItem["defaultpicture"] = itemisdefaultpict[indexPathProduct!.row]
        
        shopItem["OriginalInDefaults"] = itemoriginalindefaults[indexPathProduct!.row]
        
        if itemisdefaultpict[indexPathProduct!.row] == true {
            shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        } else {
            shopItem["itemImage"] = imageFile
            
        }

        
        
        shopItem["ItemsList"] = thiscurrentlist
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = itemsNotes[indexPathProduct!.row]
        shopItem["itemQuantity"] = itemsQuantity[indexPathProduct!.row]
        shopItem["itemPriceS"] = itemsPrices[indexPathProduct!.row] //must convert string to DOUBLE
        shopItem["TotalSumS"] = itemsTotalSums[indexPathProduct!.row] //complicated stuff
        shopItem["chosenFromHistory"] = false
        shopItem["itemUnit"] = itemsUnits[indexPathProduct!.row]
        shopItem["isChecked"] = false
        shopItem["imageLocalPath"] = imagePaths[indexPathProduct!.row]
        
        shopItem["Category"] = productsCategories[indexPathProduct!.row]
        shopItem["isCatalog"] = itemsiscatalog[indexPathProduct!.row]
        
        shopItem["originalInCatalog"] = self.itemsoriginal[indexPathProduct!.row]
        
        shopItem["isFav"] = self.itemsisfav[indexPathProduct!.row]
        
        shopItem["chosenFromFavs"] = true
        
         shopItem["perUnit"] = itemsPerUnit[indexPathProduct!.row]
        
        var itemdate = NSDate()
        
        shopItem["CreationDate"] = itemdate
        shopItem["UpdateDate"] = itemdate
        
        shopItem["ServerUpdateDate"] = itemdate
        
        shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        
        // shopItem.pinInBackground()
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                self.restore()
                print("saved item")
                var itemId = itemuuid
                
                var itemname = self.productsNames[indexPathProduct!.row]
                var itemnote = self.itemsNotes[indexPathProduct!.row]
                var itemquantity = self.itemsQuantity[indexPathProduct!.row]
                var itemprice = self.itemsPrices[indexPathProduct!.row]
                //var itemimage = imageFile
                var itemischecked = false
                var itemimagepath = self.imagePaths[indexPathProduct!.row]
                var itemunit = self.itemsUnits[indexPathProduct!.row]
                var itemperunit = self.itemsPerUnit[indexPathProduct!.row]
                var itemimage2 = self.imagesToLoad[indexPathProduct!.row]
                var itemcategory = self.productsCategories[indexPathProduct!.row]
                
                var itemiscatalog = self.itemsiscatalog[indexPathProduct!.row]
                var originalincatalog = self.itemsoriginal[indexPathProduct!.row]
                
                var categoryname = self.productscategoriesnames[indexPathProduct!.row]
                
                var itemtotalsum = self.itemsTotalSums[indexPathProduct!.row]
                
                var thisitemisfav = self.itemsisfav[indexPathProduct!.row]
                
                var isdefaultpict = self.itemisdefaultpict[indexPathProduct!.row]
                var originalindefaults = self.itemoriginalindefaults[indexPathProduct!.row]

                
                self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalsum,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":itemdate,"ItemUpdate":itemdate,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
                
                HistoryitemsDataDict.append(self.dictionary)
                
                itemsDataDict.append(self.dictionary)
                
                shoppingcheckedtocopy.append(false)
                
                itemsorderarray.append(itemuuid)

               // self.tableView.reloadData()
                
                print("Id on local data store is \(itemId)")
            } else {
                print("no id found")
            }
        })
        
        
        
        //shopItem.saveEventually() {
        /*
         shopItem.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {

                print("SAVE ALSO TO SERVER")
            } else {
                // There was a problem, check error.description
            }
        }
        */
       // cell.favitemadded.hidden = false
        var checkimage = UIImage(named: "CheckPath") as UIImage!
        cell.addfavitem.setImage(checkimage, forState: UIControlState.Normal)
        
    }
    

    
    //// retrieve image from local
    /*
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        let path = dir.stringByAppendingPathComponent(imageName)
        
        if(!path.isEmpty){
            let image = UIImage(contentsOfFile: path)
            print(image);
            if(image != nil){
                //return image!;
                self.imageToLoad = image!
                return imageToLoad
            }
        }
        
        return UIImage(named: "activity.png")!
    }
    */
    
    
    //// END save to local
    
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
    /*
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //try for ios9.2
        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(imageName)
        
        // if(!path.isEmpty){
        if path != "" {
            
            let data = NSData(contentsOfURL:path)
            
            let image = UIImage(data:data!)
            
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
        
        return imageToLoad
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

    
    
    func itemsretrieval() {
        // var userquery = PF
        var query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isFav", equalTo: true)
        query.whereKey("chosenFromFavs", equalTo: false)
        query.orderByDescending("CreationDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                
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
                
                self.itemisdefaultpict.removeAll(keepCapacity: true)
                self.itemoriginalindefaults.removeAll(keepCapacity: true)
                
                if let lists = objects as? [PFObject] {
                    for object in lists {
                        //println(object.objectId)
                        print(object["itemUUID"] as! String)
                        
                        
                        self.productsNames.append(object["itemName"] as! String)
                        
                        //self.productsImages.append(object["itemImage"] as! PFFile)
                       // self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                        
                        self.productsCategories.append(object["Category"] as! String)
                        
                        //self.imagesToLoad.append(self.imageToLoad)
                        
                        self.imagePaths.append(object["imageLocalPath"] as! String)
                         //self.imagePaths.append("")
                        self.itemsiscatalog.append(object["isCatalog"] as! Bool)
                        
                        self.itemisdefaultpict.append(object["defaultpicture"] as! Bool)
                        self.itemoriginalindefaults.append(object["OriginalInDefaults"] as! String)
                        
                        if object["isCatalog"] as! Bool == false {
                            
                            
                            if object["defaultpicture"] as! Bool == false {
                                
                                self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                
                                
                                
                                self.imagesToLoad.append(self.imageToLoad)
                                
                                /*
                                var imageFile = object["itemImage"] as! PFFile
                               
                                
                                var imageData = imageFile.getData()
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    self.imagesToLoad.append(image!)

                                } else {
                                    self.imagesToLoad.append(imagestochoose[0].itemimage)
                                }
                                */
                                /*
                                var prodimage = UIImage()
                                imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                                    if let downloadedImage = UIImage(data: data!) {
                                        prodimage = downloadedImage
                                        
                                        self.imagesToLoad.append(prodimage)
                                        
                                    } else {
                                        self.imagesToLoad.append(imagestochoose[0].itemimage)
                                    }
                                }
                                */
                            } else {
                                
                                var imagename = object["OriginalInDefaults"] as! String
                                
                                if (UIImage(named: "\(imagename)") != nil) {
                                    self.imagesToLoad.append(UIImage(named: "\(imagename)")!)
                                } else {
                                    self.imagesToLoad.append(imagestochoose[0].itemimage)
                                }
                                
                            }
                            
                            
                            //self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                            //self.imagesToLoad.append(self.imageToLoad)
                            // self.shoppingListItemsImages2.append(self.imageToLoad)
                        } else {
                            //if catalog item
                            //self.shoppingListItemsImages2.append(
                            //if var founditem = find(lazy(catalogitems).map({ $0.itemId }), (object["originalInCatalog"] as! String)) {
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
    
    override func viewWillAppear(animated: Bool) {
        //itemsretrieval()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsretrieval()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return productsNames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "favitemscell"
        let favcell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FavItemCell
        
        favcell.selectionStyle = UITableViewCellSelectionStyle.None
        // Configure the cell...
        
        favcell.favproductname.text = productsNames[indexPath.row] //name
        //this is for getting image as a data
        
        favcell.favproductimage.image = imagesToLoad[indexPath.row]
        
        /*
        productsImages[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
        //we extract the image from parse and post them
        
        if let downloadedImage = UIImage(data: data!) {
        
        prodhistorycell.prodimage.image = downloadedImage
        
        }
        
        }
        */
        
        //favcell.addfavitem.tag = indexPath.row
        //favcell.favitemadded.hidden = true
         favcell.addfavitem.addTarget(self, action: "addItemToTheList:", forControlEvents: .TouchUpInside)
        
        // Configure the cell...
        
        
        return favcell
    }

    
    
    
   
}
