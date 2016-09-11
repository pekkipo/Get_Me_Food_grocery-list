//
//  SharingViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 18/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import MessageUI


protocol takepicturedelegate
{
    func createpicture()
    func savetogallery()
}

class SharingViewController: UIViewController, MPGTextFieldDelegate, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, choosecontactsdelegate {
    
    
    
    func choosefromcontact(email: String) {
        name.text = email
    }
    
    var delegate : takepicturedelegate?
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var succespict : UIImage = UIImage(named: "4CheckMark")!
    var errorpict : UIImage = UIImage(named: "4Close")!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func backbutton(sender: AnyObject) {
        
        if senderVC == "AllListsVC" {
            performSegueWithIdentifier("backtoall", sender: self)
        } else if senderVC == "ShopCreationVC" {
            performSegueWithIdentifier("backtoshop", sender: self)
        } else if senderVC == "ToDoCreationVC" {
            performSegueWithIdentifier("backtotodo", sender: self)
        } else {
            performSegueWithIdentifier("backtoall", sender: self)
        }
        
        
    }
    
    
    
    @IBAction func donebutton(sender: AnyObject) {
        
        if senderVC == "AllListsVC" {
            performSegueWithIdentifier("backtoall", sender: self)
        } else if senderVC == "ShopCreationVC" {
            performSegueWithIdentifier("backtoshop", sender: self)
        } else if senderVC == "ToDoCreationVC" {
            performSegueWithIdentifier("backtotodo", sender: self)
        } else {
            performSegueWithIdentifier("backtoall", sender: self)
        }
    }
    
    var senderVC = String()
    
    
    var listToShare: String?
    var listToShareType: String?
    
    var receiverUser = String()
    var receiverUserName = String()
    
    var newlistId = String()
    
    var todonewlistId = String()
    
    var BelongsToUsers = [String]()
    var ShareWithUsers = [String]()
    
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
   // var shopListCreation = [NSDate]()
   // var shopListUpdate = [NSDate]()
    
    var ItemsCount = Int()
    var CheckedItemsCount  = Int()
    
    var thisListSharedWith = [[AnyObject]]()
    var shopListCurrency = String()
    var shopListShowCats = Bool()
    var shopListCurrencyArray = [AnyObject]()
    
    
    //
    
    var todoListId = String()
    var todoListName = String()
    var todoListNote = String()
    var todoListBelongsTo = String()
    var todoListIsFavourite = Bool()
    var todoListIsReceived = Bool()
    var todoListShareWith = [String]()
    var todoListSentFrom = [String]()
    var todoListItemsIn = [String]()
    var todoListCreatedAt = NSDate()
    var todoListUpdatedAt = NSDate()
    var todoListIsSaved = Bool()
    var newtodoListItemsIn = [String]()
    // var shopListCreation = [NSDate]()
    // var shopListUpdate = [NSDate]()
    
    var todoItemsCount = Int()
    var todoCheckedItemsCount  = Int()
    
    var todothisListSharedWith = [[AnyObject]]()
    //
    
    var successfulladd = Bool()
    var successpopulation = Bool()
    //items part
    /*
    var itemname = [String]()
    var itemnote = [String]()
    var itemimage = [PFFile]()
    var itemquantity = [String]()
    var itemlist = [String]()
    var itemprice = [Double]()
    var itemtotalsum = [Double]()
    var itembelongsto = [String]()
    var itemchosenfromhistory = [Bool]()
    */
    var itemname = String()
    var itemnote = String()
    var itemimage = PFFile()
    var itemquantity = String()
    var itemlist = String()
    var itemprice = String()
    var itemtotalsum = String()
    var itembelongsto = String()
    var itemchosenfromhistory = Bool()
    var itemunit = String()
    var itemLocalImagePath = String()
    var itemischecked = Bool()
    var itemiscatalog = Bool()
    var itemoriginal = String()
    
    var itemcategory = String()
    
    var imagefromstore = UIImage()
    
    var imageisfav = Bool()
    
    var itemperunit = String()
    
    var itemcreation = NSDate()
    var itemupdate = NSDate()
    
    var isdefaultpicture = Bool()
    var originalindefaults = String()
    
    //todoitemspart
    var todoitemname = String()
    var todoitemnote = String()
    var todoimportant = Bool()
    var todoitemlist = String()
    var todoitembelongsto = String()
    var todoitemischecked = Bool()
    var todoitemcreationdate = NSDate()
    var todoitemupdatedate = NSDate()
    
    ///from contacts
    var contactsarray = [[AnyObject]]()
    var contactsavatars = [PFFile]()
    var contactsnames = [String]()
    var contactsemails = [String]()
    
    
    var listDictionary = Dictionary<String, AnyObject>()
    
    
    //AUTOCOMPLETE PART STARTS HERE
    var sampleData = [Dictionary<String, AnyObject>]()
    
    @IBOutlet var name: MPGTextField_Swift!
    
   // var tempstring = String()

    
    @IBOutlet var sharebuttonoutlet: UIButton!
    
    var loadeddata : Bool = false
    
    @IBAction func adressediting(sender: AnyObject) {
        
        
        
        var string : String = name.text!
        
        print(string)
        
        var length = string.characters.count//count(string)
        


        if (length == 4) {//|| (length == 6) {

            
            print(length)
            print(string)
            //dispatch_async(dispatch_get_main_queue()) {
            if !loadeddata {
            self.generateData(string)
            loadeddata = true
            }
            
                      // }
           
            
        }
        
        if length < 4 {
            loadeddata = false
        }
       
//        name.layoutSubviews()

       
        
    }
    
    
    var contentsemails = [String]()
    var contentsnames = [String]()
    
     var dictionary = Dictionary<String, AnyObject>()
    //maybe its not feasible to load data ince the view is loaded, maybe I should search directly in parse without loading the whole list of users to an array
    func generateData(tempprefix: String){

        indicator.hidden = false
        indicator.startAnimation()
        
        sampleData.removeAll(keepCapacity: true)
        
        var query:PFQuery = PFUser.query()!//:PFQuery = PFUser.query()!
        //query.whereKey("authData", notEqualTo: Ano) //dont need anonymous user
        query.whereKey("email", hasPrefix: tempprefix)
        query.limit = 1000
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let users = objects as? [PFObject] {
                    for object in users {
                        if object["email"] != nil {
                            //self.contentsnames.append(object["username"] as! String)
                            self.contentsnames.append(object["name"] as! String)
                            self.contentsemails.append(object["email"] as! String)//(object.email as! String)
                        } else {
                            print("skip anonymous")
                        }
                        
                    }
                    
                    self.indicator.hidden = true
                    self.indicator.stopAnimation()
                    
                    for var i = 0;i<self.contentsnames.count;++i {
                        var name = self.contentsnames[i] as String//["username"] as! String
                        //name += " " + lName
                        var email = self.contentsemails[i] as String
                        self.dictionary = ["DisplayText":email,"DisplaySubText":name, "CustomObject":self.contentsnames[i]]
                        
                        self.sampleData.append(self.dictionary)
                        
                    }
                    print("Users are \(self.sampleData)")

                    
                }
            } else {
                // Log details of the failure
                self.indicator.hidden = true
                self.indicator.stopAnimation()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    func dataForPopoverInTextField(textfield: MPGTextField_Swift) -> [Dictionary<String, AnyObject>]
    {
        return sampleData
    }
    
    func textFieldShouldSelect(textField: MPGTextField_Swift) -> Bool{
        return true
    }
  
    func textFieldDidEndEditing(textField: MPGTextField_Swift, withSelection data: Dictionary<String,AnyObject>){
        print("Dictionary received = \(data)")
    }

 //AUTOCOMPLETE PART ENDS HERE
    
    
    func showindicator() {
        
        
        
    }
    
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("sending", comment: ""))
    
    func pause() {
        
        /*
        self.view.addSubview(progressHUD)
        
        progressHUD.setup()
        progressHUD.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
 */
        loading_simple(true)
    }
    
    
    func restore() {
        /*
        progressHUD.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
 */
        loading_simple(false)
    }
    
