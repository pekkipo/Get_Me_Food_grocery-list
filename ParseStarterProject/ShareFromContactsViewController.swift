//
//  ShareFromContactsViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 18/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ShareFromContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    ///share vars declaration
    
    var receiverUser = String()
    
    var receiveremail = String()
    
    //var newlistId: String?
     var newlistId = String()
   
    
    //listinfo part
    var shopListId = String()
    var shopListName = String()
    var shopListNote = String()
    var shopListBelongsTo = String()
    var shopListIsFavourite = Bool()
    var shopListIsReceived = Bool()
    var shopListShareWith = [String]()
    var shopListSentFrom = [String]()
    var shopListItemsIn = [String]()
    var shopListCreatedAt = NSDate()
    var shopListUpdatedAt = NSDate()
     var shopListIsSaved = Bool()
    
     var newShopListItemsIn = [String]()
    
    var thisListSharedWith = [[AnyObject]]()
    
    var ItemsCount = Int()
    var CheckedItemsCount  = Int()
    
    
    //items part

    var itemname = String()
    var itemnote = String()
    var itemimage = PFFile()
    var itemquantity = String()
    var itemlist = String()
    var itemprice = Double()
    var itemtotalsum = Double()
    var itembelongsto = String()
    var itemchosenfromhistory = Bool()
    var itemunit = String()
    
    var itemcategory = String()
    
    var itemLocalImagePath = String()
    var itemischecked = Bool()
    var itemiscatalog = Bool()
    var itemoriginal = String()
    
    var imagefromstore = UIImage()
    ///
     var successfulladd = Bool()
    
    var contactsarray = [[AnyObject]]()
    var contactsavatars = [PFFile]()
    var contactsnames = [String]()
    var contactsemails = [String]()
    
    var checkemail = []
    
   
    
    var emailexists = Bool()
    
    var listtoshare = String()
    
    var avatar = PFFile()
    
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
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

    
    func retrieveContactsList() {
        
        var contactquery:PFQuery = PFUser.query()!
        contactquery.fromLocalDatastore()
        contactquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        contactquery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                self.contactsarray.removeAll(keepCapacity: true)
                self.contactsnames.removeAll(keepCapacity: true)
                self.contactsemails.removeAll(keepCapacity: true)
                self.contactsavatars.removeAll(keepCapacity: true)
                
                if let users = objects as? [PFObject] {
                    for object in users {
                        print(object.objectId)
                        //self.contactsarray.append(object["UserContacts"] as! [[String : String]])
                        if object["UserContacts"] != nil {
                            self.contactsarray = (object["UserContacts"] as! [[AnyObject]]) //getting the contacts array
                            
                            print(self.contactsarray)
                            self.tableView.reloadData()

                            for element in self.contactsarray {

                                self.contactsnames.append(element[0] as! String)
                                self.contactsemails.append(element[1] as! String)
                                self.contactsavatars.append(element[2] as! PFFile)
                                
                                

                                //self.contactsavatars.append(element[2] as! UIImage)
                            }
                        } else {
                            print("no contacts so far")
                        }
                        print("my contacts emails are \(self.contactsemails)")
                        print("my contacts names are \(self.contactsnames)")
                        self.tableView.reloadData()
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    /*
    func checkexistance() {
        var query1:PFQuery = PFUser.query()!
        query1.whereKey("email", equalTo:self.contactsemail.text)
        self.checkemail = query1.findObjects()!
        
    }
    */
    
    func checkexistance() -> Bool {
        var query1:PFQuery = PFUser.query()!
        query1.whereKey("email", equalTo:self.contactsemail.text!)
        // self.checkemail = //query1.findObjects()!
       // var checkemailone : PFObject = query1.getFirstObject()!
        //if query1.isEqual(nil) {
        var checkemailone = query1.getFirstObject()
        //if query1.isEqual(nil) {
        if checkemailone == nil {
            emailexists = false
        } else {
            emailexists = true
        }
        // query1.getFirstObject()
        
        
        return emailexists
        
    }


    @IBOutlet weak var contactsemail: UITextField!
    
    @IBOutlet weak var contactsname: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    ///
    
    ///
    
    func getcontactavatar(usermail:String) -> PFFile {
    var contactquery:PFQuery = PFUser.query()!
    contactquery.whereKey("email", equalTo: usermail)//self.contactsemail.text)
    contactquery.findObjectsInBackgroundWithBlock {
    (objects: [AnyObject]?, error: NSError?) -> Void in
    if error == nil {
    print("Successfully retrieved \(objects!.count) scores.")
    // Do something with the found objects
    self.contactsavatars.removeAll(keepCapacity: true)
    if let users = objects as? [PFObject] {
    for object in users {
    
         self.avatar = object["Avatar"] as! PFFile
    
    }
    } else {
    print("no contacts so far")
    }

    
    } else {
    // Log details of the failure
    print("Error: \(error!) \(error!.userInfo)")
    }
    }
    return self.avatar
    }

    
    
    @IBAction func addnewcontact(sender: AnyObject) {
        
        pause()
        getcontactavatar(self.contactsname.text!)
        
        var query:PFQuery = PFUser.query()!
        query.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let thisuser = thisuser {
                self.checkexistance()
                if self.emailexists {
                    
                    self.contactsarray.append([(self.contactsname.text)!,(self.contactsemail.text)!, self.avatar])
                    thisuser["UserContacts"] = self.contactsarray
                    thisuser.pinInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            //self.restore()
                            print("saved user to local datastore")
                            //self.displayAlert("User added!", message: "Everything went fine!")
                            self.tableView.reloadData()
                        } else {
                            print("error")
                        }
                    })
                    
                    thisuser.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            
                            
                            self.restore()
                            print("saved user to server")
                            self.displayAlert("User added!", message: "Everything went fine!")
                            self.tableView.reloadData()
                            // self.displayAlert("User added!", message: "Everything went fine!")
                        } else {
                            print("error")
                        }
                    })
                } else {
                    self.restore()
                    print("no such user registered yet. We will send an invitation to this email")
                }
            }
        }
    }
    
    
    
    ////// Start of sharing part
    func gettingrequireduser(sender: UIButton!) -> String {
        //getting the user with typed email
        
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShareFromContactsCell
        let indexPathToShare = tableView.indexPathForCell(cell)
        
        print(indexPathToShare!.row)
        receiveremail = self.contactsemails[indexPathToShare!.row]

        let queryreceiver:PFQuery = PFUser.query()!//:PFQuery = PFUser.query()!
        queryreceiver.whereKey("email", equalTo: receiveremail)//name.text)
        queryreceiver.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                self.receiverUser = object!.objectId!
                
                self.getthelist(sender)
                print("receiver is \(self.receiverUser)")
            }
        }
        
        return self.receiverUser
        
    }
    
    func getthelist(sender: UIButton!) {//(listToShare: String, receiverUser: String) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShareFromContactsCell
        let indexPathToShare = tableView.indexPathForCell(cell)
        
        var querylist = PFQuery(className:"shopLists")
        
       // querylist.whereKey("objectId", equalTo: listtoshare)
        querylist.whereKey("listUUID", equalTo: listtoshare)
        querylist.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let listitems = objects as? [PFObject] {
                    
                    for object in listitems {
                        print(object.objectId)
                        
                        //self.shopListId = object.objectId!
                        self.shopListId = object["listUUID"] as! String
                        self.shopListName = object["ShopListName"] as! String
                        self.shopListNote = object["ShopListNote"] as! String
                        self.shopListIsFavourite = false //object["isFavourite"] as! Bool
                        self.shopListIsReceived = true
                        self.shopListSentFrom.append(PFUser.currentUser()!.objectId!)
                        self.shopListSentFrom.append(PFUser.currentUser()!.username!)
                        if PFUser.currentUser()!.email != nil {
                            self.shopListSentFrom.append(PFUser.currentUser()!.email!)
                        } else {
                            self.shopListSentFrom.append("default@default.com")
                            print("Anonoymous user, no email")
                        }
                        print(self.shopListSentFrom)
                        self.shopListItemsIn = object["ItemsInTheShopList"] as! [String]
                        self.shopListIsSaved = object["isSaved"] as! Bool
                        
                        self.thisListSharedWith = object["ShareWithArray"] as! [[AnyObject]]
                        
                        self.ItemsCount = object["ItemsCount"] as! Int
                        self.CheckedItemsCount = object["CheckedItemsCount"] as! Int
                        
                        self.shopListCreatedAt = object["creationDate"] as! NSDate
                        self.shopListUpdatedAt = object["updateDate"] as! NSDate
                        
                        print("bitches are \(self.shopListItemsIn)")
                        
                        print("bitches are 1 \(self.shopListItemsIn)")
                        //self.populatingthelist(self.shopListItemsIn)
                        
                        self.shopListBelongsTo = self.receiverUser
                        
                        //else {
                        //    println("No receiver so far")
                        // }
                        /*
                        self.listDictionary = ["name":self.shopListName,"name":self.shopListNote, "senderemail":(self.shopListSentFrom[0]), "sendername":(self.shopListSentFrom[1]), "belongsto":self.shopListBelongsTo]
                        
                        println(self.listDictionary)
                        */
                        //self.shop
                        //self.shopLis
                        
                        //  self.contactsnames.append(element[0])
                        //  self.contactsemails.append(element[1])
                        
                        object["isShared"] = true
                        // object["is"]
                        object["confirmReception"] = false
                        
                        var senddate = NSDate()
                        
                        self.newPFObjectList()
                        
                        // self.populatingthelist()
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "dd.MM.yyyy"
                        var date = dateFormatter.stringFromDate(senddate)
                        
                        var thisreceiveremail : String = cell.contactsemailintable.text!
                        
                        var thisreceivername : String = cell.contactsnameintable.text!
                        
                        self.thisListSharedWith.append([self.receiverUser, thisreceivername, thisreceiveremail, date, self.newlistId, false])
                        
                        print("Share with \(self.thisListSharedWith)")
                        
                        object["ShareWithArray"] = self.thisListSharedWith
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                print("Successfully saved to local store")
                            } else {
                                print("Wasn't save to localstore")
                            }
                        })
                        //shopList.saveInBackground()
                        object.saveEventually()

                        
                        
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        // self.newPFObjectList()
        
        
    }
    
    func newPFObjectList() {
        
         let listuuid = NSUUID().UUIDString
        
        
        //var listId: String?
        let shopListNew = PFObject(className:"shopLists")
        
        shopListNew["listUUID"] = listuuid
        shopListNew["ShopListName"] = self.shopListName
        shopListNew["ShopListNote"] = self.shopListNote
        //for user stuff
        shopListNew["BelongsToUser"] = self.shopListBelongsTo
        shopListNew["isReceived"] = self.shopListIsReceived
        shopListNew["isFavourite"] = false
        shopListNew["ShareWithArray"] = []
        shopListNew["sentFromArray"] = self.shopListSentFrom
        shopListNew["ItemsInTheShopList"] = self.shopListItemsIn
        shopListNew["isSaved"] = self.shopListIsSaved
        
        shopListNew["isShared"] = false
        shopListNew["confirmReception"] = false
        shopListNew["isDeleted"] = false
        
        
        shopListNew["ItemsCount"] = self.ItemsCount
        shopListNew["CheckedItemsCount"] = self.CheckedItemsCount
        
        let today = NSDate()
        
        shopListNew["creationDate"] = today//self.shopListCreatedAt
        shopListNew["updateDate"] = today//self.shopListUpdatedAt
        
        //getting the right to edit the row in DB
        let acl = PFACL()
        acl.setPublicReadAccess(true)
        acl.setPublicWriteAccess(true)
        shopListNew.ACL = acl
        /*
        var shopListId = String()
        var shopListName = String()
        var shopListNote = String()
        var shopListBelongsTo = String()
        var shopListIsFavourite = Bool()
        var shopListIsReceived = Bool()
        var shopListShareWith = [String]()
        var shopListSentFrom = [String]()
        var shopListItemsIn = [String]()
        var shopListCreatedAt = [NSDate]()
        var shopListUpdatedAt = [NSDate]()
        */
        
        //shopList["ItemsInTheShopList"] = shoppingListItemsIds
        
        
        self.newlistId = listuuid
        
        print("New list Id is \(self.newlistId)")
        print("here array is \(self.shopListItemsIn)")
        
        shopListNew.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                //self.currentList = shopListNew.objectId!
                //self.trycurrent = shopListNew.objectId!
                // println("Current list is \(self.currentList)")
                //self.populatingthelist(self.shopListItemsIn)
               // self.newlistId = shopListNew.objectId!
                print("New list Id is \(self.newlistId)")
                print("here array is \(self.shopListItemsIn)")
                self.populatingthelist(self.shopListItemsIn)
                print("The list is sent!")
                
                 self.restore()
                
                
                // DISPLAY ALERT OF SAVING
            } else {
                // There was a problem, check error.description
                print("Didnt send")
                self.restore()
                self.displayAlert("List was not sent!", message: "Maybe problem in the internet connection")
            }
            
            //println("Current list is \(self.currentList)")
        }
        
        // self.currentList = trycurrent
        
    }
    
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
                self.imagefromstore = image!
                return imagefromstore
            }
        }
        
        return UIImage(named: "activity.png")!
    }
    */
    
    func populatingthelist(shopListItemsIn1: [String]) -> [String] { //BITCH DOESNT WORK!
        
        //get all itmes first
        /*
        var itemname = [String]()
        var itemnote = [String]()
        var itemimage = [PFFile]()
        var itemquantity = [String]()
        var itemlist = [String]()
        var itemprice = [Double]()
        var itemtotalsum = [Double]()
        var itembelongsto = [String]()
        var itemschosenfromhistory = [Bool]()
        */
        //for (index, listitem) in enumerate(shopListItemsIn)
        for var index = 0; index < shopListItemsIn.count; index++ {
            var queryitem = PFQuery(className:"shopItems")
            queryitem.fromLocalDatastore() //maybe!
           // queryitem.whereKey("objectId", equalTo: shopListItemsIn1[index])
            queryitem.whereKey("itemUUID", equalTo: shopListItemsIn1[index])
            queryitem.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    /* self.itemname.removeAll(keepCapacity: true)
                    self.itemnote.removeAll(keepCapacity: true)
                    self.itemimage.removeAll(keepCapacity: true)
                    self.itemquantity.removeAll(keepCapacity: true)
                    self.itemlist.removeAll(keepCapacity: true)
                    self.itemprice.removeAll(keepCapacity: true)
                    self.itemtotalsum.removeAll(keepCapacity: true)
                    self.itembelongsto.removeAll(keepCapacity: true)
                    self.itemchosenfromhistory.removeAll(keepCapacity: true)
                    
                    */
                    
                    if let listitems = objects as? [PFObject] {
                        
                        for object in listitems {
                            print(object.objectId)
                            //getting all the info about an item
                            self.itemname = object["itemName"] as! String
                            self.itemnote = object["itemNote"] as! String
                            
                            
                            
                            self.itemLocalImagePath = object["imageLocalPath"] as! String
                            
                            self.loadImageFromLocalStore(self.itemLocalImagePath)
                            //so, I got the image
                            
                            
                            /////!!! MYABE I NEED THIS, of course a bit before ////
                            if object["isCatalog"] as! Bool == false {
                                self.itemLocalImagePath = object["imageLocalPath"] as! String
                                
                                self.loadImageFromLocalStore(self.itemLocalImagePath)
                                
                                // self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                
                                //  self.shoppingListItemsImages2.append(self.imageToLoad)
                            } else {
                                //if catalog item
                                //self.shoppingListItemsImages2.append(
                              //  if let founditem = find(lazy(catalogitems).map({ $0.itemId }), (object["originalInCatalog"] as! String)) {
                                
                                 if let founditem = catalogitems.map({ $0.itemId }).lazy.indexOf((object["originalInCatalog"] as! String)) {
                                
                                    let catalogitem = catalogitems[founditem]
                                    
                                    self.imagefromstore = catalogitem.itemimage
                                    
                                    
                                }
                            }
                            /////////
                            
                           
                            self.itemquantity = object["itemQuantity"] as! String
                            self.itemlist = object["ItemsList"] as! String
                            self.itemprice = object["itemPrice"] as! Double
                            self.itemtotalsum = object["TotalSum"] as! Double
                            self.itembelongsto = self.receiverUser//object["belongsToUser"] as! String
                            self.itemchosenfromhistory = true// if want to add to history received items, use this --> object["chosenFromHistory"] as! Bool
                             self.itemunit = object["itemUnit"] as! String
                            
                            self.itemcategory = object["Category"] as! String
                            
                            self.itemischecked = object["isChecked"] as! Bool
                            
                            self.itemiscatalog = object["isCatalog"] as! Bool
                            
                            self.itemoriginal = object["originalInCatalog"] as! String
                            
                            
                            
                            print("Check names and notes, they equal to: \(self.itemname) and \(self.itemnote)")
                            
                            
                            //now create new PFObject
                            
                            //var listId: String?
                            var shopItemNew = PFObject(className:"shopItems")
                            
                            var itemuuid = NSUUID().UUIDString
                            
                            shopItemNew["itemUUID"] = itemuuid
                            
                            shopItemNew["itemName"] = self.itemname
                            shopItemNew["itemNote"] = self.itemnote
                            
                            
                            var imageData = UIImagePNGRepresentation(self.imagefromstore)
                            var imageFile = PFFile(name:"ReceivedItemImage.png", data:imageData)
                            
                            shopItemNew["itemImage"] = imageFile
                            shopItemNew["itemQuantity"] = self.itemquantity
                            shopItemNew["ItemsList"] = self.newlistId
                            shopItemNew["itemPrice"] = self.itemprice
                            shopItemNew["TotalSum"] = self.itemtotalsum
                            shopItemNew["belongsToUser"] = self.itembelongsto
                            shopItemNew["chosenFromHistory"] = self.itemchosenfromhistory
                            shopItemNew["itemUnit"] = self.itemunit
                            shopItemNew["isChecked"] = self.itemischecked
                            shopItemNew["isCatalog"] = self.itemiscatalog
                            shopItemNew["Category"] = self.itemcategory
                            shopItemNew["originalInCatalog"] = self.itemoriginal
                            
                             shopItemNew["isFav"] = false
                            
                             shopItemNew["chosenFromFavs"] = false
                            
                            if (self.itemcategory as NSString).containsString("custom") {
                                shopItemNew["Category"] = "DefaultOthers"
                               // shopItemNew["isCatalog"] = false
                            } else {
                                shopItemNew["Category"] = self.itemcategory
                                //shopItemNew["isCatalog"] = self.itemiscatalog
                            }
                            
                            //getting the right to edit the row in DB
                            let acl = PFACL()
                            acl.setPublicReadAccess(true)
                            acl.setPublicWriteAccess(true)
                            shopItemNew.ACL = acl
                            
                            shopItemNew.saveInBackgroundWithBlock {
                                (success: Bool, error: NSError?) -> Void in
                                if (success) {
                                    //self.currentList = shopListNew.objectId!
                                    //self.trycurrent = shopListNew.objectId!
                                    // println("Current list is \(self.currentList)")
                                    
                                    //self.newShopListItemsIn.append(shopItemNew.objectId!)
                                    self.newShopListItemsIn.append(itemuuid)
                                    print("New list comprises the following items \(self.newShopListItemsIn)")
                                    
                                    print("Array before adding is \(self.newShopListItemsIn)")
                                    
                                    self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
                                    
                                    //println("The item \(shopItemNew.objectId) added to the new list!")
                                     print("The item \(itemuuid) added to the new list!")
                                    // DISPLAY ALERT OF SAVING
                                } else {
                                    // There was a problem, check error.description
                                    print("Didnt add the item")
                                }
                                
                                //println("Current list is \(self.currentList)")
                            }
                            
                            // self.currentList = trycurrent
                            
                        }
                        
                        /////
                        
                        
                    }
                    
                } else {
                    // Log details of the failure
                    println("Error: \(error!) \(error!.userInfo)")
                    print("BITCH DOESNT WORK")
                }
            }
            
        } //end of for loop
        
        ////
        return newShopListItemsIn
    }
    
    func additemstocreatedlistsarray(listid: String, itemsarray: [String]) -> Bool {
        
        
        
        let query = PFQuery(className:"shopLists")
        // query.getObjectInBackgroundWithId(newlistId) {
       // query.getObjectInBackgroundWithId(listid) {
        query.whereKey("listUUID", equalTo: listid)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query.getFirstObjectInBackgroundWithBlock() {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let shopList = shopList {
                shopList["ItemsInTheShopList"] = itemsarray//self.newShopListItemsIn
                
                // self.additemstolistsarray()
                
                //shopList.setObject(self.shoppingListItemsIds, forKey: "ItemsInTheShopList")
                
                //shopList["ItemsInTheShopList"] = self.shoppingListItemsIds
                //shopList.pinInBackground()
                //shopList.saveInBackground()
                //shopList.saveEventually()
                shopList.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        self.successfulladd = true
                        // The object has been saved.
                        print("Items array was saved!")
                        self.displayAlert("List sent!", message: "The list was sent successfully. Check the delivery in sharing history")
                    } else {
                        self.successfulladd = false
                        print("Wasn't saved")
                        // There was a problem, check error.description
                    }
                }
            }
        }
        
        return successfulladd
    }

    
    
    ////// End of sharing part
    
    
    
    override func viewDidAppear(animated: Bool) {
        retrieveContactsList()
        
        print(self.contactsarray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        retrieveContactsList()
        
        print("Number of entries \(self.contactsarray.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return ((ListsNames.count) - (ListsNames.count - 4))
        return contactsemails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "ShareFromContactsCell"
        let contactcell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ShareFromContactsCell
        
        
        contactcell.contactsnameintable.text = contactsnames[indexPath.row]
        contactcell.contactsemailintable.text = contactsemails[indexPath.row]
        
        contactcell.shareintable.addTarget(self, action: "gettingrequireduser:", forControlEvents: .TouchUpInside)
        
        /*
        contactsavatars[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                contactcell.contactsavatarintable.image = downloadedImage
            }
            
        }
    */
        contactsarray[indexPath.row][2].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                contactcell.contactsavatarintable.image = downloadedImage
            }
            
        }

        
        return contactcell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        
    }


}
