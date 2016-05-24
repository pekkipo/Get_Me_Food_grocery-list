//
//  TableViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 24/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
//import Foundation

class TableViewController: UITableViewController {
    
    /*
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let activitylabel: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .Light)
    let vibrancyView: UIVisualEffectView
    //for this stuff probably I need this
    required init(coder aDecoder: NSCoder) {
        
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(coder: aDecoder)
       
        
    }
    */
    
    
    
    /////TRANSITION STUFF
    /*
    @IBAction func presentNavigation(sender: AnyObject?){
        performSegueWithIdentifier("presentNav", sender: self)
    }
    */
    
   
    
   // var transitionOperator = TransitionOperator()
    
    /*
    @IBAction func presentNavigation(sender: AnyObject?){
        performSegueWithIdentifier("presentNav", sender: self)
    }
    */
    
    
    
    
    
    ///////////NAVIGATION
    
    @IBAction func MenuBar(sender: AnyObject) {
        
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func FavsBar(sender: AnyObject) {
    }
    
    
    @IBAction func AddBar(sender: AnyObject) {
    }
    
    
    
    ///////////// END NAVIGATION
    
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /////
    
    var lists = [Dictionary<String, AnyObject>]()
    
    var ShowFavourites = Bool()
    
    
    var ListsIds = [String]()
    var ListsNames = [String]()
    var ListsNotes = [String]()
    
    //new stuff
    var ListsCreationDates = [NSDate]()
    var ListsIsFavourite = [Bool]()
    //var ListsSharedWith = [String]()
    var ListsSharedWith = [[String]]()
    //var ListsSharedWithArray = [[String]]() //Multidimensional array.    //1st - sender, 2nd - receiver, dont use i
    
    
    var ListsConfirm = [Bool]()
    var ListsIsDeleted = [Bool]()
    var ListsIsShared = [Bool]()
    var ListsShareWith = [[AnyObject]]()
    
    var ListsItemsCount = [Int]()
    var ListsItemsCheckedCount = [Int]()
    
    //var ListsBelongsToUsers = [[String]]()
    
    var ListsBelongsToUser = [String]()
    
    var ListsIsReceived = [Bool]()
    
    var ListsReceivedFrom = [[String]]()
    
    var ListsIsSaved = [Bool]()
    
    var imagePath = String()
    
    //var ListsReceivedFromNames = [String]()

    var listtodelete: String?
    var listtofav: String?
    
    var listfromfav: String?
    
    var listtoshare: String?
    
    var listtosharetype = String()
    
    var listtosave: String?
    
    var favimage: UIImage = UIImage()
    var notfavimage: UIImage = UIImage()
    
    
    var ItemsInReceivedList = [String]()
    
    var ListsType = [String]()
    
   // var isFavouriteNow = false
    
    
   // var MyButton: UIButton = UIButton()
   // var button : UIButton
    /*
    var elements = [1,2,3,4,5]
    if contains(elements, 5) {
    println("yes")
    }
    
    
    
*/
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
     let progressHUD = ProgressHUD(text: "Getting the lists")
    
    func pause() {
        
       
        self.view.addSubview(progressHUD)
        
        progressHUD.setup()
        progressHUD.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func restore() {
        
        progressHUD.hide()
       
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }

    
    
    @IBAction func item(sender: UIBarButtonItem) {
        
        self.ListsIds.removeAll(keepCapacity: true)
        self.ListsNames.removeAll(keepCapacity: true)
        self.ListsNotes.removeAll(keepCapacity: true)
        //
        self.ListsCreationDates.removeAll(keepCapacity: true)
        self.ListsIsFavourite.removeAll(keepCapacity: true)
        self.ListsIsReceived.removeAll(keepCapacity: true)
        // self.ListsSharedWith.removeAll(keepCapacity: true)
        //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
        self.ListsBelongsToUser.removeAll(keepCapacity: true)
        self.ListsReceivedFrom.removeAll(keepCapacity: true)
        self.ListsIsSaved.removeAll(keepCapacity: true)
        self.ListsShareWith.removeAll(keepCapacity: true)
        self.ListsItemsCount.removeAll(keepCapacity: true)
        self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
        self.ListsType.removeAll(keepCapacity: true)
        
        pause()
        
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.orderByDescending("updateDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        println(object.objectId)
                        //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        self.ListsIds.append(object["listUUID"] as! String)
                        self.ListsNames.append(object["ToDoListName"] as! String)
                        self.ListsNotes.append(object["ToDoListNote"] as! String)
                        
                        //
                        //self.ListsCreationDates.append(object.updatedAt!)
                        self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                        self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                        self.ListsIsReceived.append(object["isReceived"] as! Bool)
                        //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                        //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                        self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                        self.ListsReceivedFrom.append(object["SentFromArray"] as! [(String)])
                        self.ListsIsSaved.append(object["isSaved"] as! Bool)
                        
                        self.ListsConfirm.append(object["confirmReception"] as! Bool)
                        self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                        self.ListsIsShared.append(object["isShared"] as! Bool)
                        self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                        
                        self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                        self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                        
                        var todotype : String = "ToDo"
                        
                        self.ListsType.append(todotype)
                        
                        //self.ListsType.append("ToDo")
                        
                        self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                }
                
                self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        tableView.reloadData()
    }
    
 
    
    
    /*
    @IBAction func showalllists(sender: AnyObject) {
        
        listsretrieval()
        tableView.reloadData()
    }
    
    
    @IBAction func showonlyshoplists(sender: AnyObject) {
        
        self.ListsIds.removeAll(keepCapacity: true)
        self.ListsNames.removeAll(keepCapacity: true)
        self.ListsNotes.removeAll(keepCapacity: true)
        //
        self.ListsCreationDates.removeAll(keepCapacity: true)
        self.ListsIsFavourite.removeAll(keepCapacity: true)
        self.ListsIsReceived.removeAll(keepCapacity: true)
        // self.ListsSharedWith.removeAll(keepCapacity: true)
        //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
        self.ListsBelongsToUser.removeAll(keepCapacity: true)
        self.ListsReceivedFrom.removeAll(keepCapacity: true)
        self.ListsIsSaved.removeAll(keepCapacity: true)
        self.ListsShareWith.removeAll(keepCapacity: true)
        self.ListsItemsCount.removeAll(keepCapacity: true)
        self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
        self.ListsType.removeAll(keepCapacity: true)
        
        
        
        pause()
        // var userquery = PF
        var query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
        query.orderByDescending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")

                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        println(object.objectId)
                        //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        self.ListsIds.append(object["listUUID"] as! String)
                        self.ListsNames.append(object["ShopListName"] as! String)
                        self.ListsNotes.append(object["ShopListNote"] as! String)
                        
                        //
                        //self.ListsCreationDates.append(object.updatedAt!)
                        self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                        self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                        self.ListsIsReceived.append(object["isReceived"] as! Bool)
                        //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                        //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                        self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                        self.ListsReceivedFrom.append(object["sentFromArray"] as! [(String)])
                        self.ListsIsSaved.append(object["isSaved"] as! Bool)
                        
                        self.ListsConfirm.append(object["confirmReception"] as! Bool)
                        self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                        self.ListsIsShared.append(object["isShared"] as! Bool)
                        self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                        
                        self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                        self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                        
                        var type : String = "Shop"
                        
                        self.ListsType.append(type)
                        
                        //self.ListsType.append("Shop")
                        
                        self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                }
                
                self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func showonlytodolists(sender: AnyObject) {
        
        
        self.ListsIds.removeAll(keepCapacity: true)
        self.ListsNames.removeAll(keepCapacity: true)
        self.ListsNotes.removeAll(keepCapacity: true)
        //
        self.ListsCreationDates.removeAll(keepCapacity: true)
        self.ListsIsFavourite.removeAll(keepCapacity: true)
        self.ListsIsReceived.removeAll(keepCapacity: true)
        // self.ListsSharedWith.removeAll(keepCapacity: true)
        //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
        self.ListsBelongsToUser.removeAll(keepCapacity: true)
        self.ListsReceivedFrom.removeAll(keepCapacity: true)
        self.ListsIsSaved.removeAll(keepCapacity: true)
        self.ListsShareWith.removeAll(keepCapacity: true)
        self.ListsItemsCount.removeAll(keepCapacity: true)
        self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
        self.ListsType.removeAll(keepCapacity: true)
        
        pause()
        
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.orderByDescending("updateDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        println(object.objectId)
                        //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        self.ListsIds.append(object["listUUID"] as! String)
                        self.ListsNames.append(object["ToDoListName"] as! String)
                        self.ListsNotes.append(object["ToDoListNote"] as! String)
                        
                        //
                        //self.ListsCreationDates.append(object.updatedAt!)
                        self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                        self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                        self.ListsIsReceived.append(object["isReceived"] as! Bool)
                        //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                        //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                        self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                        self.ListsReceivedFrom.append(object["SentFromArray"] as! [(String)])
                        self.ListsIsSaved.append(object["isSaved"] as! Bool)
                        
                        self.ListsConfirm.append(object["confirmReception"] as! Bool)
                        self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                        self.ListsIsShared.append(object["isShared"] as! Bool)
                        self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                        
                        self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                        self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                        
                        var todotype : String = "ToDo"
                        
                        self.ListsType.append(todotype)
                        
                        //self.ListsType.append("ToDo")
                        
                        self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                }
                
                self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        tableView.reloadData()
        
    }

*/
    
    /* USE THIS LATER FOR SYNCHRONIZATION
    func listsretrievalfromcloud() {
        
        // var userquery = PF
        var query = PFQuery(className:"shopLists")
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
        //query.orderByDescending("createdAt")
        query.orderByDescending("creationDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                /*
                self.ListsIds.removeAll(keepCapacity: true)
                self.ListsNames.removeAll(keepCapacity: true)
                self.ListsNotes.removeAll(keepCapacity: true)
                //
                self.ListsCreationDates.removeAll(keepCapacity: true)
                self.ListsIsFavourite.removeAll(keepCapacity: true)
                self.ListsIsReceived.removeAll(keepCapacity: true)
                self.ListsSharedWith.removeAll(keepCapacity: true)
                //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
                self.ListsBelongsToUser.removeAll(keepCapacity: true)
                self.ListsReceivedFrom.removeAll(keepCapacity: true)
                */
                
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        println(object.objectId)
                        
                       // if contains(self.ListsIds, object.objectId!) {
                        if contains(self.ListsIds, object["listUUID"] as! String) {
                        
                            println("object is already retrieved from local datastore")
                        } else {
                            
                           // self.ListsIds.append(object.objectId!)//["itemName"] as)
                            self.ListsIds.append(object["listUUID"] as! String)
                            self.ListsNames.append(object["ShopListName"] as! String)
                            self.ListsNotes.append(object["ShopListNote"] as! String)
                            
                            //
                            //self.ListsCreationDates.append(object.updatedAt!)
                            self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                            self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                            self.ListsIsReceived.append(object["isReceived"] as! Bool)
                            //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                            //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                            self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                            self.ListsReceivedFrom.append(object["sentFromArray"] as! [(String)])
                            self.ListsIsSaved.append(object["isSaved"] as! Bool)
                            
                            self.ListsConfirm.append(object["confirmReception"] as! Bool)
                            self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                            self.ListsIsShared.append(object["isShared"] as! Bool)
                            self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                            
                            self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                            self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                            
                            self.ListsType.append("Shop")
                            
                            self.tableView.reloadData() // without this thing, table would contain only 1 row
                            
                                                    
                        }
                        
                        object.pinInBackground()
                    }
                    
                    
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }
    */
    
    
    func checkreceivedlists() {
        
        /*
        var receivedcount : Int {
            
            get{return 0}
            set{0}
            
            
        }
        */
        
        var receivedcount : Int = 0
        
        //CHECK SHOP LISTS
        var query = PFQuery(className:"shopLists")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isReceived", equalTo: true)
        query.whereKey("isSaved", equalTo: false)
        query.whereKey("isDeleted", equalTo: false)
        query.whereKey("confirmReception", equalTo: false)
        query.orderByDescending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                
                if let lists = objects as? [PFObject] {
                    
                    for object in lists {
                        println(object.objectId)
                        if contains(self.ListsIds, object["listUUID"] as! String) {
                            
                            println("object is already retrieved from local datastore")
                        } else {
                            
                            self.ListsIds.append(object["listUUID"] as! String)
                            self.ListsNames.append(object["ShopListName"] as! String)
                            self.ListsNotes.append(object["ShopListNote"] as! String)

                            self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                            self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                            self.ListsIsReceived.append(object["isReceived"] as! Bool)

                            self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                            self.ListsReceivedFrom.append(object["sentFromArray"] as! [(String)])
                            self.ListsIsSaved.append(object["isSaved"] as! Bool)
                            
                            self.ListsConfirm.append(object["confirmReception"] as! Bool)
                            self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                            self.ListsIsShared.append(object["isShared"] as! Bool)
                            self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                            
                            self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                            self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                            
                            var type : String = "Shop"
                            
                            self.ListsType.append(type)
                            
                            self.tableView.reloadData() // without this thing, table would contain only 1 row
                            
                            receivedcount += 1
                            
                        }
                        
                        //receivedcount += 1
                        
                        //object.pinInBackground()
                        //I think I do it later when saving
                    }
                    
                    
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        
        
        //CHECK TODO LISTS
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.whereKey("isReceived", equalTo: true)
        querytodo.whereKey("isSaved", equalTo: false)
        querytodo.whereKey("isDeleted", equalTo: false)
        querytodo.whereKey("confirmReception", equalTo: false)
        querytodo.orderByDescending("updateDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                
                if let lists = objects as? [PFObject] {
                    
                    for object in lists {
                        println(object.objectId)
                        if contains(self.ListsIds, object["listUUID"] as! String) {
                            
                            println("object is already retrieved from local datastore")
                        } else {
                            
                            self.ListsIds.append(object["listUUID"] as! String)
                            self.ListsNames.append(object["ShopListName"] as! String)
                            self.ListsNotes.append(object["ShopListNote"] as! String)
                            
                            self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                            self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                            self.ListsIsReceived.append(object["isReceived"] as! Bool)
                            
                            self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                            self.ListsReceivedFrom.append(object["SentFromArray"] as! [(String)])
                            self.ListsIsSaved.append(object["isSaved"] as! Bool)
                            
                            self.ListsConfirm.append(object["confirmReception"] as! Bool)
                            self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                            self.ListsIsShared.append(object["isShared"] as! Bool)
                            self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                            
                            self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                            self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                            
                            var todotype : String = "ToDo"
                            
                            self.ListsType.append(todotype)
                            
                          //  self.ListsType.append("ToDo")
                            
                            self.tableView.reloadData() // without this thing, table would contain only 1 row
                            
                            receivedcount += 1
                        }
                       // receivedcount += 1
                        //object.pinInBackground()
                    }
                    
                    if receivedcount != 0 {
                    
                    self.displayAlert("Incoming lists!", message: "You have received \(String(receivedcount)) lists")
                    }
                    //self.displayAlert("Incoming lists!", message: "You have received lists")
                    
                    
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }

    
    
    func listsretrieval() {
        
        self.ListsIds.removeAll(keepCapacity: true)
        self.ListsNames.removeAll(keepCapacity: true)
        self.ListsNotes.removeAll(keepCapacity: true)
        //
        self.ListsCreationDates.removeAll(keepCapacity: true)
        self.ListsIsFavourite.removeAll(keepCapacity: true)
        self.ListsIsReceived.removeAll(keepCapacity: true)
        // self.ListsSharedWith.removeAll(keepCapacity: true)
        //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
        self.ListsBelongsToUser.removeAll(keepCapacity: true)
        self.ListsReceivedFrom.removeAll(keepCapacity: true)
        self.ListsIsSaved.removeAll(keepCapacity: true)
        self.ListsShareWith.removeAll(keepCapacity: true)
        self.ListsItemsCount.removeAll(keepCapacity: true)
        self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
        self.ListsType.removeAll(keepCapacity: true)

        
        
        pause()
       // var userquery = PF
        var query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
       // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
            query.orderByDescending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                /*
                self.ListsIds.removeAll(keepCapacity: true)
                self.ListsNames.removeAll(keepCapacity: true)
                self.ListsNotes.removeAll(keepCapacity: true)
                //
                self.ListsCreationDates.removeAll(keepCapacity: true)
                self.ListsIsFavourite.removeAll(keepCapacity: true)
                self.ListsIsReceived.removeAll(keepCapacity: true)
               // self.ListsSharedWith.removeAll(keepCapacity: true)
                //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
                self.ListsBelongsToUser.removeAll(keepCapacity: true)
                self.ListsReceivedFrom.removeAll(keepCapacity: true)
                self.ListsIsSaved.removeAll(keepCapacity: true)
                self.ListsShareWith.removeAll(keepCapacity: true)
                self.ListsItemsCount.removeAll(keepCapacity: true)
                self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
                self.ListsType.removeAll(keepCapacity: true)
                */
                
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        println(object.objectId)
                      //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        self.ListsIds.append(object["listUUID"] as! String)
                        self.ListsNames.append(object["ShopListName"] as! String)
                        self.ListsNotes.append(object["ShopListNote"] as! String)
                        
                        //
                        //self.ListsCreationDates.append(object.updatedAt!)
                         self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                        self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                        self.ListsIsReceived.append(object["isReceived"] as! Bool)
                        //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                        //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                        self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                        self.ListsReceivedFrom.append(object["sentFromArray"] as! [(String)])
                         self.ListsIsSaved.append(object["isSaved"] as! Bool)
                        
                        self.ListsConfirm.append(object["confirmReception"] as! Bool)
                        self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                        self.ListsIsShared.append(object["isShared"] as! Bool)
                        self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                        
                        self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                        self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                        
                        var type : String = "Shop"
                        
                        self.ListsType.append(type)
                        
                       // self.ListsType.append("Shop")
                        
                       self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                }
                 println("TYPES ARE \(self.ListsType)")
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        ////// NOW TODOLISTSPART
        
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.orderByDescending("updateDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        println(object.objectId)
                        //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        self.ListsIds.append(object["listUUID"] as! String)
                        self.ListsNames.append(object["ToDoListName"] as! String)
                        self.ListsNotes.append(object["ToDoListNote"] as! String)
                        
                        //
                        //self.ListsCreationDates.append(object.updatedAt!)
                        self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                        self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                        self.ListsIsReceived.append(object["isReceived"] as! Bool)
                        //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                        //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                        self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                        self.ListsReceivedFrom.append(object["SentFromArray"] as! [(String)])
                        self.ListsIsSaved.append(object["isSaved"] as! Bool)
                        
                        self.ListsConfirm.append(object["confirmReception"] as! Bool)
                        self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                        self.ListsIsShared.append(object["isShared"] as! Bool)
                        self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                        
                        self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                        self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                        
                        var todotype : String = "ToDo"
                        
                        self.ListsType.append(todotype)
                        
                        //self.ListsType.append("ToDo")
                        
                        self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                }
                println("TYPES ARE \(self.ListsType)")
                self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        
        //println("TYPES ARE \(ListsType)")
    }
    
    
    func sortArray() {
        var sortedarray = ListsIds.reverse()
        
        for (index, element) in enumerate(sortedarray) {
           ListsIds[index] = element
        }
        
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    
    func getsenderuser() {
        
    }
 
    
    func SettingsItemTapped(sender:UIButton) {
        println("Settings pressed")
        performSegueWithIdentifier("OpenSettingsFromYourLists", sender: self)
    }
    
    func FavItemTapped(sender: UIButton) {
        
        if ShowFavourites == false {
            //it solved the problem
            self.ListsIds.removeAll(keepCapacity: true)
            self.ListsNames.removeAll(keepCapacity: true)
            self.ListsNotes.removeAll(keepCapacity: true)
            //
            self.ListsCreationDates.removeAll(keepCapacity: true)
            self.ListsIsFavourite.removeAll(keepCapacity: true)
            self.ListsIsReceived.removeAll(keepCapacity: true)
            // self.ListsSharedWith.removeAll(keepCapacity: true)
            //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
            self.ListsBelongsToUser.removeAll(keepCapacity: true)
            self.ListsReceivedFrom.removeAll(keepCapacity: true)
            self.ListsIsSaved.removeAll(keepCapacity: true)
            self.ListsShareWith.removeAll(keepCapacity: true)
            self.ListsItemsCount.removeAll(keepCapacity: true)
            self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
            tableView.reloadData()
            
            pause()
            var query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
            query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
            // query.whereKey("BelongsToUsers", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("isFavourite", equalTo: true)
            query.orderByDescending("updatedAt")
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    println("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    /*
                    self.ListsIds.removeAll(keepCapacity: true)
                    self.ListsNames.removeAll(keepCapacity: true)
                    self.ListsNotes.removeAll(keepCapacity: true)
                    //
                    self.ListsCreationDates.removeAll(keepCapacity: true)
                    self.ListsIsFavourite.removeAll(keepCapacity: true)
                    self.ListsIsReceived.removeAll(keepCapacity: true)
                    // self.ListsSharedWith.removeAll(keepCapacity: true)
                    //self.ListsBelongsToUsers.removeAll(keepCapacity: true)
                    self.ListsBelongsToUser.removeAll(keepCapacity: true)
                    self.ListsReceivedFrom.removeAll(keepCapacity: true)
                    self.ListsIsSaved.removeAll(keepCapacity: true)
                    self.ListsShareWith.removeAll(keepCapacity: true)
                    self.ListsItemsCount.removeAll(keepCapacity: true)
                    self.ListsItemsCheckedCount.removeAll(keepCapacity: true)
                    */
                    
                    
                    
                    if let lists = objects as? [PFObject] {
                        
                        //shoppingListItemsIds.removeAll(keepCapacity: true)
                        
                        for object in lists {
                            println(object.objectId)
                            //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                            self.ListsIds.append(object["listUUID"] as! String)
                            self.ListsNames.append(object["ShopListName"] as! String)
                            self.ListsNotes.append(object["ShopListNote"] as! String)
                            
                            //
                           // self.ListsCreationDates.append(object.updatedAt!)
                             self.ListsCreationDates.append(object["updateDate"] as! NSDate)
                            self.ListsIsFavourite.append(object["isFavourite"] as! Bool)
                            self.ListsIsReceived.append(object["isReceived"] as! Bool)
                            //self.ListsSharedWith.append(object["ShareWithArray"] as! [(String)])
                            //self.ListsBelongsToUsers.append(object["BelongsToUsers"] as! [(String)])
                            self.ListsBelongsToUser.append(object["BelongsToUser"] as! String)
                            self.ListsReceivedFrom.append(object["sentFromArray"] as! [(String)])
                            self.ListsIsSaved.append(object["isSaved"] as! Bool)
                            
                            self.ListsConfirm.append(object["confirmReception"] as! Bool)
                            self.ListsIsDeleted.append(object["isDeleted"] as! Bool)
                            self.ListsIsShared.append(object["isShared"] as! Bool)
                            self.ListsShareWith.append(object["ShareWithArray"] as! [[AnyObject]])
                            
                            self.ListsItemsCount.append(object["ItemsCount"] as! Int)
                            self.ListsItemsCheckedCount.append(object["CheckedItemsCount"] as! Int)
                            
                            self.tableView.reloadData() // without this thing, table would contain only 1 row
                        }
                    }
                    
                    self.restore()
                    
                } else {
                    // Log details of the failure
                    println("Error: \(error!) \(error!.userInfo!)")
                }
            }
            
        ShowFavourites = true
            
        } else {
            //IF SHOW == TRUE
            listsretrieval()
            
            if CheckConnection.isConnectedToNetwork() {
                //listsretrievalfromcloud()
                checkreceivedlists()
            } else {
                println("No internet connection found")
            }
            
            
            ShowFavourites = false
        }
        
    }
    
    func addTapped(sender:UIButton) {
        println("Settings pressed")
        performSegueWithIdentifier("addNewList", sender: self)

    }
    
    func optionsTapped(sender:UIButton) {
        println("Options pressed")
        performSegueWithIdentifier("presentNav", sender: self)
        
    }
    
    //performSegueWithIdentifier("presentNav", sender: self)
    //addNewList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowFavourites = false
        
        /*
        var rightListsButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Fav", style: UIBarButtonItemStyle.Plain, target: self, action: "FavItemTapped:")
        
        var rightSettingsButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "SettingsItemTapped:")
        
        var rightAddMultipleButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped:")
        
        var rightOptionsMultipleButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Options", style: UIBarButtonItemStyle.Plain, target: self, action: "optionsTapped:")
        
        self.navigationItem.setRightBarButtonItems([rightAddMultipleButtonItem, rightListsButtonItem, rightSettingsButtonItem,rightOptionsMultipleButtonItem], animated: true)
        */
        //performSegueWithIdentifier("presentNav", sender: self)
        
        // listsretrieval()
        
        //refresh the view after deletion function
        //without this refresh in view did load, table won't reload!
        // var refreshControl = UIRefreshControl()
        //refreshControl.addTarget(self, action: Selector("sortArray"), forControlEvents: UIControlEvents.ValueChanged)
        // self.refreshControl = refreshControl
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //var nib = UINib(nibName: "ShopListCell", bundle: nil)
        // tableView.registerNib(nib, forCellReuseIdentifier: "shoplist")
        //register nib to use second prototype cell
        
        // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "receivedlist")
        
        //  var nib1 = UINib(nibName: "ReceivedListCell", bundle: nil)
        //tableView.registerNib(nib1, forCellReuseIdentifier: "receivedlist")
        
        
        
        var nib = UINib(nibName: "ReceivedListOldx", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "receivedlist")
    }
    
   // override func viewDidAppear(animated: Bool) {
     override func viewWillAppear(animated: Bool) {
        
        //not sure if need this BUT
        itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
        
               
            listsretrieval()
        
        if CheckConnection.isConnectedToNetwork() {
            //listsretrievalfromcloud()
            checkreceivedlists()
        } else {
            println("No internet connection found")
        }
        
       
      
    }
    /*
    override func viewWillAppear(animated: Bool) {
        //listsretrieval()
        
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return ListsIds.count
    }

    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "presentNav" {
            /*
            let toViewController = segue.destinationViewController as! OpenSettingsController//UIViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            toViewController.transitioningDelegate = self.transitionOperator
*/
             let toViewController = segue.destinationViewController as! MenuViewController//UIViewController
            toViewController.view.backgroundColor = UIColorFromRGB(0x1695A3).colorWithAlphaComponent(0.85)
            self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            //toViewController.view.alpha = 0.7
           // self.presentViewController(self, animated: true, completion: nil)
        }
        
        
        if segue.identifier == "OpenListSegue" {
            
            let openNav = segue.destinationViewController as! UINavigationController
            //let destinationVC : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            let destinationVC = openNav.viewControllers.first as! ShoppingListCreation
        // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
       
           // if let indexPath = self.tableView.indexPathForSelectedRow() {
   // --> that is for usual storyboard segue! if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
        //destinationVC.activeList = ListsIds[indexPath.row]
        destinationVC.activeList = ListsIds[indexPath.row]
        destinationVC.justCreatedList = false
                if ListsIsReceived[indexPath.row] == false {
                    destinationVC.isReceivedList = false
                } else {
                    destinationVC.isReceivedList = true
                }
        }
            /*
            if let indexPath = tableView.indexPathForCell(sender as! ReceivedListOld) {
                //destinationVC.activeList = ListsIds[indexPath.row]
                destinationVC.activeList = ListsIds[indexPath.row]
                destinationVC.justCreatedList = false
                destinationVC.isReceivedList = true
            }*/

        
    
        }
        
        if segue.identifier == "ToDoOpenListSegue" {
            
            let todoNav = segue.destinationViewController as! UINavigationController
            let todoVC = todoNav.viewControllers.first as! ToDoListCreation

            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                //destinationVC.activeList = ListsIds[indexPath.row]
                todoVC.activelist = ListsIds[indexPath.row]
                todoVC.justCreated = false
                if ListsIsReceived[indexPath.row] == false {
                    todoVC.isReceived = false
                } else {
                    todoVC.isReceived = true
                }
            }

            
            
        }
        /*
        if segue.identifier == "OpenListSegue2" {
            let openNav = segue.destinationViewController as! UINavigationController

            //let destinationVC : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            
           let destinationVC = openNav.viewControllers.first as! ShoppingListCreation
            // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
            
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                //destinationVC.activeList = ListsIds[indexPath.row]
                destinationVC.activeList = ListsIds[indexPath.row]
                destinationVC.justCreatedList = false
                //destinationVC.isReceivedList = true
            }
            
            
        }*/
       
        if segue.identifier == "shareListSegue" {
           
            let shareNav = segue.destinationViewController as! UINavigationController
            
            let shareVC = shareNav.viewControllers.first as! SharingViewController
            
           
            shareVC.listToShare = listtoshare
            shareVC.listToShareType = listtosharetype
            

        }

        /*
        if segue.identifier == "shareListSegue1" {
            
            let shareNav = segue.destinationViewController as! UINavigationController
            
            let shareVC = shareNav.viewControllers.first as! SharingViewController
            
            
            shareVC.listToShare = listtoshare
            
            
        }
*/

    }
    
    
    func addtofav(sender: UIButton!) {
        
        pause()
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        let indexPathFav = tableView.indexPathForCell(cell)
        
        listtofav = ListsIds[indexPathFav!.row]
        
        //just change it immediately
        //ListsIsFavourite[indexPathFav!.row] = true
        
        
        var queryfav = PFQuery(className:"shopLists")
        queryfav.fromLocalDatastore()
        queryfav.whereKey("listUUID", equalTo: listtofav!)
       // queryfav.getObjectInBackgroundWithId(listtofav!) {
        queryfav.getFirstObjectInBackgroundWithBlock() {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
                self.restore()
            } else if let shopList = shopList {
                shopList["isFavourite"] = true
                shopList.pinInBackground()
                //shopList.saveInBackground()
                shopList.saveEventually()
                
                  println(self.ListsIsFavourite)
                
                self.ListsIsFavourite[indexPathFav!.row] = true
                
                  println(self.ListsIsFavourite)
               
                self.restore()
            }
             self.tableView.reloadData()
           // self.listsretrieval()
            
        }
        tableView.reloadData()
       // cell
        
    }
    
    func sharelist(sender: UIButton!) {
        
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        let indexPathShare = tableView.indexPathForCell(cell)
        
        listtoshare = ListsIds[indexPathShare!.row]
        
        listtosharetype = ListsType[indexPathShare!.row]
        
       // var listtoshare1 = ListsIds[indexPathShare!.row]
        
       // return listtoshare1
        
        performSegueWithIdentifier("shareListSegue", sender: self)
        //now it works, variable is not nil anymore
        /*
        var queryfav = PFQuery(className:"shopLists")
        queryfav.getObjectInBackgroundWithId(listtofav!) {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                shopList["isFavourite"] = true
                shopList.saveInBackground()
            }
            self.listsretrieval()
            
        }
        */
        // cell
        
    }
    
    
    func adddeletefav(sender: UIButton!) {
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        var indexPathFav = tableView.indexPathForCell(cell)
        
        listfromfav = ListsIds[indexPathFav!.row]
        
        if ListsIsFavourite[indexPathFav!.row] == true {
            //delete from favs
            
            pause()
            if ListsType[indexPathFav!.row] == "Shop" {
            
            var queryfav = PFQuery(className:"shopLists")
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            queryfav.fromLocalDatastore()
            queryfav.whereKey("listUUID", equalTo: listfromfav!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            queryfav.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                    self.restore()
                } else if let shopList = shopList {
                    shopList["isFavourite"] = false
                    shopList.pinInBackground()
                    // shopList.saveInBackground()
                    shopList.saveEventually()
                    
                    println(self.ListsIsFavourite)
                    
                    self.ListsIsFavourite[indexPathFav!.row] = false
                    
                    println(self.ListsIsFavourite)
                    
                    
                    self.restore()
                }
                self.tableView.reloadData()
                //self.listsretrieval()
                
            }
            
        } else if ListsType[indexPathFav!.row] == "ToDo" {
                
                var queryfav1 = PFQuery(className:"toDoLists")
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav1.fromLocalDatastore()
                queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav1.getFirstObjectInBackgroundWithBlock() {
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        println(error)
                        self.restore()
                    } else if let todoList = todoList {
                        todoList["isFavourite"] = false
                        todoList.pinInBackground()
                        // shopList.saveInBackground()
                        todoList.saveEventually()
                        
                        println(self.ListsIsFavourite)
                        
                        self.ListsIsFavourite[indexPathFav!.row] = false
                        
                        println(self.ListsIsFavourite)
                        
                        
                        self.restore()
                    }
                    self.tableView.reloadData()
                    //self.listsretrieval()
                    
                }
                
            
        }
        
            notfavimage = UIImage(named: "GrayStar.png") as UIImage!
            cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
           
            
        } else {
            //add to favs
            
            pause()
            
             if ListsType[indexPathFav!.row] == "Shop" {
            
            var queryfav = PFQuery(className:"shopLists")
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            queryfav.fromLocalDatastore()
            queryfav.whereKey("listUUID", equalTo: listfromfav!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            queryfav.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                    self.restore()
                } else if let shopList = shopList {
                    shopList["isFavourite"] = true
                    shopList.pinInBackground()
                    // shopList.saveInBackground()
                    shopList.saveEventually()
                    
                    println(self.ListsIsFavourite)
                    
                    self.ListsIsFavourite[indexPathFav!.row] = true
                    
                    println(self.ListsIsFavourite)
                    
                    
                    self.restore()
                }
                self.tableView.reloadData()
                //self.listsretrieval()
                
            }
            
             } else  if ListsType[indexPathFav!.row] == "ToDo" {
                
                var queryfav1 = PFQuery(className:"toDoLists")
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav1.fromLocalDatastore()
                queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav1.getFirstObjectInBackgroundWithBlock() {
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        println(error)
                        self.restore()
                    } else if let todoList = todoList {
                        todoList["isFavourite"] = true
                        todoList.pinInBackground()
                        // shopList.saveInBackground()
                        todoList.saveEventually()
                        
                        println(self.ListsIsFavourite)
                        
                        self.ListsIsFavourite[indexPathFav!.row] = true
                        
                        println(self.ListsIsFavourite)
                        
                        
                        self.restore()
                    }
                    self.tableView.reloadData()
                    //self.listsretrieval()
                    
                }
                
                
            }
            
            favimage = UIImage(named: "FavStar.png") as UIImage!
            cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
        }
        
    }
    
    func delfromfav(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        let indexPathFav = tableView.indexPathForCell(cell)
        
        listfromfav = ListsIds[indexPathFav!.row]
        
        
        pause()
        
        var queryfav = PFQuery(className:"shopLists")
       // queryfav.getObjectInBackgroundWithId(listtofav!) {
        queryfav.fromLocalDatastore()
        queryfav.whereKey("listUUID", equalTo: listfromfav!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        queryfav.getFirstObjectInBackgroundWithBlock() {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
                self.restore()
            } else if let shopList = shopList {
                shopList["isFavourite"] = false
                shopList.pinInBackground()
               // shopList.saveInBackground()
                shopList.saveEventually()
                
                println(self.ListsIsFavourite)
                
                self.ListsIsFavourite[indexPathFav!.row] = false
                
                println(self.ListsIsFavourite)
                
                
                self.restore()
            }
            self.tableView.reloadData()
            //self.listsretrieval()
            
        }
        //tableView.reloadData()
        // cell
        
    }
    
    
    func saveImageLocally(imageData:NSData!) -> String {
        var uuid = NSUUID().UUIDString
        //let time =  NSDate().timeIntervalSince1970
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        //.stringByAppendingPathComponent(subDirForImage) as String
        
        if !fileManager.fileExistsAtPath(dir) {
            var error: NSError?
            if !fileManager.createDirectoryAtPath(dir, withIntermediateDirectories: true, attributes: nil, error: &error) {
                println("Unable to create directory: \(error)")
                return ""
            }
        }
        
        let pathToSaveImage = dir.stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    
    func changinglistimages(shopListItemsIn1: [String]) {
        
        //for var index = 0; index < ItemsInReceivedList.count; index++ {
        for var index = 0; index < shopListItemsIn1.count; index++ {
            var queryitem = PFQuery(className:"shopItems")
           // queryitem.whereKey("objectId", equalTo: shopListItemsIn1[index])
            queryitem.whereKey("itemUUID", equalTo: shopListItemsIn1[index])
            queryitem.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    println("Successfully retrieved \(objects!.count) scores.")
                    
                    if let listitems = objects as? [PFObject] {
                        
                        for object in listitems {
                            println(object.objectId)
                            
                            
                            
                            object["itemImage"]!.getDataInBackgroundWithBlock { (data, error) -> Void in
                                //we extract the image from parse and post them
                                
                                if let downloadedImage = UIImage(data: data!) {
                                    
                                    let imageData = UIImagePNGRepresentation(downloadedImage)
                                    
                                        self.saveImageLocally(imageData)
                                    println("Image path is \(self.imagePath)")
                                    
                                }
                                // HERE IT WORKS
                                object["imageLocalPath"] = self.imagePath
                                object["itemImage"] = NSNull()
                                object.pinInBackground()
                                object.saveEventually()
                                
                            }
                            /*
                            object["imageLocalPath"] = self.imagePath
                            object["itemImage"] = NSNull()
                            object.pinInBackground()
                            object.saveEventually()
                            */
                        }
                        
                    }
                    
                } else {
                    // Log details of the failure
                    println("Error: \(error!) \(error!.userInfo!)")
                    println("BITCH DOESNT WORK")
                }
            }
            
        } //end of for loop
        
        ////
        
    }

    
    func savereceivedlist(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathSave = tableView.indexPathForCell(cell)
        
        listtosave = ListsIds[indexPathSave!.row]
        
        
        var querysave = PFQuery(className:"shopLists")
       // queryfav.getObjectInBackgroundWithId(listtosave!) {
       
        querysave.whereKey("listUUID", equalTo: listtosave!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        querysave.getFirstObjectInBackgroundWithBlock() {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                
                self.ItemsInReceivedList = shopList["ItemsInTheShopList"] as! [String]
                
                println("List to load for changing \(self.ItemsInReceivedList)")
                
                self.changinglistimages(self.ItemsInReceivedList)
                
                shopList["isSaved"] = true
                
                /////////
                
                cell.receivedlistnamebutton.enabled = true
                
                shopList["confirmReception"] = true // WTF, I already had isSaved!

                
                /////////
                
                shopList.pinInBackground()
                shopList.saveEventually()
                // shopList.saveInBackground()
                //shopList.saveEventually()
            }
            //self.listsretrieval()
            
        }
        
        // cell
       // cell.deletereceivedlist.userInteractionEnabled = true
        //cell.deletereceivedlist.userInteractionEnabled = true
                
    }
    
    func savereceivedtodolist(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathSave = tableView.indexPathForCell(cell)
        
        listtosave = ListsIds[indexPathSave!.row]
        
        
        var querysave = PFQuery(className:"toDoLists")
        
        querysave.whereKey("listUUID", equalTo: listtosave!)
        querysave.getFirstObjectInBackgroundWithBlock() {
            (todoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let todoList = todoList {
                
                
                todoList["isSaved"] = true
                
                /////////
                
                cell.receivedlistnamebutton.enabled = true
                
                todoList["confirmReception"] = true // WTF, I already had isSaved!
                
                
                /////////
                
                todoList.pinInBackground()
                todoList.saveEventually()

            }

            
        }
        

    }

    
    func refreshabit() {
       // listsretrieval()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
 
    func deletereceivedlist(sender: UIButton!) {
        
        //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathReceivedDelete = tableView.indexPathForCell(cell)
        
        println(indexPathReceivedDelete!.row)
        listtodelete = ListsIds[indexPathReceivedDelete!.row]
        println("List to delete \(listtodelete)")
        
        self.ListsIds.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsNames.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsNotes.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsCreationDates.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsFavourite.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsReceived.removeAtIndex(indexPathReceivedDelete!.row)
       // self.ListsSharedWith.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsBelongsToUser.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsReceivedFrom.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsSaved.removeAtIndex(indexPathReceivedDelete!.row)
        
        self.ListsShareWith.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsShared.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsDeleted.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsConfirm.removeAtIndex(indexPathReceivedDelete!.row)
        
        self.ListsItemsCount.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsItemsCheckedCount.removeAtIndex(indexPathReceivedDelete!.row)

        
        //var arrayofusers = ListsBelongsToUsers[indexPathDelete!.row]
        dispatch_async(dispatch_get_main_queue(), {
        var query = PFQuery(className:"shopLists")
        //query.getObjectInBackgroundWithId(self.listtodelete!) {
           
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                //shopList.deleteInBackground()
                shopList["isDeleted"] = true
                shopList.saveEventually()
                
                
            }
            
        }
            })
        var query2 = PFQuery(className:"shopLists")
        query2.fromLocalDatastore()
      //  query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {

            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                shopList.unpinInBackground()
            }
            
        }
       
        self.tableView.deleteRowsAtIndexPaths([indexPathReceivedDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)

        /*
        // BEGINNING OF OLD APPROACH
        var query = PFQuery(className:"shopLists")
        query.getObjectInBackgroundWithId(listtodelete!) {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {

                // Better idea! Make a dictionary for User class, where array of the following is stored [sendername : listname : accepted : deleted]

                
               self.ListsBelongsToUsers[indexPathReceivedDelete!.row] = self.ListsBelongsToUsers[indexPathReceivedDelete!.row].filter() { $0 != PFUser.currentUser()!.objectId! }
                
                self.ListsBelongsToUser[indexPathReceivedDelete!.row] = self.ListsBelongsToUser[indexPathReceivedDelete!.row].filter() { $0 != PFUser.currentUser()!.objectId! }
                
                self.ListsSharedWith[indexPathReceivedDelete!.row] = self.ListsSharedWith[indexPathReceivedDelete!.row].filter() { $0 != PFUser.currentUser()!.objectId! }
                
                            
                
                shopList["BelongsToUsers"] = self.ListsBelongsToUsers[indexPathReceivedDelete!.row]
                
                shopList["ShareWithArray"] = self.ListsSharedWith[indexPathReceivedDelete!.row]
                
                shopList.saveInBackground()
                //here I get authetnification issue
                
                println("List to upload belong \(self.ListsBelongsToUsers[indexPathReceivedDelete!.row])")
                println("List to upload share \(self.ListsSharedWith[indexPathReceivedDelete!.row])")
            }
            // END OF OLD APPROACH
            
            //self.tableView.deleteRowsAtIndexPaths([indexPathReceivedDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)

        } */
        //refreshabit()
        //self.listsretrieval()
        //tableView.reloadData()
        //refreshControl?.endRefreshing()
        
        //self.listsretrieval()
        //self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        //tableView.reloadData()
    }
    
    
    func deletereceivedtodolist(sender: UIButton!) {
        
        pause()
        
        //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathReceivedDelete = tableView.indexPathForCell(cell)
        
        println(indexPathReceivedDelete!.row)
        listtodelete = ListsIds[indexPathReceivedDelete!.row]
        println("List to delete \(listtodelete)")
        
        self.ListsIds.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsNames.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsNotes.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsCreationDates.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsFavourite.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsReceived.removeAtIndex(indexPathReceivedDelete!.row)
        // self.ListsSharedWith.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsBelongsToUser.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsReceivedFrom.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsSaved.removeAtIndex(indexPathReceivedDelete!.row)
        
        self.ListsShareWith.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsShared.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsIsDeleted.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsConfirm.removeAtIndex(indexPathReceivedDelete!.row)
        
        self.ListsItemsCount.removeAtIndex(indexPathReceivedDelete!.row)
        self.ListsItemsCheckedCount.removeAtIndex(indexPathReceivedDelete!.row)
        
        
        //var arrayofusers = ListsBelongsToUsers[indexPathDelete!.row]
        dispatch_async(dispatch_get_main_queue(), {
            var query = PFQuery(className:"toDoLists")
            //query.getObjectInBackgroundWithId(self.listtodelete!) {
            
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let todoList = todoList {
                    //shopList.deleteInBackground()
                    todoList["isDeleted"] = true
                    todoList.saveEventually()
                    
                    
                }
                
            }
        })
        var query2 = PFQuery(className:"toDoLists")
        query2.fromLocalDatastore()
        //  query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {
            
            (todoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let todoList = todoList {
                todoList.unpinInBackground()
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathReceivedDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        restore()
        
    }
    
    
    
    
    func deletelist(sender: UIButton!) {
        
     //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        
        pause()
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        let indexPathDelete = tableView.indexPathForCell(cell)
        
        println(indexPathDelete!.row)
        listtodelete = ListsIds[indexPathDelete!.row]
        
        self.ListsIds.removeAtIndex(indexPathDelete!.row)
        self.ListsNames.removeAtIndex(indexPathDelete!.row)
        self.ListsNotes.removeAtIndex(indexPathDelete!.row)
        self.ListsCreationDates.removeAtIndex(indexPathDelete!.row)
        self.ListsIsFavourite.removeAtIndex(indexPathDelete!.row)
        self.ListsIsReceived.removeAtIndex(indexPathDelete!.row)
        //self.ListsSharedWith.removeAtIndex(indexPathDelete!.row)
        self.ListsBelongsToUser.removeAtIndex(indexPathDelete!.row)
        self.ListsReceivedFrom.removeAtIndex(indexPathDelete!.row)
        self.ListsIsSaved.removeAtIndex(indexPathDelete!.row)
        
        self.ListsShareWith.removeAtIndex(indexPathDelete!.row)
        self.ListsIsShared.removeAtIndex(indexPathDelete!.row)
        self.ListsIsDeleted.removeAtIndex(indexPathDelete!.row)
        self.ListsConfirm.removeAtIndex(indexPathDelete!.row)
        
        self.ListsItemsCount.removeAtIndex(indexPathDelete!.row)
        self.ListsItemsCheckedCount.removeAtIndex(indexPathDelete!.row)
       
        
        dispatch_async(dispatch_get_main_queue(), {
        var query = PFQuery(className:"shopLists")
       // query.getObjectInBackgroundWithId(self.listtodelete!) {
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {

            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                //shopList.deleteInBackground()
                shopList["isDeleted"] = true
                shopList.saveEventually()
                
            }
            
        }
            })
        
        var query2 = PFQuery(className:"shopLists")
        query2.fromLocalDatastore()
       // query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {

            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                shopList.unpinInBackground()
                
                
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
       //self.listsretrieval()
        //self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        //tableView.reloadData()
        
        self.restore()
    }
    
    
    func deletetodolist(sender: UIButton!) {
        pause()
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        let indexPathDelete = tableView.indexPathForCell(cell)
        
        println(indexPathDelete!.row)
        listtodelete = ListsIds[indexPathDelete!.row]
        
        self.ListsIds.removeAtIndex(indexPathDelete!.row)
        self.ListsNames.removeAtIndex(indexPathDelete!.row)
        self.ListsNotes.removeAtIndex(indexPathDelete!.row)
        self.ListsCreationDates.removeAtIndex(indexPathDelete!.row)
        self.ListsIsFavourite.removeAtIndex(indexPathDelete!.row)
        self.ListsIsReceived.removeAtIndex(indexPathDelete!.row)
        //self.ListsSharedWith.removeAtIndex(indexPathDelete!.row)
        self.ListsBelongsToUser.removeAtIndex(indexPathDelete!.row)
        self.ListsReceivedFrom.removeAtIndex(indexPathDelete!.row)
        self.ListsIsSaved.removeAtIndex(indexPathDelete!.row)
        
        self.ListsShareWith.removeAtIndex(indexPathDelete!.row)
        self.ListsIsShared.removeAtIndex(indexPathDelete!.row)
        self.ListsIsDeleted.removeAtIndex(indexPathDelete!.row)
        self.ListsConfirm.removeAtIndex(indexPathDelete!.row)
        
        self.ListsItemsCount.removeAtIndex(indexPathDelete!.row)
        self.ListsItemsCheckedCount.removeAtIndex(indexPathDelete!.row)
        
        
        dispatch_async(dispatch_get_main_queue(), {
            var query = PFQuery(className:"toDoLists")
            // query.getObjectInBackgroundWithId(self.listtodelete!) {
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                
                (toDoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let toDoList = toDoList {
                    
                    //shopList.deleteInBackground()
                    toDoList["isDeleted"] = true
                    toDoList.saveEventually()
                    
                }
                
            }
        })
        
        var query2 = PFQuery(className:"toDoLists")
        query2.fromLocalDatastore()
        // query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {
            
            (toDoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let toDoList = toDoList {
                
                toDoList.unpinInBackground()
                
                
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        //self.listsretrieval()
        //self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        //tableView.reloadData()
        
        self.restore()
    }

    
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            ListsIds.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
*/
    
    func openlistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        
        let indexPathOpen = tableView.indexPathForCell(cell)
        
         self.performSegueWithIdentifier("OpenListSegue", sender: cell)
    }
    
    
    func opentodolistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ShopListCell
        
        let indexPathOpen = tableView.indexPathForCell(cell)
        
        self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
    }
    
    func openreceivedtodolistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let receivedcell = view.superview as! ReceivedListOld
        
        let indexPathReceivedOpen = tableView.indexPathForCell(receivedcell)
        
        self.performSegueWithIdentifier("ToDoOpenListSegue", sender: receivedcell)
    }

    
    
    func openreceivedlistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let receivedcell = view.superview as! ReceivedListOld
        
        let indexPathReceivedOpen = tableView.indexPathForCell(receivedcell)
        
        self.performSegueWithIdentifier("OpenListSegue", sender: receivedcell)
    }

    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       // if ListsIsReceived[indexPath.row] == true
        
       // self.performSegueWithIdentifier("OpenListSegue", sender: nil)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

       
        //Function to check if array contains my user
        func contains(values: [String], element: String) -> Bool {
            // Loop over all values in the array.
            for value in values {
                // If a value equals the argument, return true.
                if value == element {
                    return true
                }
            }
            // The element was not found.
            return false
        }

            // Received List Part
            if ListsIsReceived[indexPath.row] == true {
          
            
            // Configure the cell...
           
            let receivedcell  = tableView.dequeueReusableCellWithIdentifier("receivedlist", forIndexPath: indexPath) as! ReceivedListOld
            
            println(ListsNames)
            
            receivedcell.receivedlistname.text = ListsNames[indexPath.row]
            receivedcell.receivedlistnote.text = ListsNotes[indexPath.row]
                
            receivedcell.receivedlistnamebutton.setTitle(ListsNames[indexPath.row], forState: .Normal)
                receivedcell.receivedlistnamebutton.tag = indexPath.row
                
                if ListsType[indexPath.row] == "Shop"
                {
                    receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedlistbyname:", forControlEvents: .TouchUpInside)
                } else {
                    receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedtodolistbyname:", forControlEvents: .TouchUpInside)
                }
                
                if ListsIsSaved[indexPath.row] == false {
                receivedcell.receivedlistnamebutton.enabled = false
                } else {
                    receivedcell.receivedlistnamebutton.enabled = true

                }
                
            
            receivedcell.sendername.text = ListsReceivedFrom[indexPath.row][1] //name
               if ListsReceivedFrom[indexPath.row][2] != "default@default.com" {
            receivedcell.senderemail.text = ListsReceivedFrom[indexPath.row][2] //email
                } else {
                    receivedcell.senderemail.text = "Anonymous"
                }
           
            receivedcell.deletereceivedlist.tag = indexPath.row
                if ListsType[indexPath.row] == "Shop" {
            receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedlist:", forControlEvents: .TouchUpInside)
                } else if ListsType[indexPath.row] == "ToDo" {
                     receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedtodolist:", forControlEvents: .TouchUpInside)
                }
           
            
                receivedcell.sharereceivedlist.tag = indexPath.row
                if ListsType[indexPath.row] == "Shop" {

                receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedlist:", forControlEvents: .TouchUpInside)
                } else if ListsType[indexPath.row] == "ToDo" {
                     receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedtodolist:", forControlEvents: .TouchUpInside)
                }
            
            let dateFormatter1 = NSDateFormatter()
            dateFormatter1.dateFormat = "dd.MM.yyyy"
            let date1 = dateFormatter1.stringFromDate(ListsCreationDates[indexPath.row] as NSDate)
            receivedcell.receivedlistdate.text = date1
                
                receivedcell.itemscount.text = String(ListsItemsCount[indexPath.row])
                receivedcell.checkeditemscount.text = String(ListsItemsCheckedCount[indexPath.row])

            return receivedcell
            
       
        } else {
            let cellIdentifier1 = "shoplist"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCell
            
            
            // Configure the cell...
            
            cell.ShopListName.text = ListsNames[indexPath.row]
            cell.ShopListNote.text = ListsNotes[indexPath.row]
                
            cell.ShopListNameButton.setTitle(ListsNames[indexPath.row], forState: .Normal)
            
                
                cell.ShopListNameButton.tag = indexPath.row
                
                if ListsType[indexPath.row] == "Shop" {
                
                cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
                } else if ListsType[indexPath.row] == "ToDo" {
                    cell.ShopListNameButton.addTarget(self, action: "opentodolistbyname:", forControlEvents: .TouchUpInside)
                }
            
            cell.DeleteOutlet.tag = indexPath.row
                if ListsType[indexPath.row] == "Shop" {
            cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
                } else {
                   cell.DeleteOutlet.addTarget(self, action: "deletetodolist:", forControlEvents: .TouchUpInside)
                }
            cell.ShareButtonOutlet.tag = indexPath.row
            cell.ShareButtonOutlet.addTarget(self, action: "sharelist:", forControlEvents: .TouchUpInside)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = dateFormatter.stringFromDate(ListsCreationDates[indexPath.row] as NSDate)
            cell.creationDate.text = date
            
            
            if ListsIsFavourite[indexPath.row] == true {
                favimage = UIImage(named: "FavStar.png") as UIImage!
                cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
               // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
            } else {
                notfavimage = UIImage(named: "GrayStar.png") as UIImage!
                cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
               // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
            }

                
                cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                
                cell.itemscount.text = String(ListsItemsCount[indexPath.row])
                cell.checkeditemscount.text = String(ListsItemsCheckedCount[indexPath.row])
            
            return cell
        
        }
    }
    
    //cell.MyButton.row = indexPath.row
    
    
    /*
    cell.tapped = { [unowned self] (selectedCell) -> Void in
    let path = tableView.indexPathForRowAtPoint(selectedCell.center)!
    let selectedItem = self.ListsIds[path.row]
    self.listtodelete = selectedItem
    
    println("the selected item is \(selectedItem)")
    */
    
    /*
    
    let cellDelete = tableView.cellForRowAtIndexPath(indexPath) as! ShopListCell
    var tag = cellDelete.DeleteOutlet.tag
    let indexPathDelete = NSIndexPath(forRow: tag, inSection: 0)
    */

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