    func displaySuccessAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "4SentSuccess")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xFFFFFF, alpha: 1), iconImage: customIcon)
        alertview.setTextTheme(.Dark)
        //alertview.addAction(closeCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "4SentFail")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xFFFFFF, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Dark)
        alertview.addAction(cancelCallback)
        alertview.addCancelAction(closeCallback)
    }
    /*
    func displayEmailSendAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x2a2f36, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        //alertview.addAction(closeCallback)
        alertview.addCancelAction(closeCallback)
    }
    */
    
      
    func cancelCallback() {
        name.text = ""
        print("CANCELED")
    }
    
    func closeCallback() {
        
        //self.tableView.reloadData()
        name.text = ""
        
        print("JUST CLOSED")
        
    }
    
    @IBAction func sharebutton(sender: AnyObject) {
        
        sampleData.removeAll(keepCapacity: true)
        
        if listToShareType == "Shop" {
        
        self.gettingrequireduser(name.text!)
        } else if listToShareType == "ToDo" {
            self.todogettingrequireduser(name.text!)
        }
        
        //sharing stuff here
        
        //gettingrequireduser()
        
        
       // println("Array before adding is \(self.newShopListItemsIn)")
        
       // self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
        
        //self.getthelist()
        
       // self.newPFObjectList()
       // println("bitches are \(shopListItemsIn)")
        
        //println("bitches are 1\(shopListItemsIn)")
       // self.populatingthelist(shopListItemsIn)
       
        
        
        
    }
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    // NEW APPROACH
    // 1) Get the list that is supposed to be shared 
    // 2) Create new PFObject shopping list
    // 3) Fill that list
    
    
    func gettingrequireduser(emailofreceiver: String) -> String {
        //getting the user with typed email
        
        self.pause()
        
        let queryreceiver:PFQuery = PFUser.query()!//:PFQuery = PFUser.query()!
        queryreceiver.whereKey("email", equalTo: emailofreceiver)//name.text)
        queryreceiver.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                self.restore()
                if error != nil {
                   // self.displayFailAlert("Oops!", message: "Error: \(error)")
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                } else {
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                    
                }
                
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                self.receiverUser = object!.objectId!
                
                self.getthelist(emailofreceiver)
                print("receiver is \(self.receiverUser)")
            }
        }
        
        return self.receiverUser
        
    }
    
    func todogettingrequireduser(emailofreceiver: String) -> String {
        //getting the user with typed email
        
        self.pause()
        
        let queryreceiver:PFQuery = PFUser.query()!//:PFQuery = PFUser.query()!
        queryreceiver.whereKey("email", equalTo: emailofreceiver)//name.text)
        queryreceiver.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                self.restore()
                if error != nil {
                   // self.displayFailAlert("Oops!", message: "Error: \(error)")
                    
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                    
                } else {
                   // self.displayFailAlert("Oops! Something went wrong", message: "Something went wrong")
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                }

                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                self.receiverUser = object!.objectId!
                
                self.todogetthelist(emailofreceiver)
                print("receiver is \(self.receiverUser)")
            }
        }
        
        return self.receiverUser
        
    }
    
    
    
    func getreceiversname(receiverid:String) -> String {
        
        let contactnamequery:PFQuery = PFUser.query()!
        // contactquery.fromLocalDatastore()
        contactnamequery.whereKey("objectId", equalTo: receiverid)//self.contactemail.text)
        let names = contactnamequery.findObjects()
        if (names != nil) {
            for name in names! {
                if let thisname = name["name"] as? String { //used to be username
                    print("NAME IS \(thisname)")
                    self.receiverUserName = name["name"] as! String //used to be username
                }
            }
        } else {
            print("No username yet")
        }
        
        // self.contactsavatars.append(self.avatarFile)
        return self.receiverUserName
    }
    
    func getthelist(senderemail: String) {//(listToShare: String, receiverUser: String) {
        
        print(senderemail)
        
        var querylist = PFQuery(className:"shopLists")
        querylist.fromLocalDatastore()
        //querylist.whereKey("objectId", equalTo: listToShare!)
        querylist.whereKey("listUUID", equalTo: listToShare!)
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
                       // self.shopListSentFrom.append(PFUser.currentUser()!.username!)
                        
                        if PFUser.currentUser()!["name"] != nil {
                        self.shopListSentFrom.append(PFUser.currentUser()!["name"] as! String)
                        } else {
                           self.shopListSentFrom.append(NSLocalizedString("AnonUser", comment: ""))
                            
                        }
                        
                        self.shopListCreatedAt = object["creationDate"] as! NSDate
                        self.shopListUpdatedAt = object["updateDate"] as! NSDate
                        
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
                        
                        self.shopListCurrency = object["ListCurrency"] as! String
                        self.shopListShowCats = object["ShowCats"] as! Bool
                        
                        self.shopListCurrencyArray = object["CurrencyArray"] as! [AnyObject]
                        
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
                        
                        // Update THIS list with date about the receiver
                        object["isShared"] = true
                       // object["is"]
                        object["confirmReception"] = false
                        
                        var senddate = NSDate()
                        //var calendar = NSCalendar.currentCalendar()
                        //var components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: senddate)
                        //var hour = components.hour
                        
                        
                        
                        
                        // Create new list for receiver
                       self.newPFObjectList()
                        
                        
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
                        var date = dateFormatter.stringFromDate(senddate)
                        
                        self.getreceiversname(self.receiverUser)
                        
                       // self.thisListSharedWith.append([self.receiverUser, self.receiverUserName,self.name.text, date, self.newlistId, false])
                        self.thisListSharedWith.append([self.receiverUser, self.receiverUserName, senderemail, date, self.newlistId, false])
                     
                        print(self.thisListSharedWith)
                        
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

                        // self.populatingthelist()
                        
                        
                        
                    }
                }
            } else {
                // Log details of the failure
                self.restore()
                if error != nil {
                    self.displayFailAlert("Oops!", message: NSLocalizedString("error2", comment: ""))
                } else {
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                }

                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
       // self.newPFObjectList()
        
        
    }
    
    
    
    func todogetthelist(senderemail: String) {//(listToShare: String, receiverUser: String) {
        
        
        var querylist = PFQuery(className:"toDoLists")
        querylist.fromLocalDatastore()
        querylist.whereKey("listUUID", equalTo: listToShare!)
        querylist.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let listitems = objects as? [PFObject] {
                    
                    for object in listitems {
                        print(object.objectId)

                        self.todoListId = object["listUUID"] as! String
                        self.todoListName = object["ToDoListName"] as! String
                        self.todoListNote = object["ToDoListNote"] as! String
                        self.todoListIsFavourite = false //object["isFavourite"] as! Bool
                        self.todoListIsReceived = true
                        self.todoListSentFrom.append(PFUser.currentUser()!.objectId!)
                       // self.todoListSentFrom.append(PFUser.currentUser()!.username!)
                        self.todoListSentFrom.append(PFUser.currentUser()!["name"] as! String)
                        
                        self.todoListCreatedAt = object["CreationDate"] as! NSDate
                        self.todoListUpdatedAt = object["updateDate"] as! NSDate
                        
                        if PFUser.currentUser()!.email != nil {
                            self.todoListSentFrom.append(PFUser.currentUser()!.email!)
                        } else {
                            self.todoListSentFrom.append("default@default.com")
                            print("Anonoymous user, no email")
                        }
                        
                        self.todoListItemsIn = object["ItemsInTheToDoList"] as! [String]
                        self.todoListIsSaved = object["isSaved"] as! Bool
                        
                        self.todothisListSharedWith = object["ShareWithArray"] as! [[AnyObject]]
                        
                        self.todoItemsCount = object["ItemsCount"] as! Int
                        self.todoCheckedItemsCount = object["CheckedItemsCount"] as! Int
                        
                        
                        
                        
                        self.todoListBelongsTo = self.receiverUser

                        
                        // Update THIS list with date about the receiver
                        object["isShared"] = true
                        // object["is"]
                        object["confirmReception"] = false
                        
                        var senddate = NSDate()
                        //var calendar = NSCalendar.currentCalendar()
                        //var components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: senddate)
                        //var hour = components.hour
                        
                        
                        
                        
                        // Create new list for receiver
                        self.todonewPFObjectList()
                        
                        
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
                        var date = dateFormatter.stringFromDate(senddate)
                        
                        self.getreceiversname(self.receiverUser)
                        
                       // self.todothisListSharedWith.append([self.receiverUser, self.receiverUserName,self.name.text, date, self.todonewlistId, false])
                        self.todothisListSharedWith.append([self.receiverUser, self.receiverUserName,senderemail, date, self.todonewlistId, false])
                        
                        print("Share with \(self.todothisListSharedWith)")
                        
                        object["ShareWithArray"] = self.todothisListSharedWith
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                print("Successfully saved to local store")
                            } else {
                                print("Wasn't save to localstore")
                            }
                        })
                        //shopList.saveInBackground()
                        object.saveEventually()
                        
                        // self.populatingthelist()
                        
                        
                        
                    }
                }
            } else {
                self.restore()
                if error != nil {
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                } else {
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                }

                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        // self.newPFObjectList()
        
        
    }
    
    
    
    func newPFObjectList() {
        
        let uuid = NSUUID().UUIDString
        let listuuid = "shoplist\(uuid)"
        
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
        //Don't need this original stuff
        //shopListNew["OriginalList"] = self.shopListId // Id of original shop list
        shopListNew["isShared"] = false
        shopListNew["confirmReception"] = false
        shopListNew["isDeleted"] = false
        
        shopListNew["ItemsCount"] = self.ItemsCount
        shopListNew["CheckedItemsCount"] = self.CheckedItemsCount
        
        shopListNew["ListColorCode"] = "31797D"
        
        let today = NSDate()
        
        shopListNew["creationDate"] = today//self.shopListCreatedAt
        shopListNew["updateDate"] = today//self.shopListUpdatedAt
        
        shopListNew["ServerUpdateDate"] = today.dateByAddingTimeInterval(-120)
        
        shopListNew["ListCurrency"] = self.shopListCurrency
        shopListNew["ShowCats"] = self.shopListShowCats
        shopListNew["CurrencyArray"] = self.shopListCurrencyArray
        
        
        self.newlistId = listuuid
        
        print("New list Id is 111 \(self.newlistId)")
        print("here array is  111 \(self.shopListItemsIn)")

        
        //getting the right to edit the row in DB
        let acl = PFACL()
        //acl.setPublicReadAccess(true)
        //acl.setPublicWriteAccess(true)
        acl.setReadAccess(true, forUserId: self.receiverUser)
        acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
        acl.setWriteAccess(true, forUserId: self.receiverUser)
        acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
        shopListNew.ACL = acl
        
        shopListNew.saveInBackgroundWithBlock {
           // shopListNew.save()
        
            
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                //self.currentList = shopListNew.objectId!
                //self.trycurrent = shopListNew.objectId!
               // println("Current list is \(self.currentList)")
                //self.populatingthelist(self.shopListItemsIn)
               // println(shopListNew.objectId)
                //self.newlistId = shopListNew.objectId!
                print("New list Id is \(self.newlistId)")
                print("here array is \(self.shopListItemsIn)")
                
                self.populatingthelist(self.shopListItemsIn)
                
                
                
                //self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
                
                // println("The list is sent!")
                
                //self.restore()
                
                

                
                // DISPLAY ALERT OF SAVING
            } else {
                // There was a problem, check error.description
                print("Didnt send")
                 self.restore()
                // self.displayAlert("List was not sent!", message: "Maybe problem in the internet connection")
                self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
            }
            
            //println("Current list is \(self.currentList)")
        }
    
    
        /////
        
       
        
        
        /////
  // self.currentList = trycurrent
        print(newlistId)

        //return self.newlistId
       
        
    }
    
    func todonewPFObjectList() {
        
        let uuid = NSUUID().UUIDString
        let listuuid = "todolist\(uuid)"
        
        let todoListNew = PFObject(className:"toDoLists")
        todoListNew["listUUID"] = listuuid
        
        todoListNew["ToDoListName"] = self.todoListName
        todoListNew["ToDoListNote"] = self.todoListNote
        //for user stuff
        todoListNew["BelongsToUser"] = self.todoListBelongsTo
        todoListNew["isReceived"] = self.todoListIsReceived
        todoListNew["isFavourite"] = false
        todoListNew["ShareWithArray"] = []
        todoListNew["SentFromArray"] = self.todoListSentFrom
        todoListNew["ItemsInTheToDoList"] = self.todoListItemsIn
        todoListNew["isSaved"] = self.todoListIsSaved
        //Don't need this original stuff
        //shopListNew["OriginalList"] = self.shopListId // Id of original shop list
        todoListNew["isShared"] = false
        todoListNew["confirmReception"] = false
        todoListNew["isDeleted"] = false
        
        todoListNew["ItemsCount"] = self.todoItemsCount
        todoListNew["CheckedItemsCount"] = self.todoCheckedItemsCount
        
        let today = NSDate()
        
        todoListNew["CreationDate"] = today//self.shopListCreatedAt
        todoListNew["updateDate"] = today//self.shopListUpdatedAt
        todoListNew["ServerUpdateDate"] = today.dateByAddingTimeInterval(-120)
        
        todoListNew["ListColorCode"] = "31797D"
        
        self.todonewlistId = listuuid
        
        print("New list Id is 111 \(self.todonewlistId)")
        print("here array is  111 \(self.todoListItemsIn)")
        
        
        //getting the right to edit the row in DB
        let acl = PFACL()
        //acl.setPublicReadAccess(true)
        //acl.setPublicWriteAccess(true)
        acl.setReadAccess(true, forUserId: self.receiverUser)
        acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
        acl.setWriteAccess(true, forUserId: self.receiverUser)
        acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
        todoListNew.ACL = acl
        
        todoListNew.saveInBackgroundWithBlock {
            // shopListNew.save()
            
            
            (success: Bool, error: NSError?) -> Void in
            if (success) {

                print("New list Id is \(self.todonewlistId)")
                print("here array is \(self.todoListItemsIn)")
                
                self.todopopulatingthelist(self.todoListItemsIn)
                

                
              //  println("The list is sent!")
                
             //   self.restore()
                
                
                
                
                // DISPLAY ALERT OF SAVING
            } else {
                // There was a problem, check error.description
                print("Didnt send")
                self.restore()
                
            //self.displayAlert("List was not sent!", message: "Maybe problem in the internet connection")
            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
            }
            
            //println("Current list is \(self.currentList)")
        }
        
        
        /////
        
        
        
        
        /////
        // self.currentList = trycurrent
        print(todonewlistId)
        
        //return self.newlistId
        
        
    }
    
    /*
    func getID() -> String{
        
        var queryID = PFQuery(className:"shopLists")//:PFQuery = PFUser.query()!
        queryID.whereKey("objectId", equalTo: shopListNew.objectId!)//name.text)
        queryID.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                println("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                println("Successfully retrieved the object.")
                self.receiverUser = object!.objectId!
                
                self.getthelist()
                println("receiver is \(self.receiverUser)")
            }
        }
    }
    */
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
    
    var imagePath = String()
    
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

    
    @IBAction func unwindToSharingVC (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func populatingthelist(shopListItemsIn1: [String]) -> [String] {
        
        
           for var index = 0; index < shopListItemsIn.count; index++ {
                var queryitem = PFQuery(className:"shopItems")
            queryitem.fromLocalDatastore()
            //queryitem.whereKey("objectId", equalTo: shopListItemsIn1[index])
            queryitem.whereKey("itemUUID", equalTo: shopListItemsIn1[index])
             var items = queryitem.findObjects()
           // queryitem.findObjects()
            if (items != nil) {
                
                if let items = items as? [PFObject] {
                
                for object in items {
                    
                                self.itemname = object["itemName"] as! String
                                self.itemnote = object["itemNote"] as! String
                                
                                
                                //   self.itemimage = object["itemImage"] as! PFFile
                               // self.itemLocalImagePath = object["imageLocalPath"] as! String
                                
                               // self.loadImageFromLocalStore(self.itemLocalImagePath)
                                //so, I got the image
                                
                                
                                /////!!! MYABE I NEED THIS, of course a bit before ////
                                if object["isCatalog"] as! Bool == false {
                                   
                                    
                                    if object["defaultpicture"] as! Bool == false {
                                        
                                       
                                        /*
                                        var prodimage = UIImage()
                                        imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                                            if let downloadedImage = UIImage(data: data!) {
                                                prodimage = downloadedImage
                                                //var avatarData = UIImagePNGRepresentation(prodimage)
                                                self.imagefromstore = prodimage
                                                
                                            }
                                        }
                                        */
                                        /*
                                         var imageFile = object["itemImage"] as! PFFile
                                        var imageData = imageFile.getData()
                                        if (imageData != nil) {
                                            var image = UIImage(data: imageData!)
                                            self.imagefromstore = image!
                                            print(image)
                                        } else {
                                            self.imagefromstore = imagestochoose[0].itemimage
                                        }
                        */
                                        
                                        self.itemLocalImagePath = object["imageLocalPath"] as! String
                                        
                                        self.loadImageFromLocalStore(self.itemLocalImagePath)
                                        
                                        self.imagefromstore = imageToLoad
                                        
                                    } else {
                                        
                                        var imagename = object["OriginalInDefaults"] as! String
                                        
                                        if (UIImage(named: "\(imagename)") != nil) {
                                             self.imagefromstore = UIImage(named: "\(imagename)")!
                                        } else {
                                            self.imagefromstore = imagestochoose[0].itemimage// CHANGE PNG LATER
                                        }
                                        
                                    }
                                    
                                    
                                  //  self.itemLocalImagePath = object["imageLocalPath"] as! String
                                    
                                    //self.loadImageFromLocalStore(self.itemLocalImagePath)
                                    
                                    // self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                    
                                    //  self.shoppingListItemsImages2.append(self.imageToLoad)
                                } else {
                                    //if catalog item
                                    //self.shoppingListItemsImages2.append(
                                    //if let founditem = find(lazy(catalogitems).map({ $0.itemId }), (object["originalInCatalog"] as! String)) {
                                    
                                    if let founditem = catalogitems.map({ $0.itemId }).lazy.indexOf((object["originalInCatalog"] as! String)) {
                                        
                                        let catalogitem = catalogitems[founditem]
                                        
                                        self.imagefromstore = catalogitem.itemimage
                                        
                                        
                                    }
                                }
                                /////////
                                
                                self.isdefaultpicture = object["defaultpicture"] as! Bool
                                self.originalindefaults = object["OriginalInDefaults"] as! String
                                
                                
                                self.itemquantity = object["itemQuantity"] as! String
                                self.itemlist = object["ItemsList"] as! String
                                self.itemprice = object["itemPriceS"] as! String
                                self.itemtotalsum = object["TotalSumS"] as! String
                                self.itembelongsto = self.receiverUser//object["belongsToUser"] as! String
                                self.itemchosenfromhistory = object["chosenFromHistory"] as! Bool
                                self.itemunit = object["itemUnit"] as! String
                                
                                self.itemperunit = object["perUnit"] as! String
                                
                                self.itemischecked = object["isChecked"] as! Bool
                                
                                //self.itemiscatalog = object["isCatalog"] as! Bool
                                
                                self.itemcategory = object["Category"] as! String
                                
                                print("Check names and notes, they equal to: \(self.itemname) and \(self.itemnote)")
                                
                                self.itemoriginal = object["originalInCatalog"] as! String
                    
                                if (object["originalInCatalog"] as! NSString).containsString("CustomCatalog")
                                {
                                     self.itemiscatalog = false
                                    
                                } else {
                    
                                self.itemiscatalog = object["isCatalog"] as! Bool
                                
                                }
                    
                                self.itemcreation = object["CreationDate"] as! NSDate
                                self.itemupdate = object["UpdateDate"] as! NSDate
                                
                                //now create new PFObject
                                
                                //var listId: String?
                                var shopItemNew = PFObject(className:"shopItems")
                                
                                var itemuuid = NSUUID().UUIDString
                                
                                shopItemNew["itemUUID"] = itemuuid
                                shopItemNew["itemName"] = self.itemname
                                shopItemNew["itemNote"] = self.itemnote
                                
                                //Now I need to do usual stuff for image -> pffile
                             //   var imageData = UIImagePNGRepresentation(self.imagefromstore)
                              //  var imageFile = PFFile(name:"ReceivedItemImage.png", data:imageData!)
                                
                                
                                
                                
                               // shopItemNew["itemImage"] = imageFile
                                shopItemNew["imageLocalPath"] = ""
                                shopItemNew["itemQuantity"] = self.itemquantity
                                shopItemNew["ItemsList"] = self.newlistId
                                shopItemNew["itemPriceS"] = self.itemprice
                                shopItemNew["TotalSumS"] = self.itemtotalsum
                                shopItemNew["belongsToUser"] = self.itembelongsto
                                shopItemNew["chosenFromHistory"] = self.itemchosenfromhistory
                                shopItemNew["itemUnit"] = self.itemunit
                                shopItemNew["isChecked"] = self.itemischecked
                    
                                shopItemNew["originalInCatalog"] = self.itemoriginal
                    
                    
                    
                                shopItemNew["isCatalog"] = self.itemiscatalog
                    
                                if self.itemiscatalog == false {
                                    
                                    if object["defaultpicture"] as! Bool == true {
                                        shopItemNew["itemImage"] = NSNull()
                                    } else {
                                        var imageData = UIImagePNGRepresentation(self.imagefromstore)
                                        var imageFile = PFFile(name:"ReceivedItemImage.png", data:imageData!)
                                        shopItemNew["itemImage"] = imageFile//object["itemImage"]
                                        
                                    }
                                    
                                } else {
                                    
                                    shopItemNew["itemImage"] = NSNull()
                                }
                    
                                shopItemNew["defaultpicture"] = self.isdefaultpicture
                    
                                shopItemNew["OriginalInDefaults"] = self.originalindefaults
                        
                                shopItemNew["isFav"] = false
                                
                                shopItemNew["chosenFromFavs"] = false
                                
                                shopItemNew["perUnit"] = self.itemperunit
                                var newdate = NSDate()
                                shopItemNew["CreationDate"] = newdate//self.itemcreation
                                shopItemNew["UpdateDate"] = newdate//self.itemupdate
                                shopItemNew["ServerUpdateDate"] = newdate.dateByAddingTimeInterval(-120)
                    
                                shopItemNew["isHistory"] = false
                                shopItemNew["isDeleted"] = false
                                
                                if (self.itemcategory as NSString).containsString("custom") {
                                    shopItemNew["Category"] = "DefaultOthers"
                                    // shopItemNew["isCatalog"] = false // FOR CUSTOM PRESENT IN CATALOG CASE
                                } else {
                                    shopItemNew["Category"] = self.itemcategory
                                    //shopItemNew["isCatalog"] = self.itemiscatalog // FOR CUSTOM PRESENT IN CATALOG CASE
                                }
                                
                                
                                //getting the right to edit the row in DB
                                let acl = PFACL()
                                // acl.setPublicReadAccess(true)
                                // acl.setPublicWriteAccess(true)
                                acl.setReadAccess(true, forUserId: self.receiverUser)
                                acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
                                acl.setWriteAccess(true, forUserId: self.receiverUser)
                                acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
                                shopItemNew.ACL = acl
                    
                                self.newShopListItemsIn.append(itemuuid)
                                print("New list comprises the following items \(self.newShopListItemsIn)")
                    
                                // shopItemNew.saveInBackgroundWithBlock
                                // shopItemNew.saveEventually({ (success: Bool, error: NSError?) -> Void in
                                shopItemNew.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                                    if (success) {

                                       // self.newShopListItemsIn.append(itemuuid)
                                       // println("New list comprises the following items \(self.newShopListItemsIn)")
                                        
                                      //  println("Array before adding is \(self.newShopListItemsIn)")
                                        
                                     //   self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
                                        
                                        //FINALLY!
                                        
                                        
                                        //  println("The item \(shopItemNew.objectId) added to the new list!")
                                        print("The item \(itemuuid) added to the new list!")
                                        // DISPLAY ALERT OF SAVING
                                    } else {
                                        // There was a problem, check error.description
                                       // self.restore()
                                       JSSAlertView().warning(self, title: "Warning!", text: "This item wasn't save in a sent list")

                                        print("Didnt add the item")
                                    }
                                })
                                
                                
                                
                                //  self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
                                
                                
                                /*
                                shopItemNew.saveInBackgroundWithBlock {
                                (success: Bool, error: NSError?) -> Void in
                                if (success) {
                                //self.currentList = shopListNew.objectId!
                                //self.trycurrent = shopListNew.objectId!
                                // println("Current list is \(self.currentList)")
                                
                                self.newShopListItemsIn.append(shopItemNew.objectId!)
                                println("New list comprises the following items \(self.newShopListItemsIn)")
                                
                                
                                
                                println("The item \(shopItemNew.objectId) added to the new list!")
                                // DISPLAY ALERT OF SAVING
                                } else {
                                // There was a problem, check error.description
                                println("Didnt add the item")
                                }
                                
                                //println("Current list is \(self.currentList)")
                                }
                                */
                                // self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
                                
                                // self.currentList = trycurrent
                                
                            }
                    
                    print("Array before adding is \(self.newShopListItemsIn)")
                    
                   // self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
                    
                            /////
                            
                            
                        }
                        
                
                
            } else {
                print("No items to add!")
                //JSSAlertView().warning(self, title: "Warning!", text: "No items in the list.")

            }
            
                   } //end of for loop
        
         self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
        
        
       //self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)
        /*
        if successfulladd == true {
           // successpopulation = true
            
        } else {
           // successpopulation = false
            
        }
*/
        return newShopListItemsIn
    
    }
    
    
    func todopopulatingthelist(todoListItemsIn1: [String]) -> [String] {
        
        
        for var index = 0; index < todoListItemsIn.count; index++ {
            let queryitem = PFQuery(className:"toDoItems")
            queryitem.fromLocalDatastore()
            
    
            //queryitem.whereKey("objectId", equalTo: shopListItemsIn1[index])
            queryitem.whereKey("itemUUID", equalTo: todoListItemsIn1[index])
            
            let items = queryitem.findObjects()
            // queryitem.findObjects()
            if (items != nil) {
                
                if let items = items as? [PFObject] {
                    
                    for object in items {
                        
                        //getting all the info about an item

                        self.todoitemname = object["todoitemname"] as! String
                        self.todoitemnote = object["todoitemnote"] as! String
                        self.todoimportant = object["isImportant"] as! Bool
                        self.todoitemlist = self.todonewlistId//object["ItemsList"] as! String
                        self.todoitembelongsto = self.receiverUser
                        self.todoitemischecked = object["isChecked"] as! Bool
                        
                        self.todoitemcreationdate = object["creationDate"] as! NSDate
                        self.todoitemupdatedate = object["updateDate"] as! NSDate
                        
                        
                        
                        
                        //now create new PFObject
                        
                        //var listId: String?
                        let todoItemNew = PFObject(className:"toDoItems")
                        
                        let uuid = NSUUID().UUIDString
                        let todoitemuuid = "todo\(uuid)"
                        
                        todoItemNew["itemUUID"] = todoitemuuid
                        todoItemNew["todoitemname"] = self.todoitemname
                        todoItemNew["todoitemnote"] = self.todoitemnote
                        todoItemNew["ItemsList"] = self.todonewlistId
                        todoItemNew["BelongsToUser"] = self.todoitembelongsto
                        todoItemNew["isImportant"] = self.todoimportant
                        todoItemNew["isChecked"] = self.todoitemischecked
                        let newtododate = NSDate()
                        todoItemNew["creationDate"] = newtododate//self.todoitemcreationdate
                        todoItemNew["updateDate"] = newtododate//self.todoitemupdatedate
                        todoItemNew["ServerUpdateDate"] = newtododate.dateByAddingTimeInterval(-120)
                        
                        
                        todoItemNew["isDeleted"] = false
                        
                        
                        //getting the right to edit the row in DB
                        let acl = PFACL()
                        // acl.setPublicReadAccess(true)
                        // acl.setPublicWriteAccess(true)
                        acl.setReadAccess(true, forUserId: self.receiverUser)
                        acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
                        acl.setWriteAccess(true, forUserId: self.receiverUser)
                        acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
                        todoItemNew.ACL = acl

                        
                        self.newtodoListItemsIn.append(todoitemuuid)
                        print("New list comprises the following items \(self.newtodoListItemsIn)")
                        // shopItemNew.saveInBackgroundWithBlock
                        // shopItemNew.saveEventually({ (success: Bool, error: NSError?) -> Void in
                        todoItemNew.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                            if (success) {

                                //  println("The item \(shopItemNew.objectId) added to the new list!")
                                print("The item \(todoitemuuid) added to the new list!")
                                // DISPLAY ALERT OF SAVING
                            } else {
                                // There was a problem, check error.description
                                
                                JSSAlertView().warning(self, title: NSLocalizedString("warning", comment: ""), text: NSLocalizedString("wasntsaved", comment: ""))
                                print("Didnt add the item")
                            }
                        })
                        
                        
                        

                        
                    }
                    
                    print("Array before adding is \(self.newtodoListItemsIn)")
                    
                   // self.todoadditemstocreatedlistsarray(self.todonewlistId, itemsarray: self.newtodoListItemsIn)
                    
                    /////
                    
                    
                }
                
                
                
            } else {
                print("No items to add!")
                 JSSAlertView().warning(self, title: NSLocalizedString("warning", comment: ""), text: NSLocalizedString("wasntsaved", comment: ""))
            }
            
          
        
       // self.todoadditemstocreatedlistsarray(self.todonewlistId, itemsarray: self.newtodoListItemsIn)
        
        } //end of for loop
        
         self.todoadditemstocreatedlistsarray(self.todonewlistId, itemsarray: self.newtodoListItemsIn)
        
       // self.todoadditemstocreatedlistsarray(self.todonewlistId, itemsarray: self.newtodoListItemsIn)
        
        //if self.successfulladd {
      //  self.displaySuccessAlert("List sent!", message: "The list was sent successfully. Check the delivery in sharing history")
        
        //self.displayAlert("List sent1111!", message: "The list was sent successfully. Check the delivery in sharing history")
        

        return newtodoListItemsIn
        
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
                

                var currentuseremail = String()
                var currentusername = String()
                ///
                if PFUser.currentUser()?["email"] != nil {
                    currentuseremail = PFUser.currentUser()?["email"] as! String
                } else {
                    currentuseremail = NSLocalizedString("Anonymous", comment: "")
                }
                
                if PFUser.currentUser()?["name"] != nil {
                    currentusername = PFUser.currentUser()?["name"] as! String
                } else {
                    currentusername = NSLocalizedString("AnonUser", comment: "")
                }

                
                shopList.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        self.successfulladd = true
                        self.restore()
                        
                        // The object has been saved.
                        print("Items array was saved!")
                        //self.displayAlert("List sent2222!", message: "The list was sent successfully. Check the delivery in sharing history")
                        self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("listwassent", comment: ""))
                        
                        let userQuery = PFUser.query()
                        userQuery!.whereKey("objectId", equalTo: self.receiverUser)
                        let pushQuery = PFInstallation.query()
                        pushQuery!.whereKey("user", matchesQuery: userQuery!)
                        
                        var push:PFPush = PFPush()
                        push.setQuery(pushQuery)

                        NSLocalizedString("listwassent", comment: "")
                        
                        var alert : String = "\(NSLocalizedString("incomingpush", comment: "")) \(currentusername) (\(currentuseremail))"

                        var data:NSDictionary = ["alert":alert,"badge":"Increment", "sound":"default"]

                        push.setData(data as [NSObject : AnyObject])
                        push.sendPushInBackground()
                        
                        //
                       
                    } else {
                        //self.restore()
                        self.successfulladd = false
                        print("Wasn't saved")
                        self.restore()
                        if error != nil {
                            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        } else {
                            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        }

                        
                    }
                }
                
            }
        }
        
        return successfulladd
    }
    
    func todoadditemstocreatedlistsarray(listid: String, itemsarray: [String]) -> Bool {
        
        
        
        let query = PFQuery(className:"toDoLists")
        query.whereKey("listUUID", equalTo: listid)
        query.getFirstObjectInBackgroundWithBlock() {
            
            (todoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                self.restore()
                print(error)
            } else if let todoList = todoList {
                todoList["ItemsInTheToDoList"] = itemsarray//self.newShopListItemsIn

                
                var currentuseremail = String()
                var currentusername = String()
                ///
                if PFUser.currentUser()?["email"] != nil {
                    currentuseremail = PFUser.currentUser()?["email"] as! String
                } else {
                    currentuseremail = NSLocalizedString("Anonymous", comment: "")
                }
                
                if PFUser.currentUser()?["name"] != nil {
                    currentusername = PFUser.currentUser()?["name"] as! String
                } else {
                    currentusername = NSLocalizedString("AnonUser", comment: "")
                }
                
                
                
                todoList.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        
                        self.successfulladd = true
                         self.restore()
                        // The object has been saved.
                        print("Items array was saved!")

                          self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("listwassent", comment: ""))
                        
                    
                        let userQuery = PFUser.query()
                        userQuery!.whereKey("objectId", equalTo: self.receiverUser)
                        let pushQuery = PFInstallation.query()
                        pushQuery!.whereKey("user", matchesQuery: userQuery!)
                        
                        var push:PFPush = PFPush()
                        push.setQuery(pushQuery)
                        //push.setChannel("Reload")
                        
                        //var alert : NSString = "\(currentusername) is going shopping! Maybe you need something to buy?"
                        
                        var alert : String = "\(NSLocalizedString("incomingtodopush", comment: "")) \(currentusername) (\(currentuseremail))"
                        //  var data:NSDictionary = ["alert":alert,"badge":"0","content-available":"1","sound":""]
                        var data:NSDictionary = ["alert":alert,"badge":"Increment"]
                        // push.setMessage(alert)
                        push.setData(data as [NSObject : AnyObject])
                        push.sendPushInBackground()
                        
                    } else {
                        //self.restore()
                        self.successfulladd = false
                        print("Wasn't saved")
                        // There was a problem, check error.description
                        self.restore()
                        if error != nil {
                          self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        } else {
                            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        }
                    }
                }
            }
        }
        
        return successfulladd
    }


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    /*
    if segue.identifier == "chooseFromContacts" {
    
    let contactsNav = segue.destinationViewController as! UINavigationController
    
    let contactsVC = contactsNav.viewControllers.first as! ShareFromContactsViewController
    
    
    contactsVC.listtoshare = self.listToShare!
    
    
    }
    */
        
        if segue.identifier == "sharinghelp" {
            
            let popoverViewController = segue.destinationViewController as! HelpSharing //UIViewController
            
            
            popoverViewController.preferredContentSize = CGSize(width: 300, height: 340)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            
            
        }
        
        if segue.identifier == "sharinghistory" {
            
            //let toViewController = segue.destinationViewController as! SettingsViewController
            //let navVC = segue.destinationViewController as! UINavigationController
            
            //let shareVC = navVC.viewControllers.first as! SharingHistoryTableViewController
            //let shareVC = segue.destinationViewController as! SharingHistoryTableViewController
            let tabVC = segue.destinationViewController as! UITabBarController//UINavigationController
            
            let eventsVC = tabVC.viewControllers!.first as! UINavigationController //EventsVC
            
            let VC = eventsVC.viewControllers.first as! SharingHistoryTableViewController
            
            VC.sendercontroller = "SharingVC"
            
            
        }
        
        if segue.identifier == "choosefromcontsegue" {
            

            let contVC = segue.destinationViewController as! ContactsViewController
            contVC.delegate = self
            
            
        }
    
        
    }
    
    
    
    /* BEGINNING OF OLD APPROACH
    func gettingrequireduser() {
        //getting the user with typed email
        var queryreceiver:PFQuery = PFUser.query()!//:PFQuery = PFUser.query()!
        queryreceiver.whereKey("email", equalTo: name.text)
        queryreceiver.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let users = objects as? [PFObject] {
                    for object in users {
                        self.receiverUser = object.objectId
                        
                        self.gettingarrayofuser()
                        
                        self.addingtoarray()
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func gettingarrayofuser() {
        //getting the array of users who this list belongs to
        var querybelongs = PFQuery(className:"shopLists")
        querybelongs.getObjectInBackgroundWithId(listToShare!) {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                
                self.BelongsToUsers = shopList["BelongsToUsers"] as! [String]
                self.ShareWithUsers = shopList["ShareWithArray"] as! [String]
                
                
                //shopList.saveInBackground() // because of that I got the void array in BelongsToUsers
            }
        }
        
        //self.BelongsToUsers.append(self.receiverUser!)
        //self.ShareWithUsers.append(self.receiverUser!)
    }
    
    func addingtoarray() {
        
        //adding this receiverUser Id to the array if users who this list belongs to!
        var queryupdate = PFQuery(className:"shopLists")
        queryupdate.getObjectInBackgroundWithId(listToShare!) {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                let acl = PFACL()
                acl.setPublicReadAccess(true)
                acl.setPublicWriteAccess(true)
                shopList.ACL = acl
                
               self.BelongsToUsers.append(self.receiverUser!)
               self.ShareWithUsers.append(self.receiverUser!)
                shopList["BelongsToUsers"] = self.BelongsToUsers
                shopList["ShareWithArray"] = self.ShareWithUsers
                
                //giving permission to edit, although to everyone
                
                
                //giving permission to edit only for receiver user - doesn't work properly
               // let acl = PFACL()
               // acl.getWriteAccessForUserId(self.receiverUser!)
               // shopList.ACL = acl
                
                shopList.saveInBackground()
            }
        }

    }
    
    @IBAction func sharebutton(sender: AnyObject) {
        
        //sharing stuff here
        
        gettingrequireduser()
        
        
        
    
      
    }
    */ // END OF OLD APPROACH
    
    func sharewithcontact(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! NewShareContactCell
        let indexPathToShare = tableView.indexPathForCell(cell)
        
        let emailforsend = usercontacts[indexPathToShare!.row].contactemail//contactsemails[indexPathToShare!.row]
        
        //println([contactsnames[indexPathToShare!.row], emailforsend])
        print([usercontacts[indexPathToShare!.row].contactname, emailforsend])
        
        if listToShareType == "Shop" {
        
        gettingrequireduser(emailforsend)
        } else if listToShareType == "ToDo" {
            todogettingrequireduser(emailforsend)
        }
        sampleData.removeAll(keepCapacity: true)
    }
    
    /*
    func retrieveContactsList() {
        
        var contactquery:PFQuery = PFUser.query()!
        contactquery.fromLocalDatastore()
        contactquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        contactquery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                self.contactsarray.removeAll(keepCapacity: true)
                self.contactsnames.removeAll(keepCapacity: true)
                self.contactsemails.removeAll(keepCapacity: true)
                self.contactsavatars.removeAll(keepCapacity: true)
                
                if let users = objects as? [PFObject] {
                    for object in users {
                        println(object.objectId)
                        //self.contactsarray.append(object["UserContacts"] as! [[String : String]])
                        if object["UserContacts"] != nil {
                            self.contactsarray = (object["UserContacts"] as! [[AnyObject]]) //getting the contacts array
                            
                            println(self.contactsarray)
                            self.tableView.reloadData()
                            
                            for element in self.contactsarray {
                                
                                self.contactsnames.append(element[0] as! String)
                                self.contactsemails.append(element[1] as! String)
                                self.contactsavatars.append(element[2] as! PFFile)
                                
                                
                                
                                //self.contactsavatars.append(element[2] as! UIImage)
                            }
                        } else {
                            println("no contacts so far")
                        }
                        println("my contacts emails are \(self.contactsemails)")
                        println("my contacts names are \(self.contactsnames)")
                        self.tableView.reloadData()
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        
    }
    */
    
    ////// EMAIL STUFF 
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertView(title: NSLocalizedString("CantSend", comment: ""), message: NSLocalizedString("NoEmailInfo", comment: ""), delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    // func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func returnEmailStringBase64EncodedImage(image:UIImage) -> String {
        let imgData:NSData = UIImagePNGRepresentation(image)!;
        let dataString = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return dataString
    }
    
    
     let messageComposer = MessageComposer()
    
    func savetogal() {
        delegate?.savetogallery()
        UIImageWriteToSavedPhotosAlbum(messageimage, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    


func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
    if error == nil {
        displaySuccessAlert(NSLocalizedString("savetogal", comment: ""), message: NSLocalizedString("savetogalmes", comment:""))
    } else {
        displayFailAlert(NSLocalizedString("notsavetogal", comment: ""), message: NSLocalizedString("notsavetogalmes", comment:""))
    }
}


    func sendimessagepicture() {
        
     
        
       delegate?.createpicture()
        
        
        var messagebody : String = ""
        
      //  let greetingsmesshop = NSLocalizedString("greetingsshop", comment: "")
       // let greetingsmestodo = NSLocalizedString("greetingstodo", comment: "")
        
        if listToShareType == "Shop" {
            
           // messagebody = greetingsmesshop
        } else if listToShareType == "ToDo" {
            
            // messagebody = greetingsmestodo
            
                   }

        
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewControllerPicture(messagebody)
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            self.showSendMailErrorAlert()
        }
        
        
    }
    
    
    func sendimessage() {
        
        var messagebody : String = ""

        
        var eitemname = [String]()
        var eitemnote = [String]()
        var eitemqty = [String]()
        var eitemunit = [String]()
         var emailitems = [String]()
        
        var etodoitemname = [String]()
        var etodoitemnote = [String]()
        var etodoimportant = [String]()

        
        if listToShareType == "Shop" {
            
            let querylist = PFQuery(className:"shopLists")
            querylist.fromLocalDatastore()
            querylist.whereKey("listUUID", equalTo: listToShare!)
            //querylist.findObjectsInBackgroundWithBlock {
            
            let lists = querylist.findObjects()
            // queryitem.findObjects()
            if (lists != nil) {
                
                if let lists = lists as? [PFObject] {
                    
                    for object in lists {

                        
                        emailitems = object["ItemsInTheShopList"] as! [String]
                        /////// ITEMS INFO
                        
                        for var index = 0; index < emailitems.count; index++ {
                            let queryitem = PFQuery(className:"shopItems")
                            queryitem.fromLocalDatastore()
                            queryitem.limit = 1
                            queryitem.whereKey("itemUUID", equalTo: emailitems[index])
                            let items = queryitem.findObjects()
                            
                            if (items != nil) {
                                
                                if let items = items as? [PFObject] {
                                    
                                    for object in items {
                                        
                                        eitemname.append(object["itemName"] as! String)
                                        eitemnote.append(object["itemNote"] as! String)
                                        eitemqty.append(object["itemQuantity"] as! String)
                                        eitemunit.append(object["itemUnit"] as! String)
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                            } else {
                                print("No items to add!")
                                //  JSSAlertView().warning(self, title: "Warning!", text: "No items in the list.")
                                
                            }
                            
                        }
                        print(eitemname)
                        /////// END ITEMS INFO
                        
                        self.restore()
                        
                    }
                }
            } else {
                
                self.restore()
                
                self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                
            }
            
        }  /////// END OF SHOP LIST CASE
        else {
            
            
            let querylist = PFQuery(className:"toDoLists")
            querylist.fromLocalDatastore()
            querylist.whereKey("listUUID", equalTo: listToShare!)
            //querylist.findObjectsInBackgroundWithBlock {
            
            let lists = querylist.findObjects()
            // queryitem.findObjects()
            if (lists != nil) {
                
                if let lists = lists as? [PFObject] {
                    
                    for object in lists {
                        
                        
                        emailitems = object["ItemsInTheToDoList"] as! [String]
                        
                        /////// ITEMS INFO
                        
                        for var index = 0; index < emailitems.count; index++ {
                            let queryitem = PFQuery(className:"toDoItems")
                            queryitem.fromLocalDatastore()
                            queryitem.limit = 1
                            queryitem.whereKey("itemUUID", equalTo: emailitems[index])
                            let items = queryitem.findObjects()
                            
                            if (items != nil) {
                                
                                if let items = items as? [PFObject] {
                                    
                                    for object in items {
                                        
                                        etodoitemname.append(object["todoitemname"] as! String)
                                        etodoitemnote.append(object["todoitemnote"] as! String)
                                        if object["isImportant"] as! Bool == true {
                                            etodoimportant.append(NSLocalizedString("todoimportant", comment: ""))
                                        } else {
                                            etodoimportant.append("")
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                            } else {
                                print("No items to add!")
                                //JSSAlertView().warning(self, title: "Warning!", text: "No items in the list.")
                                
                            }
                            
                        }
                        print(eitemname)
                        /////// END ITEMS INFO
                        
                        self.restore()
                        
                    }
                }
            } else {
                
                self.restore()
                
                self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                
            }
            
            
            
        }
        
        
     //   var greetingsmesshop = NSLocalizedString("greetingsshop", comment: "")
      //  var greetingsmestodo = NSLocalizedString("greetingstodo", comment: "")
        
        if listToShareType == "Shop" {
            
            
            
            for var i = 0; i < eitemname.count; i++ {
                
                if eitemnote[i] != "" {
                
                messagebody = messagebody + "\(eitemname[i]) (\(eitemnote[i])), \(eitemqty[i]) \(eitemunit[i])\n"
                } else {
                     messagebody = messagebody + "\(eitemname[i]), \(eitemqty[i]) \(eitemunit[i])\n"
                }
            }
            
           // messagebody = greetingsmesshop + "\n" + messagebody
            
        } else if listToShareType == "ToDo" {
            for var j = 0; j < etodoitemname.count; j++ {
                messagebody = messagebody + "\(etodoitemname[j]) (\(etodoitemnote[j])) - \(etodoimportant[j])\n"
            }
          // messagebody = greetingsmestodo + "\n" + messagebody
        }

        
        
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(messagebody)
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
           self.showSendMailErrorAlert()
        }
    }
   
    
    
    func sendemail() { //BIGSENDER
        
    
       
        
       
        
       // if !((receivermail as NSString).containsString("@")) {
          //  self.displayFailAlert(NSLocalizedString("wrongemail", comment: ""), message: NSLocalizedString("validemail", comment: ""))
       // } else {
            
        
        
        ///getting special format items
        // LIST VARS
        var emaillistname = String()
        var emaillistnote = String()
        var emailsendername = String()
        var emailsenderemail = String()
        var emailitems = [String]()
        
            
        // ITEMS VARS
        var eitemname = [String]()
        var eitemnote = [String]()
        var eitemqty = [String]()
        var eitemunit = [String]()
            
            // TO DO ITEMS VARS
            var etodoitemname = [String]()
            var etodoitemnote = [String]()
            var etodoimportant = [String]()
            
        
        
        //// SHOP LIST CASE BEGIN
            if listToShareType == "Shop" {
            
       
        
        

            let querylist = PFQuery(className:"shopLists")
            querylist.fromLocalDatastore()
            querylist.whereKey("listUUID", equalTo: listToShare!)
            //querylist.findObjectsInBackgroundWithBlock {
        
            let lists = querylist.findObjects()
            // queryitem.findObjects()
            if (lists != nil) {
            
            if let lists = lists as? [PFObject] {
                
                for object in lists {
        

                            emaillistname = object["ShopListName"] as! String
                            emaillistnote = object["ShopListNote"] as! String
                    
                    
                    
                            emailsendername = loggedusername//PFUser.currentUser()?["name"] as! String//PFUser.currentUser()!["name"] //username!

                            if PFUser.currentUser()!.email != nil {
                                emailsenderemail = PFUser.currentUser()!.email!
                            } else {
                                emailsenderemail = "Unknown email"

                            }
 
                            emailitems = object["ItemsInTheShopList"] as! [String]
                    
                            /////// ITEMS INFO
                    
                    for var index = 0; index < emailitems.count; index++ {
                        let queryitem = PFQuery(className:"shopItems")
                        queryitem.fromLocalDatastore()
                        queryitem.limit = 1
                        queryitem.whereKey("itemUUID", equalTo: emailitems[index])
                        let items = queryitem.findObjects()

                        if (items != nil) {
                            
                            if let items = items as? [PFObject] {
                                
                                for object in items {
                                    
                                    eitemname.append(object["itemName"] as! String)
                                    eitemnote.append(object["itemNote"] as! String)
                                    eitemqty.append(object["itemQuantity"] as! String)
                                    eitemunit.append(object["itemUnit"] as! String)
                               
                                }
                                
                                

                            }
                            
                            
                        } else {
                            print("No items to add!")
                          //  JSSAlertView().warning(self, title: "Warning!", text: "No items in the list.")
                            
                        }
                        
                    }
                    print(eitemname)
                            /////// END ITEMS INFO
                    
                    self.restore()
                            
                        }
                    }
                } else {

                    self.restore()

                self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))

                }
        
            }  /////// END OF SHOP LIST CASE
            else {
                
              
                
                
                
                let querylist = PFQuery(className:"toDoLists")
                querylist.fromLocalDatastore()
                querylist.whereKey("listUUID", equalTo: listToShare!)
                //querylist.findObjectsInBackgroundWithBlock {
                
                let lists = querylist.findObjects()
                // queryitem.findObjects()
                if (lists != nil) {
                    
                    if let lists = lists as? [PFObject] {
                        
                        for object in lists {
                            
                            
                            emaillistname = object["ToDoListName"] as! String
                            emaillistnote = object["ToDoListNote"] as! String
                            emailsendername = loggedusername//PFUser.currentUser()?["name"] as! String//PFUser.currentUser()!.username!
                            
                            if PFUser.currentUser()!.email != nil {
                                emailsenderemail = PFUser.currentUser()!.email!
                            } else {
                                emailsenderemail = NSLocalizedString("unknownemail", comment: "")
                                
                            }
                            
                            emailitems = object["ItemsInTheToDoList"] as! [String]
                            
                            /////// ITEMS INFO
                            
                            for var index = 0; index < emailitems.count; index++ {
                                let queryitem = PFQuery(className:"toDoItems")
                                queryitem.fromLocalDatastore()
                                queryitem.limit = 1
                                queryitem.whereKey("itemUUID", equalTo: emailitems[index])
                                let items = queryitem.findObjects()
                                
                                if (items != nil) {
                                    
                                    if let items = items as? [PFObject] {
                                        
                                        for object in items {
                                            
                                            etodoitemname.append(object["todoitemname"] as! String)
                                            etodoitemnote.append(object["todoitemnote"] as! String)
                                            if object["isImportant"] as! Bool == true {
                                                etodoimportant.append(NSLocalizedString("todoimportant", comment: ""))
                                            } else {
                                                etodoimportant.append("")
                                            }
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                } else {
                                    print("No items to add!")
                                    //JSSAlertView().warning(self, title: "Warning!", text: "No items in the list.")
                                    
                                }
                                
                            }
                            print(eitemname)
                            /////// END ITEMS INFO
                            
                            self.restore()
                            
                        }
                    }
                } else {
                    
                    self.restore()
                    
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                    
                }
                
            }
        
        /// end getting special format items
        
        if( MFMailComposeViewController.canSendMail() ) {
        print("Can send email.")
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        //Set the subject and message of the email
        mailComposer.setToRecipients([""])
            
            let eappname = NSLocalizedString("appname", comment: "")
            let eyoureceived = NSLocalizedString("youreceived", comment: "")
        mailComposer.setSubject("\(eappname): \(eyoureceived)")
            
            
            let incoming = NSLocalizedString("incom", comment: "") //Incoming list!
            let recfrom = NSLocalizedString("recfrom", comment: "") //Received from:
            let availableapp = NSLocalizedString("availableapp", comment: "")
            let elistinfoname = NSLocalizedString("emaillistname", comment: "")
            let elistinfonote = NSLocalizedString("emaillistnote", comment: "")
            let inthelist = NSLocalizedString("inthelist", comment: "")
            ////
            var body: String = "<body><div style = \"background-color: #ffffff; padding-left: 0px; padding-right:0px; margin-top: 10px; margin-bottom: 10px;\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"90%\" height=\"30\" valign=\"middle\"><h2 style = \"color: #2a2f36;\">\(incoming)</h2></td></tr><tr><td width=\"90%\" height=\"30\" valign=\"middle\"><span style = \"color: #2a2f36; font-weight: bold; font-size:11px;\"> \(recfrom) \(emailsendername) , <em>Email: \(emailsenderemail)</em></span></td></tr><tr><td width=\"90%\" height=\"30\" valign=\"middle\"><span style = \"color: #2a2f36; font-weight: bold; font-size:12px;\"> \(elistinfoname) <strong>\(emaillistname)</strong></span></td></tr><tr><td width=\"90%\" height=\"30\" valign=\"middle\"><span style = \"color: #2a2f36; font-weight: bold; font-size:11px;\"> \(elistinfonote) <em>\(emaillistnote)</em></span></td></tr></table></div>"
            
            var body2 :String =   "<div style = \"background-color: #FAFAFA; padding-left: 0px; padding-right: 0px;\"><table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style = \"border-top: 1px solid #333; border-right: 1px solid #333; border-left: 1px solid #333\"><tr><td height=\"30\" colspan=\"2\" valign=\"middle\" style = \"border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #333; border-right-width: 1px; border-right-style: solid; border-right-color: #333; padding-left:7px; padding-right:7px; background-color: #2a2F36;\"><span style = \"color: #FAFAFA; font-weight: bold; font-size:14px;\">\(inthelist)</span></td></tr>"
            ////
            
       // var body: String = "<html><body><h1>New list!</h1>" //<br/>"
        var itemsbody : String = ""
            
            
            var avimage = UIImage(named:"DownloadFromAppStore")!// your image here
            var imageString = returnEmailStringBase64EncodedImage(avimage)
            var emailBody = "<img src='data:image/png;base64,\(imageString)' width='\(avimage.size.width)' height='\(avimage.size.height)'>"
            var wrongemail = NSLocalizedString("wrongsendemail", comment: "")

            
            let appinfo : String = "<div style = \"background-color: #FFFFFF; padding-left: 0px; padding-right:0px; margin-top: 10px;\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td align=\"middle\"><span style = \"color: #2a2f36; font-weight: bold; font-size:14px;\"> \(availableapp)</span></td></tr><tr><td width=\"100%\" height=\"30\" align=\"middle\"valign=\"middle\" style=\"padding-top: 10px;\"><a href = \"https://itunes.apple.com/us/app/get-me-food-grocery-shopping/id1083564553\"><img src='data:image/png;base64,\(imageString)' width='\(avimage.size.width)' height='\(avimage.size.height)' align=\"absmiddle\"></td></tr><tr><td align=\"middle\"><span style = \"color: #898989; font-weight: bold; font-size:11px;\"> \(wrongemail)</span></td></tr></table></div>"
           
            
       // body = body + "<div><p>Recevied from: \(emailsendername), Email: \(emailsenderemail)</p><p>List: \(emaillistname)</p><p>Note: \(emaillistnote)</p></div><div><p><h2>Following items are in the list:</h2></p></div>"
          
       //body = body + "<div><img src='data:image/png;base64,\(base64String)' height='100' width='150'/></div>"
        if listToShareType == "Shop" {
            
        for var i = 0; i < eitemname.count; i++ {
            itemsbody = itemsbody + "<tr><td style = \"border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #333; border-right-width: 1px; border-right-style: solid; border-right-color: #333; padding-left:7px; padding-right:7px\" width=\"80%\" height=\"30\" valign=\"middle\"><span style = \"color: #31797D; font-weight: bold; font-size:14px;\">\(eitemname[i])</span><span style = \"color: #31797D; font-weight: bold; font-size:10px;\"> <em>\(eitemnote[i])</em></span></td><td width=\"20%\" height=\"30\" align=\"center\" valign=\"middle\" style = \"border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #333; padding-left:7px; padding-right:7px\"><span style = \"color: #F23D55; font-weight: bold; font-size:12px;\">\(eitemqty[i]) \(eitemunit[i])</span></td></tr>"
            //"<div style=\"border:1px solid #F97F00; background-color: #EBE7E7; padding-left: 7px\"><p><span style=\"color: #225378; font-weight:bold; margin-top: 1px; font-size: 14px\">\(eitemname[i])</span></p><p><span style=\"color: #9E9D9D; font-weight:normal; margin-top: 1px; font-size: 14px\">\(eitemnote[i])</span></p><p><span style=\"color: #1695A3; font-weight:bold; margin-top: 1px; font-size: 14px\">\(eitemqty[i]) \(eitemunit[i])</span></p></div>"
        }
        print(itemsbody)
            
            } else if listToShareType == "ToDo" {
                for var i = 0; i < etodoitemname.count; i++ {
                    itemsbody = itemsbody + "<tr><td style = \"border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #333; border-right-width: 1px; border-right-style: solid; border-right-color: #333; padding-left:7px; padding-right:7px\" width=\"80%\" height=\"30\" valign=\"middle\"><span style = \"color: #31797D; font-weight: bold; font-size:14px;\">\(etodoitemname[i])</span><span style = \"color: #31797D; font-weight: bold; font-size:10px;\"> \(etodoitemnote[i])</span></td><td width=\"20%\" height=\"30\" align=\"center\" valign=\"middle\" style = \"border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #333; padding-left:7px; padding-right:7px\"><span style = \"color: #F23D55; font-weight: bold; font-size:12px;\">\(etodoimportant[i])</span></td></tr>"
                    //"<div style=\"border:1px solid #F97F00; background-color: #EBE7E7; padding-left: 7px\"><p><span style=\"color: #225378; font-weight:bold; margin-top: 1px; font-size: 14px\">\(etodoitemname[i])</span></p><p><span style=\"color: #9E9D9D; font-weight:normal; margin-top: 1px; font-size: 14px\">\(etodoitemnote[i])</span></p><p><span style=\"color: #1695A3; font-weight:bold; margin-top: 1px; font-size: 14px\">\(etodoimportant[i])</span></p></div>"
                }
                print(itemsbody)
            }
            
            var closing = "</table></div>"
            
        body = body + body2 + itemsbody + closing + appinfo + "</body></html>"
        mailComposer.setMessageBody(body, isHTML: true)
        
       
            
            
        self.presentViewController(mailComposer, animated: true, completion: nil)
            
        } else {
            self.showSendMailErrorAlert()
        }
        
       // } // END OF EMAIL @ CHECK
    }

    ///// END OF EMAIL STUFF
    
    /// Text field stuff
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        lineview.backgroundColor = UIColorFromRGB(0x31797D)
        name.textInputView.tintColor = UIColorFromRGB(0x31797D)
        
        return
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if name.text! == "" {
            lineview.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
        } else {
            lineview.backgroundColor = UIColorFromRGB(0x31797D)
        }

        
        textField.resignFirstResponder()
        return true
    }
    //myTextField.delegate = self
    ///
    
  
    
    
    /// show loading function 
    func changeloadingresult(success: Bool, label: UILabel, imageview: UIImageView, indicator : NVActivityIndicatorView)
    {
        if success {
            
            indicator.hidden = true
            
            label.text = NSLocalizedString("successload", comment: "")
            imageview.image = succespict
            //imageview.fadeIn()
            imageview.alpha = 1
            
        } else {
            
            indicator.hidden = true
            
            imageview.image = errorpict
           // imageview.fadeIn()
            imageview.alpha = 1

            label.text = NSLocalizedString("errorload", comment: "")
            
        }
        
    }
    
    func loading(show: Bool) {
        
        
        let dimmer : UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        dimmer.backgroundColor = UIColorFromRGB(0x2A2F36)
        dimmer.alpha = 0.3
        
        let viewframe = CGRectMake(self.view.frame.width / 2 - 50, self.view.frame.height / 2 - 50, 100, 100)
        let loadingview: UIView = UIView(frame: viewframe);
        
        let indicator : NVActivityIndicatorView =  NVActivityIndicatorView(frame: CGRectMake(22, 8, 56, 56), type: .BallSpinFadeLoader, color: UIColorFromRGB(0x1EB2BB))
        
        let labelview = UILabel(frame: CGRectMake(8, 71, 84, 26))
        
        let imageview = UIImageView(frame: CGRectMake(22, 8, 56, 56))
        imageview.alpha = 0
        
        loadingview.addSubview(indicator)
        loadingview.addSubview(labelview)
        loadingview.addSubview(imageview)
        
        dimmer.tag = 871
        loadingview.tag = 872
        labelview.tag = 873
        imageview.tag = 874
        
        
        if show {
        
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
        self.view.addSubview(dimmer)
        dimmer.sendSubviewToBack(self.view)
        self.view.addSubview(loadingview)
            
        
            
        } else {
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 2)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                if let viewWithTag = self.view.viewWithTag(871) {
                    viewWithTag.removeFromSuperview()
                }
                if let viewWithTag = self.view.viewWithTag(872) {
                    viewWithTag.removeFromSuperview()
                }

            })
            /*
            if let viewWithTag = self.view.viewWithTag(871) {
                viewWithTag.removeFromSuperview()
            }
            if let viewWithTag = self.view.viewWithTag(872) {
                viewWithTag.removeFromSuperview()
            }
            */
            
            
            
        }
        
    }
    
    
    func loading_simple(show: Bool) {
        
        
        let dimmer : UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        dimmer.backgroundColor = UIColorFromRGB(0x2A2F36)
        dimmer.alpha = 0.3
        
        let viewframe = CGRectMake(self.view.frame.width / 2 - 50, self.view.frame.height / 2 - 50, 100, 100)
        let loadingview: UIView = UIView(frame: viewframe);
        loadingview.backgroundColor = UIColor.whiteColor()
        loadingview.layer.cornerRadius = 12
        
        let indicator : NVActivityIndicatorView =  NVActivityIndicatorView(frame: CGRectMake(20, 20, 60, 60), type: NVActivityIndicatorType.BallClipRotate, color: UIColorFromRGB(0x1EB2BB))
        
        
        loadingview.addSubview(indicator)
        
        
        
        dimmer.tag = 871
        loadingview.tag = 872

        
        
        if show {
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            self.view.addSubview(dimmer)
            dimmer.sendSubviewToBack(self.view)
            self.view.addSubview(loadingview)
            
            indicator.startAnimation()

        } else {
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
             if let viewWithTag = self.view.viewWithTag(871) {
             viewWithTag.removeFromSuperview()
             }
             if let viewWithTag = self.view.viewWithTag(872) {
             viewWithTag.removeFromSuperview()
             }
            
        }
        
    }
    
    
    @IBOutlet var lineview: UIView!
    
    @IBOutlet var indicator: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("List is \(listToShare)")
        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView()
        
        name.delegate = self
        name.leftTextMargin = 1//5
        
        //name.layer.borderWidth = 1
        //name.layer.borderColor = UIColorFromRGB(0xE8E8E8).CGColor
       // name.layer.cornerRadius = 4
        
        
       // self.generateData()
        name.mDelegate = self
        
       // self.retrieveContactsList()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.generateData()
       // name.mDelegate = self
    
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 5//3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
       /* if section == 5 {
            return usercontacts.count//contactsemails.count
        }*/
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        
          return 52
        

    }

    /*
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 5 {
            return NSLocalizedString("choosecontacts", comment: "")
        } else if section == 0 {
            return NSLocalizedString("otheroptions", comment: "")
        }
                return nil
    }
 */
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }
    /*
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 5 {
        return 30
        } else if section == 0 {
            return 30
        } else {
            return 0
        }
    }
    */
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    /*
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 5 {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColorFromRGB(0xEFEFEF)//UIColor(red: 238/255, green: 168/255, blue: 15/255, alpha: 0.8)
        header.textLabel!.textColor = UIColorFromRGB(0x2A2F36)//UIColor.whiteColor()
        header.alpha = 1
        
        var topline = UIView(frame: CGRectMake(0, 0, header.contentView.frame.size.width, 1))
        topline.backgroundColor = UIColorFromRGB(0x31797D)
        
        header.contentView.addSubview(topline)
        
        var bottomline = UIView(frame: CGRectMake(0, 30, header.contentView.frame.size.width, 1))
        bottomline.backgroundColor = UIColorFromRGB(0x31797D)
        
        header.contentView.addSubview(bottomline)
        
        }
        
        if section == 0 {
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.backgroundColor = UIColorFromRGB(0xEFEFEF)//UIColor(red: 238/255, green: 168/255, blue: 15/255, alpha: 0.8)
            header.textLabel!.textColor = UIColorFromRGB(0x2A2F36)//UIColor.whiteColor()
            header.alpha = 1
            
            var topline = UIView(frame: CGRectMake(0, 0, header.contentView.frame.size.width, 1))
            topline.backgroundColor = UIColorFromRGB(0x31797D)
            
            header.contentView.addSubview(topline)
            
            var bottomline = UIView(frame: CGRectMake(0, 30, header.contentView.frame.size.width, 1))
            bottomline.backgroundColor = UIColorFromRGB(0x31797D)
            
            header.contentView.addSubview(bottomline)
            
        }
        
    }
    */
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sharecell: UITableViewCell!
        var textmescell: messagelistcell!
        var pictmescell: picmescell!
        var galcell: savegalcell!
        var emailcell: Sendbyemailcell!
       
      
        if (indexPath.section == 0) {
            emailcell = tableView.dequeueReusableCellWithIdentifier("printthelist", forIndexPath: indexPath) as! Sendbyemailcell

        } else if (indexPath.section == 1) {
  textmescell = tableView.dequeueReusableCellWithIdentifier("messagelist", forIndexPath: indexPath) as! messagelistcell
    

        } else if (indexPath.section == 2) {
            pictmescell = tableView.dequeueReusableCellWithIdentifier("messagepictcell", forIndexPath: indexPath) as! picmescell
            
            
            if senderVC == "AllListsVC" {
                pictmescell.userInteractionEnabled = false
                pictmescell.alpha = 0.4
                pictmescell.label.alpha = 0.4
                pictmescell.picture.alpha = 0.4
            } else if senderVC == "ShopCreationVC" {
                pictmescell.userInteractionEnabled = true
                pictmescell.alpha = 1
                pictmescell.label.alpha = 1
                pictmescell.picture.alpha = 1
            }
            
            
        } else if (indexPath.section == 3) {
        galcell = tableView.dequeueReusableCellWithIdentifier("savetogallery", forIndexPath: indexPath) as! savegalcell
        

        if senderVC == "AllListsVC" {
            galcell.userInteractionEnabled = false
            galcell.alpha = 0.4
            galcell.label.alpha = 0.4
            galcell.picture.alpha = 0.4
        } else if senderVC == "ShopCreationVC" {
            galcell.userInteractionEnabled = true
            galcell.alpha = 1
            galcell.label.alpha = 1
            galcell.picture.alpha = 1
        }
        
       }  else if (indexPath.section == 4) {
            sharecell = tableView.dequeueReusableCellWithIdentifier("sharinghistory", forIndexPath: indexPath)
        }
        
       if indexPath.section == 0 {
            
            return emailcell
            
        } else if indexPath.section == 1 {
                
                return textmescell
            
        } else if indexPath.section == 2 {
            
            return pictmescell
            
        } else if indexPath.section == 3 {
            
            return galcell
            
        } else if indexPath.section == 4 {
            
            return sharecell
            
        } else {
    
       return sharecell
        }
     
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
        
          self.sendemail()
            
        } else if indexPath.section == 1 {
            
            self.sendimessage()
            
        } else if indexPath.section == 2 {
    
            self.sendimessagepicture()
    
        } else if indexPath.section == 3 {
            
            self.savetogal()
            
        }
    
    
    
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //println(self.shoppingListItemsIds[row])
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


