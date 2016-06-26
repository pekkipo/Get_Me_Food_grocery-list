//
//  SubCatalogTableViewController.swift
//  ParseStarterProject
//
//  Created by PekkiPo (Aleksei Petukhov) on 19/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse



class SubCatalogTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {

    
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    
    var currentsubcataloglist = String()
    
    var currentcategory: Category?
    
    
    
    
    //var currentcategory: String?
    var currentcategoryindex: Int?
    var thiscategoryitems = [CatalogItem]()
    
    var filteredcategoryitems = [CatalogItem]()
    
    
    
    var shouldShowSearchResults = false
    
    
    
    @IBAction func showsearchaction(sender: AnyObject) {
        
        configureCustomSearchController()
    }
    
    
    @IBOutlet var navitem: UINavigationItem!
    
    
     var dictionary = Dictionary<String, AnyObject>()
    
    
    var imagePath = String()
    var imagespaths = [String]()
    
    var imageToLoad = UIImage()
    
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
    
    
    
    func finditems() {

        for item in catalogitems {
            if item.itemcategory == currentcategory {
                thiscategoryitems.append(item)
                
                
            } else {
                print("This item doesn't belong")
                }
            }

    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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

    
    
    //if let founditem = find(lazy(catalogitems).map({ $0.itemcategory }), catalogcategories[0]) {
       // let catalogitem = thiscategoryitems.append(catalogitems[founditem])
    //}
    //var foundcategory = find(lazy(catalogcategories).map({ $0.catId }), categoryid)
    
   // var foundcategory = find(lazy(catalogitems).map({ $3.itemcategory }), currentcategory)     //if //(contains(catalogitems,))
    
    //catalogcategories[0])
    //for that to work I had to make class HASHABLE
        //var catalogname = catalogcategories[foundcategory].catname
    
    
    
    //// SEARCH STUFF
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func configureCustomSearchController() {
      //  customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 40.0), searchBarFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!, searchBarTextColor: UIColorFromRGB(0x31797D), searchBarTintColor: UIColorFromRGB(0xEFEFEF))
        
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
        // let searchString = searchController.searchBar.text
        //if searchString.isEmpty == true {
        //    shouldShowSearchResults = false
        //    tableView.reloadData()
        //  } else {
        filteredcategoryitems.removeAll(keepCapacity: true)
        
        
        shouldShowSearchResults = true
        filteredcategoryitems.appendContentsOf(thiscategoryitems) // doesn't work like this
        tableView.reloadData() // without this error
        //filteredcategoryitems.removeAll(keepCapacity: true)
       // println(filteredcategoryitems)
       // tableView.reloadData() // AT LEAST NOW IT DOESNT'T DISAPPEAR IMMEDIATELY //IF RELOAD, TABLE BECOMES EMPTY
        // }
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
             // println(filteredcategoryitems)
            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
         // println(filteredcategoryitems)
        tableView.reloadData()
    }
    
   
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredcategoryitems.removeAll(keepCapacity: true)
        
        filteredcategoryitems = thiscategoryitems.filter({ (item:CatalogItem) -> Bool in
            let itemText: NSString = item.itemname
          
            

            
            return (itemText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        /*
        if searchText.isEmpty == true {
            self.shouldShowSearchResults = false
        } else {
            self.shouldShowSearchResults = true
        }
        */
        
       // if itemText.
      //  if searchText.isEmpty == true {
       //      self.shouldShowSearchResults = false
       // }
        // Reload the tableview.
        
        
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
        
      //  if searchString.isEmpty == true {
         //   shouldShowSearchResults = false
            // tableView.reloadData()
       // } else {

           
            // Filter the data array and get only those countries that match the search text.
            
            
             filteredcategoryitems = thiscategoryitems.filter({ (item:CatalogItem) -> Bool in
                
                let itemText: NSString = item.itemname
                
                
                return (itemText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
            })
            
            // Reload the tableview.
            tableView.reloadData()
       // }
    }
    
    //// END OF SEARCH STUFF


    
    /*
    func saveImageLocally(imageData:NSData!) -> String {
        var uuid = NSUUID().UUIDString
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
        
        let pathToSaveImage = dir.stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "catalogitem\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
*/
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
                return ""
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

    
    //var price : Double = 0
    //var totsum : Double = 0
    
    func addcatalogitembyselection(indexPathCatalogProduct: NSIndexPath) {
        //use thiscurrentlist variable
        
        
        var ischecked : Bool = false
        
        if shouldShowSearchResults == false {
            
            if thiscategoryitems[indexPathCatalogProduct.row].itemischecked! == true
            {
                ischecked = true
            }
            
            
            
            
        } else if shouldShowSearchResults == true {
            
            if filteredcategoryitems[indexPathCatalogProduct.row].itemischecked! == true {
                ischecked = true
            }
            
        }

        if ischecked == false {
        
        pause()
        //basically duplicating the of an itemlist but with different list attached
        let shopItem = PFObject(className:"shopItems")
        
        let uuid = NSUUID().UUIDString
        let catalogitemuuid = "catalogitem\(uuid)"
        
        let date = NSDate()
        
        
        if self.shouldShowSearchResults == false {
            let itemId = catalogitemuuid
            
            let itemname = self.thiscategoryitems[indexPathCatalogProduct.row].itemname
            let itemnote = ""
            let itemquantity = ""
            let itemprice = ""//0.0
            //var itemimage = imageFile
            let itemischecked = false
            let itemimagepath = ""//self.imagespaths[indexPathCatalogProduct.row]//"Banana.png"//self.imagePath
            let itemunit = ""
            let itemimage2 = self.thiscategoryitems[indexPathCatalogProduct.row].itemimage
            let itemcategory = self.currentcategory!.catId
            let itemiscatalog = true
            let originalincatalog = self.thiscategoryitems[indexPathCatalogProduct.row].itemId
            
            let itemperunit = ""
            
            let categoryname = self.currentcategory!.catname
            
            let itemtotalprice = ""//0.0
            
            let thisitemisfav = false
            
            let isdefaultpict = false
            let originalindefaults = ""
            
            self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
        } else {
            let itemId = catalogitemuuid
            
            let itemname = self.filteredcategoryitems[indexPathCatalogProduct.row].itemname
            let itemnote = ""
            let itemquantity = ""
            let itemprice = ""//0.0
            //var itemimage = imageFile
            let itemischecked = false
            let itemimagepath = ""//self.imagespaths[indexPathCatalogProduct.row]//"Banana.png"//self.imagePath
            let itemunit = ""
            let itemperunit = ""
            let itemimage2 = self.filteredcategoryitems[indexPathCatalogProduct.row].itemimage
            let itemcategory = self.currentcategory!.catId
            let itemiscatalog = true
            let originalincatalog = self.filteredcategoryitems[indexPathCatalogProduct.row].itemId
            
            let categoryname = self.currentcategory!.catname
            let itemtotalprice = ""//0.0
            let thisitemisfav = false
            
            let isdefaultpict = false
            let originalindefaults = ""
            
            self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
        }
        
        // HistoryitemsDataDict.append(self.dictionary)
        
        itemsDataDict.append(self.dictionary)
        
        shoppingcheckedtocopy.append(false)
        
        itemsorderarray.append(catalogitemuuid)
        
        
        self.restore()
        
        
        /// NOW PARSE PART
        
        shopItem["itemUUID"] = catalogitemuuid//thiscategoryitems[indexPathCatalogProduct!.row].itemId
        shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        shopItem["ItemsList"] = currentsubcataloglist
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = ""
        shopItem["itemQuantity"] = ""
        shopItem["itemPriceS"] = ""//0.0
        shopItem["TotalSumS"] = ""//0.0
        shopItem["chosenFromHistory"] = false
        shopItem["itemUnit"] = ""
        shopItem["isChecked"] = false
        shopItem["isCatalog"] = true
        shopItem["isFav"] = false
        shopItem["chosenFromFavs"] = false
        shopItem["perUnit"] = ""
        
        shopItem["defaultpicture"] = false
        shopItem["OriginalInDefaults"] = ""
        
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
        
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        
        if shouldShowSearchResults == false {
            
            shopItem["originalInCatalog"] = thiscategoryitems[indexPathCatalogProduct.row].itemId
            shopItem["itemName"] = thiscategoryitems[indexPathCatalogProduct.row].itemname

            
            shopItem["imageLocalPath"] = ""//imagePath
        } else {
            shopItem["originalInCatalog"] = filteredcategoryitems[indexPathCatalogProduct.row].itemId
            shopItem["itemName"] = filteredcategoryitems[indexPathCatalogProduct.row].itemname

            
            shopItem["imageLocalPath"] = ""//imagePath
        }
        
        
        shopItem["Category"] = currentcategory?.catId
        
        print("saved item")
        
        // shopItem.pinInBackground()
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                //self.restore()
                print("saved item")
                
            } else {
                print("no id found")
            }
        })

        
        if shouldShowSearchResults == false {
            
            thiscategoryitems[indexPathCatalogProduct.row].itemischecked! = true
            
            thiscategoryitems[indexPathCatalogProduct.row].itemaddedid! = catalogitemuuid
            
            
        } else if shouldShowSearchResults == true {
            
            filteredcategoryitems[indexPathCatalogProduct.row].itemischecked! = true
            
            filteredcategoryitems[indexPathCatalogProduct.row].itemaddedid! = catalogitemuuid
            
            let catitemid = filteredcategoryitems[indexPathCatalogProduct.row].itemId
            
            if let founditem = thiscategoryitems.map({ $0.itemId }).indexOf(catitemid) {
                thiscategoryitems[founditem].itemischecked! = true
                thiscategoryitems[founditem].itemaddedid! = catalogitemuuid
                
            }

        }
        
        
        tableView.reloadData()
        
        
         } else {
        //if user unchecks the item
        
        
            
            var idtodelete = String()
        
            if shouldShowSearchResults == false {
                
                    idtodelete = thiscategoryitems[indexPathCatalogProduct.row].itemaddedid!
                
                    thiscategoryitems[indexPathCatalogProduct.row].itemischecked! = false
                
                
            } else if shouldShowSearchResults == true {
                
                idtodelete = filteredcategoryitems[indexPathCatalogProduct.row].itemaddedid!
                
                filteredcategoryitems[indexPathCatalogProduct.row].itemischecked! = false
                
                let catitemid = filteredcategoryitems[indexPathCatalogProduct.row].itemId
                
                if let founditem = thiscategoryitems.map({ $0.itemId }).indexOf(catitemid) {
                    thiscategoryitems[founditem].itemischecked! = false
                    
                }
                
                
            }
            
            
            
            
            
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
            
            shoppingcheckedtocopy.removeLast()
            
             tableView.reloadData()

         }
        
    }
    
    
    
    func addCatalogItemToTheList(sender: UIButton!) {
        //use thiscurrentlist variable
        
        
        
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! SubCatalogCell
        let indexPathCatalogProduct = tableView.indexPathForCell(cell)

      //  var imageData = UIImagePNGRepresentation(thiscategoryitems[indexPathCatalogProduct!.row].itemimage)
        
        var ischecked = Bool()
        /*
        if shouldShowSearchResults == false {
            
        
        ischecked = thiscategoryitems[indexPathCatalogProduct!.row].itemischecked!
            
        } else if shouldShowSearchResults == true {
            
        ischecked = filteredcategoryitems[indexPathCatalogProduct!.row].itemischecked!

        }
        */
        
        
        
      //  if ischecked == false {
        
        pause()
        //basically duplicating the of an itemlist but with different list attached
        let shopItem = PFObject(className:"shopItems")
        
        let uuid = NSUUID().UUIDString
        let catalogitemuuid = "catalogitem\(uuid)"
            
             let date = NSDate()
            
            
            
            
            if self.shouldShowSearchResults == false {
                let itemId = catalogitemuuid
                
                let itemname = self.thiscategoryitems[indexPathCatalogProduct!.row].itemname
                let itemnote = ""
                let itemquantity = ""
                let itemprice = ""//0.0
                //var itemimage = imageFile
                let itemischecked = false
                let itemimagepath = ""//self.imagespaths[indexPathCatalogProduct!.row]//"Banana.png"//self.imagePath
                let itemunit = ""
                let itemimage2 = self.thiscategoryitems[indexPathCatalogProduct!.row].itemimage
                let itemcategory = self.currentcategory!.catId
                let itemiscatalog = true
                let originalincatalog = self.thiscategoryitems[indexPathCatalogProduct!.row].itemId
                
                let itemperunit = ""
                
                let categoryname = self.currentcategory!.catname
                
                let itemtotalprice = ""//0.0
                
                let thisitemisfav = false
                
                let isdefaultpict = false
                let originalindefaults = ""
                
                self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
            } else {
                let itemId = catalogitemuuid
                
                let itemname = self.filteredcategoryitems[indexPathCatalogProduct!.row].itemname
                let itemnote = ""
                let itemquantity = ""
                let itemprice = ""//0.0
                //var itemimage = imageFile
                let itemischecked = false
                let itemimagepath = ""//self.imagespaths[indexPathCatalogProduct!.row]//"Banana.png"//self.imagePath
                let itemunit = ""
                let itemperunit = ""
                let itemimage2 = self.filteredcategoryitems[indexPathCatalogProduct!.row].itemimage
                let itemcategory = self.currentcategory!.catId
                let itemiscatalog = true
                let originalincatalog = self.filteredcategoryitems[indexPathCatalogProduct!.row].itemId
                
                let categoryname = self.currentcategory!.catname
                let itemtotalprice = ""//0.0
                let thisitemisfav = false
                
                let isdefaultpict = false
                let originalindefaults = ""
                
                self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
            }
            
            HistoryitemsDataDict.append(self.dictionary)
            
            itemsDataDict.append(self.dictionary)
            
            shoppingcheckedtocopy.append(false)
        
            itemsorderarray.append(catalogitemuuid)

        
            self.restore()
    
            
            /// NOW PARSE PART
        
        shopItem["itemUUID"] = catalogitemuuid//thiscategoryitems[indexPathCatalogProduct!.row].itemId
        //shopItem["itemName"] = thiscategoryitems[indexPathCatalogProduct!.row].itemname
        shopItem["itemImage"] = NSNull()//productsImages[indexPathProduct!.row]
        shopItem["ItemsList"] = currentsubcataloglist
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = ""
        shopItem["itemQuantity"] = ""
        shopItem["itemPriceS"] = ""//0.0
        shopItem["TotalSumS"] = ""//0.0
        shopItem["chosenFromHistory"] = false
        shopItem["itemUnit"] = ""
        shopItem["isChecked"] = false
        shopItem["isCatalog"] = true
        shopItem["isFav"] = false
        shopItem["chosenFromFavs"] = false
        shopItem["perUnit"] = ""
        
        shopItem["defaultpicture"] = false
            shopItem["OriginalInDefaults"] = ""
       
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
        
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        
        if shouldShowSearchResults == false {
        
        shopItem["originalInCatalog"] = thiscategoryitems[indexPathCatalogProduct!.row].itemId
        shopItem["itemName"] = thiscategoryitems[indexPathCatalogProduct!.row].itemname
        //var imageData = UIImagePNGRepresentation(thiscategoryitems[indexPathCatalogProduct!.row].itemimage)
        //saveImageLocally(imageData)
        
        shopItem["imageLocalPath"] = ""//imagePath
        } else {
            shopItem["originalInCatalog"] = filteredcategoryitems[indexPathCatalogProduct!.row].itemId
            shopItem["itemName"] = filteredcategoryitems[indexPathCatalogProduct!.row].itemname
            //var imageData = UIImagePNGRepresentation(filteredcategoryitems[indexPathCatalogProduct!.row].itemimage)
            //saveImageLocally(imageData)
            
            shopItem["imageLocalPath"] = ""//imagePath
        }

        
        shopItem["Category"] = currentcategory?.catId
        
        print("saved item")
            
        // shopItem.pinInBackground()
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                //self.restore()
                print("saved item")

            } else {
                print("no id found")
            }
        })
        
        
        
        //shopItem.saveInBackgroundWithBlock {
        /*
        shopItem.saveEventually() {
            (success: Bool, error: NSError?) -> Void in
            if (success) {

                print("SAVE ALSO TO SERVER")
            } else {
                // There was a problem, check error.description
            }
        }
        */
       // cell.addinglabel.hidden = false
       // var checkimage = UIImage(named: "check.png") as UIImage!
       // cell.addbutton.setImage(checkimage, forState: UIControlState.Normal)
            
            if shouldShowSearchResults == false {
                
                thiscategoryitems[indexPathCatalogProduct!.row].itemischecked! = true
                
                
                
                
            } else if shouldShowSearchResults == true {
                
                filteredcategoryitems[indexPathCatalogProduct!.row].itemischecked! = true
                
                let catitemid = filteredcategoryitems[indexPathCatalogProduct!.row].itemId
                
                // if let founditem = find(lazy(thiscategoryitems).map({ $0.itemId }), catitemid) {
                   // let catalogitem = thiscategoryitems.append(catalogitems[founditem])
                
                if let founditem = thiscategoryitems.map({ $0.itemId }).indexOf(catitemid) {
                    thiscategoryitems[founditem].itemischecked! = true

                }
                /*
                cell.addinglabel.hidden = false
                var checkimage = UIImage(named: "CheckPath") as UIImage!
                cell.addbutton.setImage(checkimage, forState: UIControlState.Normal)
                
                cell.addbutton.enabled = false
                */
            }

        
        tableView.reloadData()
        
        
  //  } else {
    //if user unchecks the item
            
    //// I think this is unnecessary so far
            
            
    
    
   // }
    
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        finditems()
        
        navitem.title = currentcategory?.catname
    }
    
    
    var withoptionsdelegete : RefreshAddWithOptions?
    
    var shopdelegate : RefreshListDelegate?
    
    func DoneTapped(sender: UIButton) {
      
        
        shopdelegate?.refreshtable()
          performSegueWithIdentifier("backtolist", sender: self)
    }
    
    func EditTapped(sender: UIButton) {
         
        withoptionsdelegete?.refreshaddoptions()
        performSegueWithIdentifier("backtooptions", sender: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureCustomSearchController()
        
        
        let rightDoneItem: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("DoneButton", comment: "DoneButton"), style: UIBarButtonItemStyle.Plain, target: self, action: "DoneTapped:")
        
        rightDoneItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!, NSForegroundColorAttributeName: UIColorFromRGB(0xFAFAFA)], forState: UIControlState.Normal)
        
        let rightBackToOptionsItem: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("EditButton", comment: "EditButton"), style: UIBarButtonItemStyle.Plain, target: self, action: "EditTapped:")
         rightBackToOptionsItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!, NSForegroundColorAttributeName: UIColorFromRGB(0xE0FFB2)], forState: UIControlState.Normal)
        
        self.navigationItem.setRightBarButtonItems([rightDoneItem], animated: true)
        

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
        
        if shouldShowSearchResults {
            
            return filteredcategoryitems.count
            
        } else {
        return thiscategoryitems.count
        }
    }
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        addcatalogitembyselection(indexPath)
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subcatalogcell", forIndexPath: indexPath) as! SubCatalogCell
        
         cell.selectionStyle = UITableViewCellSelectionStyle.None

        // Configure the cell...
        
        if shouldShowSearchResults == false {
        //let cell = tableView.dequeueReusableCellWithIdentifier("subcatalogcell", forIndexPath: indexPath) as! SubCatalogCell
            
        cell.subcatalogimage.image = thiscategoryitems[indexPath.row].itemimage
        cell.subcatalogname.text = thiscategoryitems[indexPath.row].itemname
        
        
        //cell.addbutton.tag = indexPath.row
       // cell.addinglabel.hidden = true
        // cell.addbutton.addTarget(self, action: "addCatalogItemToTheList:", forControlEvents: .TouchUpInside)
        
            if thiscategoryitems[indexPath.row].itemischecked == true {
            
       // cell.addinglabel.hidden = false
        let checkimage = UIImage(named: "4CheckMark") as UIImage!
        cell.addbutton.setImage(checkimage, forState: UIControlState.Normal)
                
       // cell.addbutton.enabled = false
        } else {
       // cell.addinglabel.hidden = true
        let notcheckimage = UIImage(named: "4AddPlus") as UIImage!
        cell.addbutton.setImage(notcheckimage, forState: UIControlState.Normal)
       // cell.addbutton.enabled = true
        }
    
       // return cell
            
        } else {
            
           // let cell2 = tableView.dequeueReusableCellWithIdentifier("subcatalogcell", forIndexPath: indexPath) as! SubCatalogCell
            
            cell.subcatalogimage.image = filteredcategoryitems[indexPath.row].itemimage
            cell.subcatalogname.text = filteredcategoryitems[indexPath.row].itemname
            
            
           // cell.addbutton.tag = indexPath.row
            //cell.addinglabel.hidden = true
          //  cell.addbutton.addTarget(self, action: "addCatalogItemToTheList:", forControlEvents: .TouchUpInside)
            
            if filteredcategoryitems[indexPath.row].itemischecked == true {
                
               // cell.addinglabel.hidden = false
                let checkimage = UIImage(named: "CheckPath") as UIImage!
                cell.addbutton.setImage(checkimage, forState: UIControlState.Normal)
               // cell.addbutton.enabled = false
            } else {
               // cell.addinglabel.hidden = true
                let notcheckimage = UIImage(named: "BlackPlus") as UIImage!
                cell.addbutton.setImage(notcheckimage, forState: UIControlState.Normal)
               // cell.addbutton.enabled = true
            }

           // cell.addinglabel.hidden = true
           // var notcheckimage = UIImage(named: "BlackPlus") as UIImage!
           // cell.addbutton.setImage(notcheckimage, forState: UIControlState.Normal)
          //  return cell2
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