/////// PREVIOUS APPROACH!
/*
queryitem.findObjectsInBackgroundWithBlock {

(objects: [AnyObject]?, error: NSError?) -> Void in
if error == nil {
println("Successfully retrieved \(objects!.count) scores.")
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
println(object.objectId)
//getting all the info about an item
self.itemname = object["itemName"] as! String
self.itemnote = object["itemNote"] as! String


//   self.itemimage = object["itemImage"] as! PFFile
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
if let founditem = find(lazy(catalogitems).map({ $0.itemId }), (object["originalInCatalog"] as! String)) {
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
self.itemchosenfromhistory = object["chosenFromHistory"] as! Bool
self.itemunit = object["itemUnit"] as! String

self.itemperunit = object["perUnit"] as! String

self.itemischecked = object["isChecked"] as! Bool

self.itemiscatalog = object["isCatalog"] as! Bool

self.itemcategory = object["Category"] as! String

println("Check names and notes, they equal to: \(self.itemname) and \(self.itemnote)")

self.itemoriginal = object["originalInCatalog"] as! String

self.itemcreation = object["CreationDate"] as! NSDate
self.itemupdate = object["UpdateDate"] as! NSDate

//now create new PFObject

//var listId: String?
var shopItemNew = PFObject(className:"shopItems")

var itemuuid = NSUUID().UUIDString

shopItemNew["itemUUID"] = itemuuid
shopItemNew["itemName"] = self.itemname
shopItemNew["itemNote"] = self.itemnote

//Now I need to do usual stuff for image -> pffile
var imageData = UIImagePNGRepresentation(self.imagefromstore)
var imageFile = PFFile(name:"ReceivedItemImage.png", data:imageData)




shopItemNew["itemImage"] = imageFile
shopItemNew["imageLocalPath"] = ""
shopItemNew["itemQuantity"] = self.itemquantity
shopItemNew["ItemsList"] = self.newlistId
shopItemNew["itemPrice"] = self.itemprice
shopItemNew["TotalSum"] = self.itemtotalsum
shopItemNew["belongsToUser"] = self.itembelongsto
shopItemNew["chosenFromHistory"] = self.itemchosenfromhistory
shopItemNew["itemUnit"] = self.itemunit
shopItemNew["isChecked"] = self.itemischecked
shopItemNew["isCatalog"] = self.itemiscatalog
shopItemNew["originalInCatalog"] = self.itemoriginal

shopItemNew["isFav"] = false

shopItemNew["chosenFromFavs"] = false

shopItemNew["perUnit"] = self.itemperunit

shopItemNew["CreationDate"] = self.itemcreation
shopItemNew["UpdateDate"] = self.itemupdate

if (self.itemcategory as NSString).containsString("custom") {
shopItemNew["Category"] = "DefaultOthers"
// shopItemNew["isCatalog"] = false // FOR CUSTOM PRESENT IN CATALOG CASE
} else {
shopItemNew["Category"] = self.itemcategory
//shopItemNew["isCatalog"] = self.itemiscatalog // FOR CUSTOM PRESENT IN CATALOG CASE
}


//getting the right to edit the row in DB
let acl = PFACL()
// acl.setPublicReadAccess(true)
// acl.setPublicWriteAccess(true)
acl.setReadAccess(true, forUserId: self.receiverUser)
acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
acl.setWriteAccess(true, forUserId: self.receiverUser)
acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
shopItemNew.ACL = acl

// shopItemNew.saveInBackgroundWithBlock
// shopItemNew.saveEventually({ (success: Bool, error: NSError?) -> Void in
shopItemNew.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
if (success) {
//self.currentList = shopListNew.objectId!
//self.trycurrent = shopListNew.objectId!
// println("Current list is \(self.currentList)")

//self.newShopListItemsIn.append(shopItemNew.objectId!)
self.newShopListItemsIn.append(itemuuid)
println("New list comprises the following items \(self.newShopListItemsIn)")

println("Array before adding is \(self.newShopListItemsIn)")

self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)

//FINALLY!


//  println("The item \(shopItemNew.objectId) added to the new list!")
println("The item \(itemuuid) added to the new list!")
// DISPLAY ALERT OF SAVING
} else {
// There was a problem, check error.description
println("Didnt add the item")
}
})



//  self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)


/*
shopItemNew.saveInBackgroundWithBlock {
(success: Bool, error: NSError?) -> Void in
if (success) {
//self.currentList = shopListNew.objectId!
//self.trycurrent = shopListNew.objectId!
// println("Current list is \(self.currentList)")

self.newShopListItemsIn.append(shopItemNew.objectId!)
println("New list comprises the following items \(self.newShopListItemsIn)")



println("The item \(shopItemNew.objectId) added to the new list!")
// DISPLAY ALERT OF SAVING
} else {
// There was a problem, check error.description
println("Didnt add the item")
}

//println("Current list is \(self.currentList)")
}
*/
// self.additemstocreatedlistsarray(self.newlistId, itemsarray: self.newShopListItemsIn)

// self.currentList = trycurrent

}


/////


}



} else {
// Log details of the failure
println("Error: \(error!) \(error!.userInfo!)")
println("BITCH DOESNT WORK")
}
}
*/ /// END OF FINDINBG

/* OLD APPROACH
queryitem.limit = 1
queryitem.findObjectsInBackgroundWithBlock {
(objects: [AnyObject]?, error: NSError?) -> Void in
if error == nil {
println("Successfully retrieved \(objects!.count) scores.")


if let listitems = objects as? [PFObject] {

for object in listitems {
println(object.objectId)
//getting all the info about an item

/*
var todoitemname = String()
var todoitemnote = String()
var todoimportant = Bool()
var todoitemlist = String()
var todoitembelongsto = String()
var todoitemischecked = Bool()
*/
self.todoitemname = object["todoitemname"] as! String
self.todoitemnote = object["todoitemnote"] as! String
self.todoimportant = object["isImportant"] as! Bool
self.todoitemlist = self.todonewlistId//object["ItemsList"] as! String
self.todoitembelongsto = self.receiverUser
self.todoitemischecked = object["isChecked"] as! Bool

self.todoitemcreationdate = object["creationDate"] as! NSDate
self.todoitemupdatedate = object["updateDate"] as! NSDate





//now create new PFObject

//var listId: String?
var todoItemNew = PFObject(className:"toDoItems")

var itemuuid = NSUUID().UUIDString
var todoitemuuid = "todo\(itemuuid)"

todoItemNew["itemUUID"] = todoitemuuid
todoItemNew["todoitemname"] = self.todoitemname
todoItemNew["todoitemnote"] = self.todoitemnote
todoItemNew["ItemsList"] = self.todonewlistId
todoItemNew["BelongsToUser"] = self.todoitembelongsto
todoItemNew["isImportant"] = self.todoimportant
todoItemNew["isChecked"] = self.todoitemischecked

todoItemNew["creationDate"] = self.todoitemcreationdate
todoItemNew["updateDate"] = self.todoitemupdatedate


todoItemNew["isDeleted"] = false


//getting the right to edit the row in DB
let acl = PFACL()
// acl.setPublicReadAccess(true)
// acl.setPublicWriteAccess(true)
acl.setReadAccess(true, forUserId: self.receiverUser)
acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
acl.setWriteAccess(true, forUserId: self.receiverUser)
acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
todoItemNew.ACL = acl

// shopItemNew.saveInBackgroundWithBlock
// shopItemNew.saveEventually({ (success: Bool, error: NSError?) -> Void in
todoItemNew.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
if (success) {

self.newtodoListItemsIn.append(itemuuid)
println("New list comprises the following items \(self.newtodoListItemsIn)")

println("Array before adding is \(self.newtodoListItemsIn)")

self.todoadditemstocreatedlistsarray(self.todonewlistId, itemsarray: self.newtodoListItemsIn)

//FINALLY!


//  println("The item \(shopItemNew.objectId) added to the new list!")
println("The item \(todoitemuuid) added to the new list!")
// DISPLAY ALERT OF SAVING
} else {
// There was a problem, check error.description
self.displayFailAlert("Wasn't sent!", message: "\(error!) : \(error!.userInfo!)")

println("Didnt add the item")
}
})


}

println("Array before adding is \(self.newtodoListItemsIn)")

self.todoadditemstocreatedlistsarray(self.todonewlistId, itemsarray: self.newtodoListItemsIn)




//} else {

// }


}



} else {
// Log details of the failure
println("Error: \(error!) \(error!.userInfo!)")
println("BITCH DOESNT WORK")
}
}
*/ // END OF OLD APPROACH

