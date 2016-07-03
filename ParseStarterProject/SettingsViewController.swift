//
//  SettingsViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 15/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import MessageUI

protocol refreshmainviewDelegate
{
    func refreshmainview()
    func checkreceivedlists()
    func loaduserdata()
}



class SettingsViewController: UIViewController, GIDSignInUIDelegate, MFMailComposeViewControllerDelegate {

    
    var account : [String] = [NSLocalizedString("account", comment: ""), NSLocalizedString("synchronize", comment: ""), NSLocalizedString("contacts", comment: ""), NSLocalizedString("shhistory", comment: ""), NSLocalizedString("logout", comment: "")]
    var accounticons : [UIImage] = [UIImage(named: "SetAccount")!, UIImage(named: "SetSynchro")!, UIImage(named: "SetContacts")!, UIImage(named: "SetSharing")!, UIImage(named: "SetLogout")!]
    
    var app : [String] = [NSLocalizedString("customcats", comment: ""), NSLocalizedString("favgroc", comment: ""),NSLocalizedString("clearhist", comment: "")]
    var appicons : [UIImage] = [UIImage(named: "SetCategories")!, UIImage(named: "SetFavs")!, UIImage(named: "SetClear")!]
    var support : [String] = [NSLocalizedString("sendfeedback", comment: ""), NSLocalizedString("reportproblem", comment: ""), NSLocalizedString("rateapp", comment: "")]
    var supporticons : [UIImage] = [UIImage(named: "SetFeedback")!, UIImage(named: "SetReport")!, UIImage(named: "SetRate")!]
    var about : [String] = [NSLocalizedString("about", comment: ""), NSLocalizedString("acknow", comment: ""),NSLocalizedString("privacy1", comment: "")]
    var abouticons : [UIImage] = [UIImage(named: "SetHelp")!, UIImage(named: "SetFeatures")!,UIImage(named: "SetPolicy")!]
    
    var maindelegate : refreshmainviewDelegate?

    @IBOutlet weak var logout: UIButton!
    
    @IBAction func closebutton(sender: AnyObject) {
        
       performSegueWithIdentifier("closesettings", sender: self)
        
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func logoutaction(sender: AnyObject) {
        
        PFUser.logOut()
        PFFacebookUtils.facebookLoginManager().logOut() // not sure, but it must work
        
         GIDSignIn.sharedInstance().signOut()
        
        let facebookRequest: FBSDKGraphRequest! = FBSDKGraphRequest(graphPath: "/me/permissions", parameters: nil, HTTPMethod: "DELETE") // BITCH DOESN'T WORK!
        
        facebookRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            if(error == nil && result != nil){
                print("Permission successfully revoked. This app will no longer post to Facebook on your behalf.")
                print("result = \(result)")
            } else {
                if let error: NSError = error {
                    if let errorString = error.userInfo["error"] as? String {
                        print("errorString variable equals: \(errorString)")
                    }
                } else {
                    print("No value for error key")
                }
            }
        }
        
        
        var currentUser = PFUser.currentUser()
        
        UserLists.removeAll(keepCapacity: true)
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
        itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
        
        userevents.removeAll(keepCapacity: true)
        usercontacts.removeAll(keepCapacity: true)
        
        customcategories.removeAll(keepCapacity: true)
        customcatalogitems.removeAll(keepCapacity: true)
        
        ///delete from device custom categorues that are contained in catalogcategories
        
         for var i = 0; i<catalogcategories.count;++i {
        
            if (catalogcategories[i].catId as NSString).containsString("custom")  {
                catalogcategories.removeAtIndex(i)
                
            } else {
                print("This is default category!")
            }
            
        }


        
        receivedtodocount = 0
        receivedshopscount = 0
        receivedcount = 0
        
        loggedIn = false
        /*
        PFAnonymousUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil || user == nil {
                println("Anonymous login failed.")
            } else {
                println("Anonymous user logged in.")
            }
        }
        */
        
        maindelegate?.loaduserdata()
        maindelegate?.refreshmainview()
        
         performSegueWithIdentifier("closesettings", sender: self)
        
    }
    
    func userlogout() {
        
        PFUser.logOut()
        PFFacebookUtils.facebookLoginManager().logOut() // not sure, but it must work
        
        GIDSignIn.sharedInstance().signOut()
        
        PFInstallation.currentInstallation().removeObjectForKey("user") //addUniqueObject("Reload", forKey: "channels")
        PFInstallation.currentInstallation()["channels"] = [""]
        PFInstallation.currentInstallation().saveInBackground()
        
        PFInstallation.currentInstallation().removeObjectForKey("user")
        
        
        let facebookRequest: FBSDKGraphRequest! = FBSDKGraphRequest(graphPath: "/me/permissions", parameters: nil, HTTPMethod: "DELETE") // BITCH DOESN'T WORK!
        
        facebookRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            if(error == nil && result != nil){
                print("Permission successfully revoked. This app will no longer post to Facebook on your behalf.")
                print("result = \(result)")
            } else {
                if let error: NSError = error {
                    if let errorString = error.userInfo["error"] as? String {
                        print("errorString variable equals: \(errorString)")
                    }
                } else {
                    print("No value for error key")
                }
            }
        }
        
        
        var currentUser = PFUser.currentUser()
        
        UserLists.removeAll(keepCapacity: true)
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
        itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
        
        userevents.removeAll(keepCapacity: true)
        usercontacts.removeAll(keepCapacity: true)
        
        customcategories.removeAll(keepCapacity: true)
        customcatalogitems.removeAll(keepCapacity: true)
        
        ///delete from device custom categorues that are contained in catalogcategories
        
        for var i = 0; i<catalogcategories.count;++i {
            
            if (catalogcategories[i].catId as NSString).containsString("custom")  {
                catalogcategories.removeAtIndex(i)
                
            } else {
                print("This is default category!")
            }
            
        }
        
        
        
        receivedtodocount = 0
        receivedshopscount = 0
        receivedcount = 0
        
        loggedIn = false
        /*
        PFAnonymousUtils.logInWithBlock {
        (user: PFUser?, error: NSError?) -> Void in
        if error != nil || user == nil {
        println("Anonymous login failed.")
        } else {
        println("Anonymous user logged in.")
        }
        }
        */
        
        maindelegate?.loaduserdata()
        maindelegate?.refreshmainview()
        
        performSegueWithIdentifier("closesettings", sender: self)
        
    }
    
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("synchr", comment: ""))
    let progressHUDdel = ProgressHUD(text: NSLocalizedString("deleting", comment: ""))
    let progressHUDrestore = ProgressHUD(text: NSLocalizedString("wait", comment: ""))
    
    
    func pause() {
        
        
        self.view.addSubview(progressHUD)
        
        progressHUD.setup()
        progressHUD.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func pausedel() {
        
        
        self.view.addSubview(progressHUDdel)
        
        progressHUDdel.setup()
        progressHUDdel.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func pauserest() {
        
        
        self.view.addSubview(progressHUDrestore)
        
        progressHUDrestore.setup()
        progressHUDrestore.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    func restore() {
        
        progressHUD.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func restoredel() {
        
        progressHUDdel.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func restorerest() {
        
        progressHUDrestore.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func displayFailAlert(title: String, message: String) {
        
        
        let customIcon = UIImage(named: "plus.png")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x9b59b6, alpha: 1), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }
    
    func displaySuccessAlert(title: String, message: String) {
        
        
        let customIcon = UIImage(named: "plus.png")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x9b59b6, alpha: 1), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }
    
    func closeCallback() {
        
        print("OK")
        
    }
    
    func cancelCallback() {
        
        print("canceled")
        
    }
    
    

    @IBAction func glogout(sender: AnyObject) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "showaccountdetails" {
            
            let destVC = segue.destinationViewController as! AccountDetailsVC
            
           // let navVC = segue.destinationViewController as! UINavigationController
            
           // let destVC = navVC.viewControllers.first as! AccountDetailsVC
            
            destVC.maindelegate = maindelegate
            
            destVC.senderVC = "SettingsVC"

        }
        
        if segue.identifier == "sharinghistoryfromsettings" {
            
            //let shareVC = segue.destinationViewController as! SharingHistoryTableViewController
            let navVC = segue.destinationViewController as! UINavigationController
            
            let shareVC = navVC.viewControllers.first as! SharingHistoryTableViewController
            
            shareVC.sendercontroller = "SettingsVC"
            
            
        }
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBOutlet var menuitem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuitem.target = self.revealViewController()
        menuitem.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        

        // Do any additional setup after loading the view.
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

    func containslistid(values: [String], element: String) -> Bool {
    
    for value in values {
    
    if value == element {
    return true
    }
    }
    // The element was not found.
    return false
    }
    
    
    
  ///// FUNCTIONS FOR SYNCHRONIZATION
    
    func listsretrieval() {
        
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
        UserLists.removeAll(keepCapacity: true)
        UserFavLists.removeAll(keepCapacity: true)
        
        pause()
        
        var query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.orderByDescending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) {
                            
                            print("object is already retrieved from local datastore")
                        } else {
                            
                            if (object["listUUID"] != nil) && (object["ShopListName"] != nil) && (object["ShopListNote"] != nil) && (object["updateDate"] != nil) && (object["isFavourite"] != nil) && (object["isReceived"] != nil) && (object["BelongsToUser"] != nil) && (object["sentFromArray"] != nil) &&
                                (object["isSaved"] != nil) && (object["confirmReception"] != nil) &&
                                (object["listUUID"] != nil) &&
                                (object["isDeleted"] != nil) && (object["isShared"] != nil) &&
                                (object["ShareWithArray"] != nil) && (object["ItemsCount"] != nil) &&
                                (object["CheckedItemsCount"] != nil) && (object["CurrencyArray"] != nil) &&
                                (object["ShowCats"] != nil) &&
                                (object["ListColorCode"] != nil) { //ListCurrency may stay nil now
                                    
                                    var listid = object["listUUID"] as! String
                                    var listname = object["ShopListName"] as! String
                                    var listnote = object["ShopListNote"] as! String
                                    var listcreationdate = object["updateDate"] as! NSDate
                                    var listisfav = object["isFavourite"] as! Bool
                                    var listisreceived = object["isReceived"] as! Bool
                                    var listbelongsto = object["BelongsToUser"] as! String
                                    var listissentfrom = object["sentFromArray"] as! [(String)]
                                    var listissaved = object["isSaved"] as! Bool
                                    
                                    var listconfirm = object["confirmReception"] as! Bool
                                    var listisdeleted = object["isDeleted"] as! Bool
                                    var listisshared = object["isShared"] as! Bool
                                    var listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                                    
                                    var listitemscount = object["ItemsCount"] as! Int
                                    var listcheckeditems = object["CheckedItemsCount"] as! Int
                                    var listtype = "Shop"
                                    //var listcurrency = object["ListCurrency"] as! String
                                    var listcurrency = object["CurrencyArray"] as! [AnyObject]
                                    var listshowcats = object["ShowCats"] as! Bool
                                    
                                    var listscolor = object["ListColorCode"] as! String
                                    
                                    
                                    
                                    
                                    var userlist : UserList = UserList(
                                        listid:listid,
                                        listname:listname,
                                        listnote:listnote,
                                        listcreationdate:listcreationdate,
                                        listisfavourite:listisfav,
                                        listisreceived:listisreceived,
                                        listbelongsto:listbelongsto,
                                        listreceivedfrom:listissentfrom,
                                        listissaved:listissaved,
                                        listconfirmreception:listconfirm,
                                        listisdeleted:listisdeleted,
                                        listisshared:listisshared,
                                        listsharedwith:listsharewitharray,
                                        listitemscount:listitemscount,
                                        listcheckeditemscount:listcheckeditems,
                                        listtype:listtype,
                                        listcurrency:listcurrency,
                                        listcategories:listshowcats,
                                        listcolorcode: listscolor
                                        
                                        
                                    )
                                    
                                    UserShopLists.append(userlist)
                                    UserLists.append(userlist)
                                    
                                    if listisfav == true {
                                        UserFavLists.append(userlist)
                                    }
                                    
                            } else {
                                self.restore()
                                print("There is a nil value in a list!")
                                
                            }
                            
                        }
                        
                        // self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                    
                    //UserLists.extend(UserShopLists)
                }
                self.restore()
                //self.restore()
            } else {
                self.restore()
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
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
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        
                        if ((object["listUUID"] != nil) && (object["ToDoListName"] != nil) && (object["ToDoListNote"] != nil) && (object["updateDate"] != nil) && (object["isFavourite"] != nil) && (object["isReceived"] != nil) && (object["BelongsToUser"] != nil) && (object["SentFromArray"] != nil) &&
                            (object["isSaved"] != nil) && (object["confirmReception"] != nil) &&
                            (object["listUUID"] != nil) &&
                            (object["isDeleted"] != nil) && (object["isShared"] != nil) &&
                            (object["ShareWithArray"] != nil) && (object["ItemsCount"] != nil) &&
                            (object["CheckedItemsCount"] != nil) &&
                            (object["ListColorCode"] != nil)) {
                                
                                
                                var listid = object["listUUID"] as! String
                                var listname = object["ToDoListName"] as! String
                                var listnote = object["ToDoListNote"] as! String
                                var listcreationdate = object["updateDate"] as! NSDate
                                var listisfav = object["isFavourite"] as! Bool
                                var listisreceived = object["isReceived"] as! Bool
                                var listbelongsto = object["BelongsToUser"] as! String
                                var listissentfrom = object["SentFromArray"] as! [(String)]
                                var listissaved = object["isSaved"] as! Bool
                                
                                var listconfirm = object["confirmReception"] as! Bool
                                var listisdeleted = object["isDeleted"] as! Bool
                                var listisshared = object["isShared"] as! Bool
                                var listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                                
                                var listitemscount = object["ItemsCount"] as! Int
                                var listcheckeditems = object["CheckedItemsCount"] as! Int
                                
                                var listscolor = object["ListColorCode"] as! String
                                var listtype = "ToDo"
                                // var listcurrency = object["ListCurrency"] as! String
                                // var listshowcats = object["ShowCats"] as! Bool
                                
                                
                                var usertodolist : UserList = UserList(
                                    listid:listid,
                                    listname:listname,
                                    listnote:listnote,
                                    listcreationdate:listcreationdate,
                                    listisfavourite:listisfav,
                                    listisreceived:listisreceived,
                                    listbelongsto:listbelongsto,
                                    listreceivedfrom:listissentfrom,
                                    listissaved:listissaved,
                                    listconfirmreception:listconfirm,
                                    listisdeleted:listisdeleted,
                                    listisshared:listisshared,
                                    listsharedwith:listsharewitharray,
                                    listitemscount:listitemscount,
                                    listcheckeditemscount:listcheckeditems,
                                    listtype:listtype,
                                    listcolorcode: listscolor
                                    
                                    
                                )
                                
                                UserToDoLists.append(usertodolist)
                                UserLists.append(usertodolist)
                                
                                if listisfav == true {
                                    UserFavLists.append(usertodolist)
                                }
                                
                        } else {
                            self.restore()
                            print("There is a nil value!")
                        }
                        
                        
                        //self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                    
                    // UserLists.extend(UserToDoLists)
                    
                    
                    print("all \(UserLists.count)")
                    print("Shops \(UserShopLists.count)")
                    print("ToDo \(UserToDoLists.count)")
                    
                    //  UserLists.sort(self.sortListsDESC)
                    //SORT FUNCTION BY DATE
                    
                    print("SOOOO \(UserLists)")
                    
                    //self.tableView.reloadData()
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.restore()
                        self.tableView.reloadData()
                    }
                    
                    
                    //self.tableView.reloadData()
                    
                }
                
                self.restore()
            } else {
                // Log details of the failure
                self.restore()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        //images.sort({ $0.fileID > $1.fileID })
        //UserLists.sort() { $0.listcreationdate > $1.listcreationdate }
        
        
        
        //println("TYPES ARE \(ListsType)")
    }
    
    
    func changeshoplistinfo(listid: String) {
        
         if self.containslistid(UserLists.map({ $0.listid }), element: listid) {
            /// here
            let query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            query.limit = 1
            query.whereKey("listUUID", equalTo: listid)
            let objects = query.findObjects()
            if (objects != nil) {
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        
                        let listid = object["listUUID"] as! String
                        let listname = object["ShopListName"] as! String
                        let listnote = object["ShopListNote"] as! String
                        let listcreationdate = object["updateDate"] as! NSDate
                        let listisfav = object["isFavourite"] as! Bool
                        let listisreceived = object["isReceived"] as! Bool
                        var listbelongsto = object["BelongsToUser"] as! String
                        let listissentfrom = object["sentFromArray"] as! [(String)]
                        let listissaved = object["isSaved"] as! Bool
                        
                        let listconfirm = object["confirmReception"] as! Bool
                        let listisdeleted = object["isDeleted"] as! Bool
                        let listisshared = object["isShared"] as! Bool
                        let listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                        
                        let listitemscount = object["ItemsCount"] as! Int
                        let listcheckeditems = object["CheckedItemsCount"] as! Int
                        let listtype = "Shop"
                        //var listcurrency = object["ListCurrency"] as! String
                        let listcurrency = object["CurrencyArray"] as! [AnyObject]
                        let listshowcats = object["ShowCats"] as! Bool
                        
                        let listscolor = object["ListColorCode"] as! String
                       
                        
                        // update this object in array
                      //  if let foundlist = find(lazy(UserLists).map({ $0.listid }), listid) {
                         if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listid) {
                        UserLists[foundlist].listname = listname
                            UserLists[foundlist].listnote = listnote
                            UserLists[foundlist].listcurrency = listcurrency //later add array instead of just string currency
                            UserLists[foundlist].listcategories = listshowcats
                            UserLists[foundlist].listitemscount = listitemscount
                            UserLists[foundlist].listcheckeditemscount = listcheckeditems
                            UserLists[foundlist].listcreationdate = listcreationdate
                            UserLists[foundlist].listcolorcode = listscolor
                            UserLists[foundlist].listisfavourite = listisfav
                            UserLists[foundlist].listisreceived = listisreceived
                            UserLists[foundlist].listreceivedfrom = listissentfrom
                            UserLists[foundlist].listissaved = listissaved
                            UserLists[foundlist].listconfirmreception = listconfirm
                            UserLists[foundlist].listisdeleted = listisdeleted
                            UserLists[foundlist].listisshared = listisshared
                            UserLists[foundlist].listsharedwith = listsharewitharray
                            UserLists[foundlist].listtype = listtype
                            
                            
                        }
                        
                       // if let foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listid) {
                         if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listid) {
                            UserShopLists[foundshoplist].listname = listname
                            UserShopLists[foundshoplist].listnote = listnote
                            UserShopLists[foundshoplist].listcurrency = listcurrency //later add array instead of just string currency
                            UserShopLists[foundshoplist].listcategories = listshowcats
                            UserShopLists[foundshoplist].listitemscount = listitemscount
                            UserShopLists[foundshoplist].listcheckeditemscount = listcheckeditems
                            UserShopLists[foundshoplist].listcreationdate = listcreationdate
                            UserShopLists[foundshoplist].listcolorcode = listscolor
                            UserShopLists[foundshoplist].listisfavourite = listisfav
                            UserShopLists[foundshoplist].listisreceived = listisreceived
                            UserShopLists[foundshoplist].listreceivedfrom = listissentfrom
                            UserShopLists[foundshoplist].listissaved = listissaved
                            UserShopLists[foundshoplist].listconfirmreception = listconfirm
                            UserShopLists[foundshoplist].listisdeleted = listisdeleted
                            UserShopLists[foundshoplist].listisshared = listisshared
                            UserShopLists[foundshoplist].listsharedwith = listsharewitharray
                            UserShopLists[foundshoplist].listtype = listtype
                            
                            
                        }
                        
                       // if let foundfavlist = find(lazy(UserFavLists).map({ $0.listid }), listid) {
                        if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listid) {
                            UserFavLists[foundfavlist].listname = listname
                            UserFavLists[foundfavlist].listnote = listnote
                            UserFavLists[foundfavlist].listcurrency = listcurrency //later add array instead of just string currency
                            UserFavLists[foundfavlist].listcategories = listshowcats
                            UserFavLists[foundfavlist].listitemscount = listitemscount
                            UserFavLists[foundfavlist].listcheckeditemscount = listcheckeditems
                            UserFavLists[foundfavlist].listcreationdate = listcreationdate
                            UserFavLists[foundfavlist].listcolorcode = listscolor
                            UserFavLists[foundfavlist].listisfavourite = listisfav
                            UserFavLists[foundfavlist].listisreceived = listisreceived
                            UserFavLists[foundfavlist].listreceivedfrom = listissentfrom
                            UserFavLists[foundfavlist].listissaved = listissaved
                            UserFavLists[foundfavlist].listconfirmreception = listconfirm
                            UserFavLists[foundfavlist].listisdeleted = listisdeleted
                            UserFavLists[foundfavlist].listisshared = listisshared
                            UserFavLists[foundfavlist].listsharedwith = listsharewitharray
                            UserFavLists[foundfavlist].listtype = listtype
                            
                            
                        }


                        // now the same for shopping array and fav array
                    }
                    
                    
                    
                }
            } else {
                print("Error")
            }
            
            
            
            
            
         } else {
           // if no such list (so its a new device)
            
            let query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            query.limit = 1
            query.whereKey("listUUID", equalTo: listid)
            let objects = query.findObjects()
            if (objects != nil) {
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        
                        let listid = object["listUUID"] as! String
                        let listname = object["ShopListName"] as! String
                        let listnote = object["ShopListNote"] as! String
                        let listcreationdate = object["updateDate"] as! NSDate
                        let listisfav = object["isFavourite"] as! Bool
                        let listisreceived = object["isReceived"] as! Bool
                        let listbelongsto = object["BelongsToUser"] as! String
                        let listissentfrom = object["sentFromArray"] as! [(String)]
                        let listissaved = object["isSaved"] as! Bool
                        
                        let listconfirm = object["confirmReception"] as! Bool
                        let listisdeleted = object["isDeleted"] as! Bool
                        let listisshared = object["isShared"] as! Bool
                        let listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                        
                        let listitemscount = object["ItemsCount"] as! Int
                        let listcheckeditems = object["CheckedItemsCount"] as! Int
                        let listtype = "Shop"
                        //var listcurrency = object["ListCurrency"] as! String
                        let listcurrency = object["CurrencyArray"] as! [AnyObject]
                        let listshowcats = object["ShowCats"] as! Bool
                        
                        let listscolor = object["ListColorCode"] as! String
                        
                        
                       //create list and append it to the array
                        
                        let userlist : UserList = UserList(
                            listid:listid,
                            listname:listname,
                            listnote:listnote,
                            listcreationdate:listcreationdate,
                            listisfavourite:listisfav,
                            listisreceived:listisreceived,
                            listbelongsto:listbelongsto,
                            listreceivedfrom:listissentfrom,
                            listissaved:listissaved,
                            listconfirmreception:listconfirm,
                            listisdeleted:listisdeleted,
                            listisshared:listisshared,
                            listsharedwith:listsharewitharray,
                            listitemscount:listitemscount,
                            listcheckeditemscount:listcheckeditems,
                            listtype:listtype,
                            listcurrency:listcurrency,
                            listcategories:listshowcats,
                            listcolorcode: listscolor
                            
                            
                        )
                        
                        UserShopLists.append(userlist)
                        UserLists.append(userlist)
                        
                        if listisfav == true {
                            UserFavLists.append(userlist)
                        }

                        
                        
                    }
                    
                    
                    
                }
            } else {
                print("Error")
            }

            
            

        }
        
       
    }
    var itemisinlocal = Bool()
    func checkshopitems(itemid: String) -> Bool {
        
        let query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.limit = 1
        query.whereKey("itemUUID", equalTo: itemid)
        let objects = query.findObjects()
        if (objects != nil) {
           
            itemisinlocal = true
            
        } else {
           itemisinlocal = false
        }
        
        return itemisinlocal
        
    }
    
    var todoitemisinlocal = Bool()
    func checktodoitems(itemid: String) -> Bool {
        
        let query = PFQuery(className:"toDoItems")
        query.fromLocalDatastore()
        query.limit = 1
        query.whereKey("itemUUID", equalTo: itemid)
        let objects = query.findObjects()
        if (objects != nil) {
            
            todoitemisinlocal = true
            
        } else {
            todoitemisinlocal = false
        }
        
        return todoitemisinlocal
        
    }

    
    func changetodolistinfo(listid: String) {
        
        if self.containslistid(UserLists.map({ $0.listid }), element: listid) {
            /// here
            let query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            query.limit = 1
            query.whereKey("listUUID", equalTo: listid)
            let objects = query.findObjects()
            if (objects != nil) {
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        
                        let listid = object["listUUID"] as! String
                        let listname = object["ToDoListName"] as! String
                        let listnote = object["ToDoListNote"] as! String
                        let listcreationdate = object["updateDate"] as! NSDate
                        let listisfav = object["isFavourite"] as! Bool
                        let listisreceived = object["isReceived"] as! Bool
                        var listbelongsto = object["BelongsToUser"] as! String
                        let listissentfrom = object["SentFromArray"] as! [(String)]
                        let listissaved = object["isSaved"] as! Bool
                        
                        let listconfirm = object["confirmReception"] as! Bool
                        let listisdeleted = object["isDeleted"] as! Bool
                        let listisshared = object["isShared"] as! Bool
                        let listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                        
                        let listitemscount = object["ItemsCount"] as! Int
                        let listcheckeditems = object["CheckedItemsCount"] as! Int
                        let listtype = "ToDo"
                        //var listcurrency = object["ListCurrency"] as! String
                        
                        
                        let listscolor = object["ListColorCode"] as! String
                        
                        
                        // update this object in array
                       // if let foundlist = find(lazy(UserLists).map({ $0.listid }), listid) {
                          if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listid) {
                            UserLists[foundlist].listname = listname
                            UserLists[foundlist].listnote = listnote
                            UserLists[foundlist].listitemscount = listitemscount
                            UserLists[foundlist].listcheckeditemscount = listcheckeditems
                            UserLists[foundlist].listcreationdate = listcreationdate
                            UserLists[foundlist].listcolorcode = listscolor
                            UserLists[foundlist].listisfavourite = listisfav
                            UserLists[foundlist].listisreceived = listisreceived
                            UserLists[foundlist].listreceivedfrom = listissentfrom
                            UserLists[foundlist].listissaved = listissaved
                            UserLists[foundlist].listconfirmreception = listconfirm
                            UserLists[foundlist].listisdeleted = listisdeleted
                            UserLists[foundlist].listisshared = listisshared
                            UserLists[foundlist].listsharedwith = listsharewitharray
                            UserLists[foundlist].listtype = listtype
                            
                            
                        }
                        
                        //if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listid) {
                        if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listid) {
                            UserToDoLists[foundtodolist].listname = listname
                            UserToDoLists[foundtodolist].listnote = listnote
                            UserToDoLists[foundtodolist].listitemscount = listitemscount
                            UserToDoLists[foundtodolist].listcheckeditemscount = listcheckeditems
                            UserToDoLists[foundtodolist].listcreationdate = listcreationdate
                            UserToDoLists[foundtodolist].listcolorcode = listscolor
                            UserToDoLists[foundtodolist].listisfavourite = listisfav
                            UserToDoLists[foundtodolist].listisreceived = listisreceived
                            UserToDoLists[foundtodolist].listreceivedfrom = listissentfrom
                            UserToDoLists[foundtodolist].listissaved = listissaved
                            UserToDoLists[foundtodolist].listconfirmreception = listconfirm
                            UserToDoLists[foundtodolist].listisdeleted = listisdeleted
                            UserToDoLists[foundtodolist].listisshared = listisshared
                            UserToDoLists[foundtodolist].listsharedwith = listsharewitharray
                            UserToDoLists[foundtodolist].listtype = listtype
                            
                            
                        }
                        
                        //if let foundfavlist = find(lazy(UserFavLists).map({ $0.listid }), listid) {
                        if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listid) {
                            UserFavLists[foundfavlist].listname = listname
                            UserFavLists[foundfavlist].listnote = listnote
                            UserFavLists[foundfavlist].listitemscount = listitemscount
                            UserFavLists[foundfavlist].listcheckeditemscount = listcheckeditems
                            UserFavLists[foundfavlist].listcreationdate = listcreationdate
                            UserFavLists[foundfavlist].listcolorcode = listscolor
                            UserFavLists[foundfavlist].listisfavourite = listisfav
                            UserFavLists[foundfavlist].listisreceived = listisreceived
                            UserFavLists[foundfavlist].listreceivedfrom = listissentfrom
                            UserFavLists[foundfavlist].listissaved = listissaved
                            UserFavLists[foundfavlist].listconfirmreception = listconfirm
                            UserFavLists[foundfavlist].listisdeleted = listisdeleted
                            UserFavLists[foundfavlist].listisshared = listisshared
                            UserFavLists[foundfavlist].listsharedwith = listsharewitharray
                            UserFavLists[foundfavlist].listtype = listtype
                            
                            
                        }
                        
                        
                        // now the same for shopping array and fav array
                    }
                    
                    
                    
                }
            } else {
                print("Error")
            }
            
            
            
            
            
        } else {
            // if no such list (so its a new device)
            
            let query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            query.limit = 1
            query.whereKey("listUUID", equalTo: listid)
            let objects = query.findObjects()
            if (objects != nil) {
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        
                        let listid = object["listUUID"] as! String
                        let listname = object["ToDoListName"] as! String
                        let listnote = object["ToDoListNote"] as! String
                        let listcreationdate = object["updateDate"] as! NSDate
                        let listisfav = object["isFavourite"] as! Bool
                        let listisreceived = object["isReceived"] as! Bool
                        let listbelongsto = object["BelongsToUser"] as! String
                        let listissentfrom = object["SentFromArray"] as! [(String)]
                        let listissaved = object["isSaved"] as! Bool
                        
                        let listconfirm = object["confirmReception"] as! Bool
                        let listisdeleted = object["isDeleted"] as! Bool
                        let listisshared = object["isShared"] as! Bool
                        let listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                        
                        let listitemscount = object["ItemsCount"] as! Int
                        let listcheckeditems = object["CheckedItemsCount"] as! Int
                        let listtype = "ToDo"
                        //var listcurrency = object["ListCurrency"] as! String
                        
                        
                        let listscolor = object["ListColorCode"] as! String
                        
                        
                        //create list and append it to the array
                        
                        let userlist : UserList = UserList(
                            listid:listid,
                            listname:listname,
                            listnote:listnote,
                            listcreationdate:listcreationdate,
                            listisfavourite:listisfav,
                            listisreceived:listisreceived,
                            listbelongsto:listbelongsto,
                            listreceivedfrom:listissentfrom,
                            listissaved:listissaved,
                            listconfirmreception:listconfirm,
                            listisdeleted:listisdeleted,
                            listisshared:listisshared,
                            listsharedwith:listsharewitharray,
                            listitemscount:listitemscount,
                            listcheckeditemscount:listcheckeditems,
                            listtype:listtype,
                            listcolorcode: listscolor
                            
                            
                        )
                        
                        UserToDoLists.append(userlist)
                        UserLists.append(userlist)
                        
                        if listisfav == true {
                            UserFavLists.append(userlist)
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
            } else {
                print("Error")
            }
            
            
            
            
        }
        
        
    }
    
    
    
    var customcategory : Category?
    
    func containscategory(values: [Category], element: Category) -> Bool {
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
    
    
    func addcustomstocategories(customlist: [Category]) -> [Category] {
        
        //retrievecustomcategories()
        
        catalogcategories.appendContentsOf(customlist)
        
        return catalogcategories
    }
    
    
    func addcategorytolocalarray(categoryid: String) {
        //DO THE WHOLE STUFF IN PREVIOUS VC
        
        
        // customCatsIds.removeAll(keepCapacity: true)
        //MOST PROBABLY NEED JUST TO CLEAN THE ARRAY HERE
        let query = PFQuery(className:"shopListsCategory")
        query.fromLocalDatastore()
        query.limit = 1
        query.whereKey("categoryUUID", equalTo: categoryid)
        //query.whereKey("isDeleted", equalTo: false) //TEMPORARILY SWITCHED THIS OFF!
        let objects = query.findObjects()
        if (objects != nil) {
            if let listitems = objects as? [PFObject] {
                for object in listitems {
                    
                    let customId = object["categoryUUID"] as! String
                    let customName = object["catname"] as! String
                    let customIs = object["isCustom"] as! Bool
                    var customImagePath = object["imagePath"] as! String
                    let customIsAllowed = object["ShouldShowInCatalog"] as! Bool //TEMPORARILY SWITCHED THIS OFF!
                    var customImage = UIImage()
                    //customImage
                    
                    
                    if object["defaultpicture"] as! Bool == true {
                        
                        let imagename = object["OriginalInDefaults"] as! String
                        
                        if (UIImage(named: "\(imagename)") != nil) {
                            customImage = UIImage(named: "\(imagename)")!
                        } else {
                            customImage = imagestochoose[0].itemimage
                        }
                        
                    } else {
                        
                        let imageFile = object["catimage"] as! PFFile
                        
                        let imageData = imageFile.getData()
                        if (imageData != nil) {
                            let image = UIImage(data: imageData!)
                            customImage = image!
                            
                        } else {
                            customImage = imagestochoose[0].itemimage
                        }
                  
                    }
                    
                 
                    
                    self.customcategory = Category(catId: customId, catname: customName, catimage: customImage, isCustom: customIs, isAllowed: customIsAllowed)
                    
                    print(self.customcategory)
                    
                    customcategories.append(self.customcategory!)
                    catalogcategories.append(self.customcategory!)
                    
                   print(customcategories)
                    print(catalogcategories)
                    
                    
                }
                
                
                
            }
        } else {
            print("Error")
        }
        
        
        
       
        
    }

    var customcatalogitem : CatalogItem?
    
    func addcustomstocatalogitems(customlist: [CatalogItem]) -> [CatalogItem] {
        
        //retrievecustomcategories()
        
        catalogitems.appendContentsOf(customlist)
        
        return catalogitems
    }
    
    func addcustomitemtolocalarray(itemid: String) {
    
        
        // customCatsIds.removeAll(keepCapacity: true)
        //MOST PROBABLY NEED JUST TO CLEAN THE ARRAY HERE
        let query = PFQuery(className:"shopListsCategory")
        query.fromLocalDatastore()
        query.limit = 1
        query.whereKey("itemid", equalTo: itemid)
        //query.whereKey("isDeleted", equalTo: false) //TEMPORARILY SWITCHED THIS OFF!
        
        let objects = query.findObjects()
        if (objects != nil) {
            if let listitems = objects as? [PFObject] {
                for object in listitems {
                    
                    let customitemId = object["itemid"] as! String
                    let customitemName = object["itemname"] as! String
                    let customitemCategoryId = object["itemcategoryid"] as! String
                    var customitemImagePath = object["imagepath"] as! String
                    var customitemcategory : Category?
                    var customImage = UIImage()
                    //customImage
                    
                    
                    
                    if object["defaultpicture"] as! Bool == true {
                        
                        let imagename = object["OriginalInDefaults"] as! String
                        
                        if (UIImage(named: "\(imagename)") != nil) {
                            customImage = UIImage(named: "\(imagename)")!
                        } else {
                            customImage = imagestochoose[0].itemimage
                        }
                        
                    } else {
                        if object["itemimage"] != nil {
                            let imageFile = object["itemimage"] as! PFFile
                            
                            let imageData = imageFile.getData()
                            if (imageData != nil) {
                                let image = UIImage(data: imageData!)
                                customImage = image!
                                
                            } else {
                                customImage = imagestochoose[0].itemimage
                            }
                        } else {
                            customImage = imagestochoose[0].itemimage
                        }
                        
                    
                    }
                    
                   
                    
                    
                    //if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), customitemCategoryId) {
                    
                    if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(customitemCategoryId) {
                    customitemcategory = catalogcategories[foundcategory]
                    } else {
                        
                        customitemcategory = catalogcategories[0]
                        
                    }
                    
                    // var customImage = UIImage()
                    
                    self.customcatalogitem = CatalogItem(itemId: customitemId, itemname: customitemName, itemimage: customImage, itemcategory: customitemcategory!, itemischecked:false)
                    
                    
                    
                    customcatalogitems.append(self.customcatalogitem!)
                    
                    catalogitems.append(self.customcatalogitem!)
                    
                    print(customcatalogitems)
                    
                    print(catalogitems)
                    
                }
                
                
                
            }
        } else {
            print("Error")
        }
        
        
        
        
    }
    
    /// FUNCS FOR SYNCHRO END
    
    
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
                // return ""
                
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
    
  var imageToLoad = UIImage()
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

    
    /*
    let imageDataexisting = UIImagePNGRepresentation(self.itemImageOutlet.image!)
    self.saveImageLocally(imageDataexisting)
    
    
    
    itemch["imageLocalPath"] = self.imagePath
    
    
    self.loadImageFromLocalStore(category["imagePath"] as! String)
    thiscatpicture = self.imageToLoad

    */
    
    
    
    func synchronize() {
    
        print("SYNCRONIZED")
        /*
        UserLists.removeAll(keepCapacity: true)
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
       // itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
    
        customcategories.removeAll(keepCapacity: true)
        customcatalogitems.removeAll(keepCapacity: true)
        */
    ///// GET ALL SHOP LISTS
        
        
        
        //if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserShopLists.map({ $0.listid }), element: object["listUUID"] as! String){
        
        // 1. Upload Part
        
        pause()
        
        // SHOPLISTS
        var query = PFQuery(className:"shopLists")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        if object["ServerUpdateDate"] != nil {
                            if ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["updateDate"] as! NSDate).timeIntervalSince1970) {
                            
                            
                            object.saveInBackgroundWithBlock({ (success, error) -> Void in
                                if success {
                                    
                                    print("List saved to server")
                                    
                                } else {
                                    print("no list found")
                                }
                            })

                        } else {
                                
                            print("No need to update")
                        }
                    }
                        /*
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        */
                        
                        
                    }
                    // SHOPITEMS
                    var query2 = PFQuery(className:"shopItems")
                    query2.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                    query2.fromLocalDatastore()
                    query2.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            
                            print("Successfully retrieved \(objects!.count) scores.")
                            
                            if let shopitems = objects as? [PFObject] {
                                
                                
                                for object in shopitems {
                                    
                                    if object["ServerUpdateDate"] != nil {
                                        if ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["UpdateDate"] as! NSDate).timeIntervalSince1970) {
                                            
                                            var newdate = NSDate()
                                            object["ServerUpdateDate"] = newdate
                                        
                                            if object["isCatalog"] as! Bool == false {
                                            //
                                                if object["defaultpicture"] as! Bool == false {
                                                self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                            var imageData = UIImagePNGRepresentation(self.imageToLoad)
                                            
                                            var imageFile = PFFile(name:"itemImage", data:imageData!)
                                            
                                            object["itemImage"] = imageFile
                                            //
                                                }
                                            }
                                            
                                            object.saveInBackgroundWithBlock({ (success, error) -> Void in
                                                if success {
                                                    
                                                    print("Shop item saved to server")
                                                    
                                                } else {
                                                    print("no item found")
                                                }
                                                
                                              
                                            })
                                            
                                        } else {
                                            
                                            print("No need to update")
                                        }
                                    }
                                    /*
                                    object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                        if success {
                                            
                                            println("item saved")
                                            
                                        } else {
                                            println("no item found")
                                        }
                                    })
                                    */
                                    
                                    
                                }
                                
                                // TO DO LISTS
                                var query3 = PFQuery(className:"toDoLists")
                                query3.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                                query3.fromLocalDatastore()
                                query3.findObjectsInBackgroundWithBlock {
                                    (objects: [AnyObject]?, error: NSError?) -> Void in
                                    
                                    if error == nil {
                                        
                                        print("Successfully retrieved \(objects!.count) scores.")
                                        
                                        if let todolists = objects as? [PFObject] {
                                            
                                            
                                            for object in todolists {
                                                
                                                if object["ServerUpdateDate"] != nil {
                                                    if ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["updateDate"] as! NSDate).timeIntervalSince1970) {
                                                        
                                                        var newdate = NSDate()
                                                        object["ServerUpdateDate"] = newdate
                                                        object.saveInBackgroundWithBlock({ (success, error) -> Void in
                                                            if success {
                                                                
                                                                print("Shop item saved to server")
                                                                
                                                            } else {
                                                                print("no item found")
                                                            }
                                                            
                                                           
                                                        })
                                                        
                                                    } else {
                                                        
                                                        print("No need to update")
                                                    }
                                                }
                                                /*
                                                object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                if success {
                                                
                                                println("item saved")
                                                
                                                } else {
                                                println("no item found")
                                                }
                                                })
                                                */
                                                
                                                
                                            }
                                            
                                            // TO DO ITEMS
                                            var query4 = PFQuery(className:"toDoItems")
                                            query4.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                                            query4.fromLocalDatastore()
                                            query4.findObjectsInBackgroundWithBlock {
                                                (objects: [AnyObject]?, error: NSError?) -> Void in
                                                
                                                if error == nil {
                                                    
                                                    print("Successfully retrieved \(objects!.count) scores.")
                                                    
                                                    if let todoitems = objects as? [PFObject] {
                                                        
                                                        
                                                        for object in todoitems {
                                                            
                                                            if object["ServerUpdateDate"] != nil {
                                                                if ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["updateDate"] as! NSDate).timeIntervalSince1970) {
                                                                    
                                                                    var newdate = NSDate()
                                                                    object["ServerUpdateDate"] = newdate
                                                                    object.saveInBackgroundWithBlock({ (success, error) -> Void in
                                                                        if success {
                                                                            
                                                                            print("Shop item saved to server")
                                                                            
                                                                        } else {
                                                                            print("no item found")
                                                                        }
                                                                        
                                                                       
                                                                    })
                                                                    
                                                                } else {
                                                                   
                                                                    print("No need to update")
                                                                }
                                                            }
                                                            /*
                                                            object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                            if success {
                                                            
                                                            println("item saved")
                                                            
                                                            } else {
                                                            println("no item found")
                                                            }
                                                            })
                                                            */
                                                            
                                                            
                                                        }
                                                        
                                                        // CUSTOM CATEGORIES
                                                        var query5 = PFQuery(className:"shopListsCategory")
                                                        query5.whereKey("CatbelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                                                        query5.fromLocalDatastore()
                                                        query5.findObjectsInBackgroundWithBlock {
                                                            (objects: [AnyObject]?, error: NSError?) -> Void in
                                                            
                                                            if error == nil {
                                                                
                                                                print("Successfully retrieved \(objects!.count) scores.")
                                                                
                                                                if let categories = objects as? [PFObject] {
                                                                    
                                                                    
                                                                    for object in categories {
                                                                        
                                                                        if object["ServerUpdateDate"] != nil {
                                                                            if ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["CreationDate"] as! NSDate).timeIntervalSince1970) {
                                                                                
                                                                                var newdate = NSDate()
                                                                                object["ServerUpdateDate"] = newdate
                                                                                
                                                                                
                                                                                
                                                                               
                                                                                    //
                                                                                    if object["defaultpicture"] as! Bool == false {
                                                                                        self.loadImageFromLocalStore(object["imagePath"] as! String)
                                                                                        var imageData = UIImagePNGRepresentation(self.imageToLoad)
                                                                                        
                                                                                        var imageFile = PFFile(name:"itemImage", data:imageData!)
                                                                                        
                                                                                        object["catimage"] = imageFile
                                                                                        //
                                                                                    }
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                object.saveInBackgroundWithBlock({ (success, error) -> Void in
                                                                                    if success {
                                                                                        
                                                                                        print("Custom category saved to server")
                                                                                        
                                                                                    } else {
                                                                                        print("no item found")
                                                                                    }
                                                                                    
                                                                                    
                                                                                })
                                                                                
                                                                            } else {
                                                                                
                                                                                print("No need to update")
                                                                            }
                                                                        }
                                                                        /*
                                                                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                                        if success {
                                                                        
                                                                        println("item saved")
                                                                        
                                                                        } else {
                                                                        println("no item found")
                                                                        }
                                                                        })
                                                                        */
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    // CUSTOM CAT ITEMS
                                                                    var query6 = PFQuery(className:"shopListCatalogItems")
                                                                    query6.whereKey("itemsbelongstouser", equalTo: PFUser.currentUser()!.objectId!)
                                                                    query6.fromLocalDatastore()
                                                                    query6.findObjectsInBackgroundWithBlock {
                                                                        (objects: [AnyObject]?, error: NSError?) -> Void in
                                                                        
                                                                        if error == nil {
                                                                            
                                                                            print("Successfully retrieved \(objects!.count) scores.")
                                                                            
                                                                            if let catitems = objects as? [PFObject] {
                                                                                
                                                                                
                                                                                for object in catitems {
                                                                                    
                                                                                    if object["ServerUpdateDate"] != nil {
                                                                                        if ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["CreationDate"] as! NSDate).timeIntervalSince1970) {
                                                                                            
                                                                                            var newdate = NSDate()
                                                                                            object["ServerUpdateDate"] = newdate
                                                                                            
                                                                                            
                                                                                           
                                                                                                //
                                                                                                if object["defaultpicture"] as! Bool == false {
                                                                                                    self.loadImageFromLocalStore(object["imagepath"] as! String)
                                                                                                    var imageData = UIImagePNGRepresentation(self.imageToLoad)
                                                                                                    
                                                                                                    var imageFile = PFFile(name:"itemImage", data:imageData!)
                                                                                                    
                                                                                                    object["itemimage"] = imageFile
                                                                                                    //
                                                                                                }
                                                                                          
                                                                                            
                                                                                            
                                                                                            
                                                                                            object.saveInBackgroundWithBlock({ (success, error) -> Void in
                                                                                                if success {
                                                                                                    
                                                                                                    print("Custom category saved to server")
                                                                                                    
                                                                                                } else {
                                                                                                    print("no item found")
                                                                                                }
                                                                                                
                                                                                                
                                                                                            })
                                                                                            
                                                                                        } else {
                                                                                            
                                                                                            print("No need to update")
                                                                                        }
                                                                                    }
                                                                                    /*
                                                                                    object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                                                    if success {
                                                                                    
                                                                                    println("item saved")
                                                                                    
                                                                                    } else {
                                                                                    println("no item found")
                                                                                    }
                                                                                    })
                                                                                    */
                                                                                    
                                                                                    
                                                                                }
                                                                                
                                                                            }
                                                                            
                                                                            //self.restore()
                                                                        } else {
                                                                            // Log details of the failure
                                                                            self.restore()
                                                                            print("Error: \(error!) \(error!.userInfo)")
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                                //self.restore()
                                                            } else {
                                                                // Log details of the failure
                                                                self.restore()
                                                                print("Error: \(error!) \(error!.userInfo)")
                                                            }
                                                        }
                                                        
                                                    }
                                                    
                                                    //self.restore()
                                                } else {
                                                    // Log details of the failure
                                                    self.restore()
                                                    print("Error: \(error!) \(error!.userInfo)")
                                                }
                                            }
                                            
                                        }
                                        
                                        //self.restore()
                                    } else {
                                        // Log details of the failure
                                        self.restore()
                                        print("Error: \(error!) \(error!.userInfo)")
                                    }
                                }
                                
                            }
                            
                            //self.restore()
                        } else {
                            // Log details of the failure
                            self.restore()
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                self.restore()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
        
        // 2. Retrieve new data part
        
        // SHOPLISTS
        var query11 = PFQuery(className:"shopLists")
        query11.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query11.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let shoplists = objects as? [PFObject] {
                    
                    
                    for object in shoplists {
                        
                       if (self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String)) && ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["updateDate"] as! NSDate).timeIntervalSince1970) {
                        
                        
                        
                       } else {
                        // so this case means that I need to retrieve that object and pin it
                        var newdate = NSDate()
                        object["updateDate"] = newdate
                        
                 
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                print("List saved in localdatastore")
                                
                                var id = object["listUUID"] as! String
                                //// here the function of changing*
                                
                                self.changeshoplistinfo(id)
                                
                                
                            } else {
                                
                                print("no list found")
                            }
                            
                        })
                        // *ALSO, here i must use the function to retrieve all new info from now already saved to localdatastore object and update this object in UserLists, UserShopList and probably UserFavLists
                        }
                        /*
                        
                        */
                        
                        
                    }
                    ///// SHOP ITEMS QUERY
                    var query22 = PFQuery(className:"shopItems")
                    query22.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                    query22.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            
                            print("Successfully retrieved \(objects!.count) scores.")
                            
                            if let shopitems = objects as? [PFObject] {
                                
                                
                                for object in shopitems {
                                    
                                    var itemid = object["itemUUID"] as! String
                                    self.checkshopitems(itemid)
                                    
                                    
                                    if self.itemisinlocal == true && ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["UpdateDate"] as! NSDate).timeIntervalSince1970) {
                                        
                                        print("Item is already in a local datastore and was updated")
                                        
                                    } else {
                                        // so this case means that I need to retrieve that object and pin it
                                        var newdate = NSDate()
                                        object["UpdateDate"] = newdate
                                        
                                        
                                        if object["isCatalog"] as! Bool == false {
                                            if object["defaultpicture"] as! Bool == false {
                                                
                                                if var imageFile = object["itemImage"] as? PFFile {
                                                    
                                                    var imageData = imageFile.getData()
                                                    
                                                    self.saveImageLocally(imageData)
                                                    
                                                    object["imageLocalPath"] = self.imagePath
                                                }                            //
                                            }
                                            
                                        }
                                        
                                        
                                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                            if success {
                                                
                                                print("Item is saved in localdatastore")
                                                

                                                
                                                
                                            } else {
                                                
                                                print("no list found")
                                            }
                                            
                                        })
                                        // *ALSO, here i must use the function to retrieve all new info from now already saved to localdatastore object and update this object in UserLists, UserShopList and probably UserFavLists
                                    }
                                    /*
                                    
                                    */
                                    
                                    
                                }
                                ///// TO DO LISTS QUERY
                                var query33 = PFQuery(className:"toDoLists")
                                query33.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                                query33.findObjectsInBackgroundWithBlock {
                                    (objects: [AnyObject]?, error: NSError?) -> Void in
                                    
                                    if error == nil {
                                        
                                        print("Successfully retrieved \(objects!.count) scores.")
                                        
                                        if let todolists = objects as? [PFObject] {
                                            
                                            
                                            for object in todolists {
                                                
                                               
                                                
                                                
                                                if (self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String)) && ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["updateDate"] as! NSDate).timeIntervalSince1970) && (object["isDeleted"] as! Bool == false) {
                                                    
                                                    print("To Do list already in a local datastore and was updated")
                                                    
                                                } else {
                                                    // so this case means that I need to retrieve that object and pin it
                                                    if object["isDeleted"] as! Bool == false {
                                                    var newdate = NSDate()
                                                    object["updateDate"] = newdate
                                                    object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                        if success {
                                                            
                                                            print("Item is saved in localdatastore")
                                                            self.restore()
                                                            var listid = object["listUUID"] as! String
                                                            self.changetodolistinfo(listid)
                                                            
                                                        } else {
                                                            
                                                            print("no list found")
                                                        }
                                                        
                                                    })
                                                    // *ALSO, here i must use the function to retrieve all new info from now already saved to localdatastore object and update this object in UserLists, UserShopList and probably UserFavLists
                                                    } else {
                                                        print("List is deleted")
                                                    }
                                                }
                                                /*
                                                
                                                */
                                                
                                                
                                            }
                                            ///// TO DO ITEMS QUERY
                                            var query44 = PFQuery(className:"toDoItems")
                                            query44.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                                            query44.findObjectsInBackgroundWithBlock {
                                                (objects: [AnyObject]?, error: NSError?) -> Void in
                                                
                                                if error == nil {
                                                    
                                                    print("Successfully retrieved \(objects!.count) scores.")
                                                    
                                                    if let todoitems = objects as? [PFObject] {
                                                        
                                                        
                                                        for object in todoitems {
                                                            
                                                            var itemid = object["itemUUID"] as! String
                                                            self.checktodoitems(itemid)
                                                            
                                                            
                                                            if self.todoitemisinlocal == true && ((object["ServerUpdateDate"] as! NSDate).timeIntervalSince1970 < (object["updateDate"] as! NSDate).timeIntervalSince1970) {
                                                                
                                                                print("To Do item already in a local datastore and was updated")
                                                                
                                                            } else {
                                                                // so this case means that I need to retrieve that object and pin it
                                                                var newdate = NSDate()
                                                                object["updateDate"] = newdate
                                                                object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                                    if success {
                                                                        
                                                                        print("Item is saved in localdatastore")
                                                                        
                                                                       
                                                                        
                                                                    } else {
                                                                        
                                                                        print("no list found")
                                                                    }
                                                                    
                                                                })
                                                                // *ALSO, here i must use the function to retrieve all new info from now already saved to localdatastore object and update this object in UserLists, UserShopList and probably UserFavLists
                                                            }
                                                            /*
                                                            
                                                            */
                                                            
                                                            
                                                        }
                                                        ///// CUSTOM CATEGORIES QUERY
                                                        var query55 = PFQuery(className:"shopListsCategory")
                                                        query55.whereKey("CatbelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
                                                        query55.findObjectsInBackgroundWithBlock {
                                                            (objects: [AnyObject]?, error: NSError?) -> Void in
                                                            
                                                            if error == nil {
                                                                
                                                                print("Successfully retrieved \(objects!.count) scores.")
                                                                
                                                                //customcategories.removeAll(keepCapacity: true)
                                                                
                                                                if let categories = objects as? [PFObject] {
                                                                    
                                                                    
                                                                    for object in categories {
                                                                        
                                                                      
                                                                        
                                                                        
                                                                         if (self.containslistid(customcategories.map({ $0.catId }), element: object["categoryUUID"] as! String)) {
                                                                            
                                                                            print("This custom category is already in a local datastore")
                                                                            
                                                                        } else {
                                                                            // so this case means that I need to retrieve that object and pin it
                                                                            
                                                                            /*
                                                                            object.pin()
                                                                            println("Item is saved in localdatastore")
                                                                            var categoryid = object["categoryUUID"] as! String
                                                                            // now add this cat to an array
                                                                            self.addcategorytolocalarray(categoryid)
                                                                            */
                                                                            
                                                                            
                                                                            var customId = object["categoryUUID"] as! String
                                                                            var customName = object["catname"] as! String
                                                                            var customIs = object["isCustom"] as! Bool
                                                                            var customImagePath = object["imagePath"] as! String
                                                                            var customIsAllowed = object["ShouldShowInCatalog"] as! Bool //TEMPORARILY SWITCHED THIS OFF!
                                                                            var customImage = UIImage()
                                                                            //customImage
                                                                            
                                                                            
                                                                            if object["defaultpicture"] as! Bool == true {
                                                                                
                                                                                var imagename = object["OriginalInDefaults"] as! String
                                                                                
                                                                                if (UIImage(named: "\(imagename)") != nil) {
                                                                                    customImage = UIImage(named: "\(imagename)")!
                                                                                } else {
                                                                                    customImage = imagestochoose[0].itemimage
                                                                                }
                                                                                
                                                                            } else {
                                                                                
                                                                                var imageFile = object["catimage"] as! PFFile
                                                                                
                                                                                var imageData = imageFile.getData()
                                                                                if (imageData != nil) {
                                                                                    var image = UIImage(data: imageData!)
                                                                                    customImage = image!
                                                                                    
                                                                                    self.saveImageLocally(imageData)
                                                                                    
                                                                                    object["imagePath"] = self.imagePath
                                                                                    
                                                                                } else {
                                                                                    customImage = imagestochoose[0].itemimage
                                                                                }
                                                                                
                                                                            }
                                                                            
                                                                            
                                                                            
                                                                            self.customcategory = Category(catId: customId, catname: customName, catimage: customImage, isCustom: customIs, isAllowed: customIsAllowed)
                                                                            
                                                                            print(self.customcategory)
                                                                            
                                                                            customcategories.append(self.customcategory!)
                                                                            catalogcategories.append(self.customcategory!)
                                                                            
                                                                            print(customcategories)
                                                                            print(catalogcategories)
                                                                            
                                                                            
                                                                            object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                                                if success {
                                                                                    
                                                                                    print("Item is saved in localdatastore")
                                                                                    var categoryid = object["categoryUUID"] as! String
                                                                                    // now add this cat to an array
                                                                                    //self.addcategorytolocalarray(categoryid)
                                                                                    
                                                                                } else {
                                                                                   // self.restore()
                                                                                    print("no list found")
                                                                                }
                                                                                
                                                                            })
                                                                            
                                                                            // *ALSO, here i must use the function to retrieve all new info from now already saved to localdatastore object and update this object in UserLists, UserShopList and probably UserFavLists
                                                                        }
                                                                        /*
                                                                        
                                                                        */
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    //self.addcustomstocategories(customcategories)
                                                                    
                                                                    ///// CUSTOM CAT ITEMS QUERY
                                                                    var query66 = PFQuery(className:"shopListCatalogItems")
                                                                    query66.whereKey("itemsbelongstouser", equalTo: PFUser.currentUser()!.objectId!)
                                                                    query66.findObjectsInBackgroundWithBlock {
                                                                        (objects: [AnyObject]?, error: NSError?) -> Void in
                                                                        
                                                                        if error == nil {
                                                                            
                                                                            print("Successfully retrieved \(objects!.count) scores.")
                                                                            
                                                                            if let catitems = objects as? [PFObject] {
                                                                                
                                                                                
                                                                                for object in catitems {
                                                                                    
                                                                                    
                                                                                    
                                                                                    
                                                                                    if (self.containslistid(customcatalogitems.map({ $0.itemId }), element: object["itemid"] as! String)) {
                                                                                        
                                                                                        print("This custom item is already in a local datastore")
                                                                                        
                                                                                    } else {
                                                                                        // so this case means that I need to retrieve that object and pin it
                                                                                        /*
                                                                                        object.pin()
                                                                                        println("Item is saved in localdatastore")
                                                                                        var itemid = object["itemid"] as! String
                                                                                    */

                                                                                        // now add this cat to an array
                                                                                        //self.addcustomitemtolocalarray(itemid)
                                                                                        
                                                                                  ////
                                                                                        
                                                                                        var customitemId = object["itemid"] as! String
                                                                                        var customitemName = object["itemname"] as! String
                                                                                        var customitemCategoryId = object["itemcategoryid"] as! String
                                                                                        var customitemImagePath = object["imagepath"] as! String
                                                                                        var customitemcategory : Category?
                                                                                        var customImage = UIImage()
                                                                                        //customImage
                                                                                        
                                                                                        
                                                                                        
                                                                                        if object["defaultpicture"] as! Bool == true {
                                                                                            
                                                                                            var imagename = object["OriginalInDefaults"] as! String
                                                                                            
                                                                                            if (UIImage(named: "\(imagename)") != nil) {
                                                                                                customImage = UIImage(named: "\(imagename)")!
                                                                                            } else {
                                                                                                customImage = imagestochoose[0].itemimage
                                                                                            }
                                                                                            
                                                                                        } else {
                                                                                            if object["itemimage"] != nil {
                                                                                                var imageFile = object["itemimage"] as! PFFile
                                                                                                
                                                                                                var imageData = imageFile.getData()
                                                                                                if (imageData != nil) {
                                                                                                    var image = UIImage(data: imageData!)
                                                                                                    customImage = image!
                                                                                                    
                                                                                                    self.saveImageLocally(imageData)
                                                                                                    
                                                                                                    object["imagepath"] = self.imagePath
                                                                                                    
                                                                                                } else {
                                                                                                    customImage = imagestochoose[0].itemimage
                                                                                                    
                                                                                                }
                                                                                            } else {
                                                                                                customImage = imagestochoose[0].itemimage
                                                                                            }
                                                                                            
                                                                                            
                                                                                        }
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                     //   if let foundcategory = find(lazy(customcategories).map({ $0.catId }), customitemCategoryId) {
                                                                                        
                                                                                         if let foundcategory = customcategories.map({ $0.catId }).lazy.indexOf(customitemCategoryId) {
                                                                                        
                                                                                            customitemcategory = customcategories[foundcategory]
                                                                                        } else {
                                                                                            
                                                                                            customitemcategory = catalogcategories[0]
                                                                                            
                                                                                        }
                                                                                        
                                                                                        // var customImage = UIImage()
                                                                                        
                                                                                        print(customitemcategory)
                                                                                        
                                                                                        self.customcatalogitem = CatalogItem(itemId: customitemId, itemname: customitemName, itemimage: customImage, itemcategory: customitemcategory!, itemischecked:false)
                                                                                        
                                                                                        
                                                                                        
                                                                                        customcatalogitems.append(self.customcatalogitem!)
                                                                                        
                                                                                        catalogitems.append(self.customcatalogitem!)
                                                                                        
                                                                                        print(customcatalogitems)
                                                                                        
                                                                                        print(catalogitems)

                                                                                        
                                                                                        ////

                                                                                        
                                                                                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                                                                            if success {
                                                                                                
                                                                                                print("Item is saved in localdatastore")
                                                                                                var itemid = object["itemid"] as! String
                                                                                                // now add this cat to an array
                                                                                                //self.addcustomitemtolocalarray(itemid)
                                                                                                
                                                                                                print(customcatalogitems)
                                                                                                
                                                                                            } else {
                                                                                                
                                                                                                print("no list found")
                                                                                            }
                                                                                            
                                                                                        })

                                                                                        // *ALSO, here i must use the function to retrieve all new info from now already saved to localdatastore object and update this object in UserLists, UserShopList and probably UserFavLists
                                                                                    }
                                                                                    /*
                                                                                    
                                                                                    */
                                                                                    
                                                                                    
                                                                                }
                                                                                
                                                                                // self.addcustomstocategories(customcategories)
                                                                                
                                                                                ///// CUSTOM CAT ITEMS QUERY
                                                                                var query77:PFQuery = PFUser.query()!
                                                                        
                                                                                query77.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
                                                                                query77.findObjectsInBackgroundWithBlock {
                                                                                    (objects: [AnyObject]?, error: NSError?) -> Void in
                                                                                    if error == nil {
                                                                                        print("Successfully retrieved \(objects!.count) scores.")
                                                                                        // Do something with the found objects
                                                                                        usercontacts.removeAll(keepCapacity: true)
                                                                                        contactsarray.removeAll(keepCapacity: true)
                                                                                        
                                                                                        if let users = objects as? [PFObject] {
                                                                                            
                                                                                           
                                                                                            
                                                                                            for object in users {
                                                                                                // println(object.objectId)
                                                                                                if let arr = object["UserContacts"] as? [AnyObject] {//!= nil {
                                                                                                    
                                                                                                    print(object["UserContacts"])
                                                                                                    
                                                                                                    contactsarray = object["UserContacts"] as! [[AnyObject]]
                                                                                                    //: [[AnyObject]]
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    for element in contactsarray {
                                                                                                        
                                                                                                        var avatar = UIImage()
                                                                                                        
                                                                                                        var imageFile = element[2] as? PFFile
                                                                                                        if imageFile != nil {
                                                                                                            var imageData = imageFile!.getData()
                                                                                                            if (imageData != nil) {
                                                                                                                var image = UIImage(data: imageData!)
                                                                                                                avatar = image!
                                                                                                            } else {
                                                                                                                avatar = defaultcatimages[1].itemimage
                                                                                                            }
                                                                                                        } else {
                                                                                                            avatar = defaultcatimages[1].itemimage
                                                                                                        }
                                                                                                        
                                                                                                        usercontacts.append(Contact(contactid:element[3] as! String,contactimage: avatar, contactname: element[0] as! String, contactemail: element[1] as! String))
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                    }
                                                                                                    
                                                                                                    /// LOAD EVENTS
                                                                                                    
                                                                                                    var query111 = PFQuery(className:"UsersEvents")
                                                                                                    query111.whereKey("SenderId", equalTo: PFUser.currentUser()!.objectId!)
                                                                                                    
                                                                                                    
                                                                                                    var query222 = PFQuery(className:"UsersEvents")
                                                                                                    query222.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
                                                                                                    
                                                                                                    
                                                                                                    let query = PFQuery.orQueryWithSubqueries([query111, query222])
                                                                                                    
                                                                                                    //var query1 = PFQuery(className:"UsersEvents")
                                                                                                    
                                                                                                    query.findObjectsInBackgroundWithBlock {
                                                                                                        (objects: [AnyObject]?, error: NSError?) -> Void in
                                                                                                        if error == nil {
                                                                                                             userevents.removeAll(keepCapacity: true)
                                                                                                            print("Successfully events retrieved \(objects!.count) scores.")
                                                                                                            // Do something with the found objects
                                                                                                            
                                                                                                            
                                                                                                            if let listitems = objects as? [PFObject] {
                                                                                                                for object in listitems {
                                                                                                                    
                                                                                                                    var etype = object["EventType"] as! String
                                                                                                                    var enote = object["EventText"] as! String
                                                                                                                    var edate = object.createdAt//object["createdAt"] as! NSDate
                                                                                                                    var euser = object["senderInfo"] as! [AnyObject]
                                                                                                                    var erecuser = object["receiverInfo"] as! [AnyObject]
                                                                                                                    
                                                                                                                    userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser))
                                                                                                                    
                                                                                                                }
                                                                                                                
                                                                                                                userevents.sort({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
                                                                                                                print("USER EVENTS \(userevents)")
                                                                        
                                                                                                                
                                                                                                                    var querycontacts:PFQuery = PFUser.query()!
                                                                                                                    querycontacts.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
                                                                                                                    
                                                                                                                    querycontacts.limit = 1
                                                                                                                    var thisusercontacts = querycontacts.findObjects()
                                                                                                                    if (thisusercontacts != nil) {
                                                                              
                                                                                                                        blacklistarray.removeAll(keepCapacity: true)
                                                                                                                        for thisusercontact in thisusercontacts! {
                                                                                                                            
                                                                                                                            if let blacklist = thisusercontact["blacklist"] as? [AnyObject] { //used to be username
                                                                                                                                
                                                                                                                                print(thisusercontact["blacklist"])
                                                                                                                                
                                                                                                                                blacklistarray.appendContentsOf(thisusercontact["blacklist"] as! [String])
                                                                                                                                
                                                                                                                           }
                                                                                                                            
                                                                                                                            
                                                                                                                        }
                                                                                                                        self.maindelegate?.refreshmainview()
                                                                                                                        self.restore()
                                                                                                                    
                                                                                                                    } else {
                                                                                                                        self.restore()
                                                                                                                      print("Error")
                                                                                                                    }
                                                                                                                
                                                                                                                
                                                                                                                //self.restore()
                                                                                                                
                                                                                                            }
                                                                                                            
                                                                                                            //self.addcustomstocatalogitems(customcatalogitems)
                                                                                                            
                                                                                                        } else {
                                                                                                            // Log details of the failure
                                                                                                            self.restore()
                                                                                                            print("Error: \(error!) \(error!.userInfo)")
                                                                                                        }
                                                                                                    }
                                                                                                    
                                                                                                    
                                                                                                } else {
                                                                                                    self.restore()
                                                                                                    
                                                                                                  print("no contacts so far")
                                                                                                }
                                                                                                
                                                                                            }
                                                                                            
                                                                                        } else {
                                                                                            // Log details of the failure
                                                                                            self.restore()
                                                                                            print("Error: \(error!) \(error!.userInfo)")
                                                                                        }
                                                                                    } else {
                                                                                        self.restore()
                                                                                        print("Error: \(error!) \(error!.userInfo)")
                                                                                    }
                                                                                    
                                                                                    //self.tableView.reloadData()
                                                                                }
                                                                            }
                                                                            
                                                                            //self.restore()
                                                                        } else {
                                                                            // Log details of the failure
                                                                            self.restore()
                                                                            print("Error: \(error!) \(error!.userInfo)")
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                //self.restore()
                                                            } else {
                                                                // Log details of the failure
                                                                self.restore()
                                                                print("Error: \(error!) \(error!.userInfo)")
                                                            }
                                                        }
                                                    }
                                                    
                                                    //self.restore()
                                                } else {
                                                    // Log details of the failure
                                                    self.restore()
                                                    print("Error: \(error!) \(error!.userInfo)")
                                                }
                                            }
                                        }
                                        
                                        //self.restore()
                                    } else {
                                        // Log details of the failure
                                        self.restore()
                                        print("Error: \(error!) \(error!.userInfo)")
                                    }
                                }
                            }
                            
                            //self.restore()
                        } else {
                            // Log details of the failure
                            self.restore()
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                self.restore()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        /*
        
        var query = PFQuery(className:"shopLists")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.orderByDescending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
        
            if error == nil {
        
                println("Successfully retrieved \(objects!.count) scores.")
        
                if let lists = objects as? [PFObject] {
        
        
                    for object in lists {
        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
  
                                println("List saved")

                            } else {
                                println("no list found")
                            }
                        })

                        
                        
                    }

                }
                
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        var query2 = PFQuery(className:"shopItems")
        query2.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query2.orderByDescending("updateDate")
        query2.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let shopitems = objects as? [PFObject] {
                    
                    
                    for object in shopitems {
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("item saved")
                                
                            } else {
                                println("no item found")
                            }
                        })
                        
                        
                        
                    }
                    
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        var query3 = PFQuery(className:"shopListCatalogItems")
        query3.whereKey("itemsbelongstouser", equalTo: PFUser.currentUser()!.objectId!)
        query3.orderByDescending("updateDate")
        query3.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let catitems = objects as? [PFObject] {
                    
                    
                    for object in catitems {
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        
                        
                    }
                    
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        var query4 = PFQuery(className:"shopListsCategory")
        query4.whereKey("CatbelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query4.orderByDescending("updateDate")
        query4.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let cats = objects as? [PFObject] {
                    
                    
                    for object in cats {
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        
                        
                    }
                    
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }

        var query5 = PFQuery(className:"toDoLists")
        query5.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query5.orderByDescending("updateDate")
        query5.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        
                        
                    }
                    
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }

        var query6 = PFQuery(className:"toDoItems")
        query6.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query6.orderByDescending("updateDate")
        query6.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let items = objects as? [PFObject] {
                    
                    
                    for object in items {
                        
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        
                        
                    }
                    
                }
                
                //self.restore()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }

        // not sure if needed but still
        var query7:PFQuery = PFUser.query()!
        query7.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let thisuser = thisuser {
                    
                    thisuser.pinInBackgroundWithBlock({ (success, error) -> Void in
                        if success {

                        } else {
                            println("error")
                        }
                    })


               
            }
        }

        
        maindelegate?.loaduserdata()
        maindelegate?.refreshmainview()
        
        // here just call loadusedatafunction in main delegate
        */
    }
    
    
    func deleteevents() {
        
        //deleteallevents
        
        pausedel()
        
        userevents.removeAll(keepCapacity: true)
        
        var query1 = PFQuery(className:"UsersEvents")
        query1.whereKey("SenderId", equalTo: PFUser.currentUser()!.objectId!)
        query1.whereKey("isReceived", equalTo: true)
        
        var query2 = PFQuery(className:"UsersEvents")
        query2.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
        query2.whereKey("isReceived", equalTo: true)
        
        let query = PFQuery.orQueryWithSubqueries([query1, query2])

        query.fromLocalDatastore()
        query.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isReceived", equalTo: false)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                //userevents.removeAll(keepCapacity: true)
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                //receivedeventscount = objects!.count
                
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                       
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                              
                                
                            } else {
                                print("no id found")
                            }
                        })
                        
                        
                        
                    }
                    
                    self.restoredel()
                   
                    
                    
                    
                }
                
                //self.addcustomstocatalogitems(customcatalogitems)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
    }
    
    
    func notificationswitcherchanged(sender: UISwitch) {
        
        print("SWITCH CHANGED")
    }
    
    
    /// TABLE STUFF
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if (section == 0) {
            return account.count
        } else if (section == 1) {
            return app.count
        } else if (section == 2) {
            return support.count
        } else if (section == 3) {
            return about.count
        } else {
            return 0
        }
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        if (section == 0)
        {
            return NSLocalizedString("accdet", comment: "")
        } else if (section == 1)
        {
            return NSLocalizedString("appset", comment: "")
        } else if (section == 2)
        {
            return NSLocalizedString("sup", comment: "")
        } else if (section == 3)
        {
            return NSLocalizedString("about", comment: "")
        }
        return nil
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
        
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
  
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
       // header.contentView.backgroundColor = UIColorFromRGB(0x2A2F36)//UIColor(red: 238/255, green: 168/255, blue: 15/255, alpha: 0.8)
        header.textLabel!.textColor = UIColorFromRGB(0x31797D)//UIColor.whiteColor()
        header.alpha = 1
        
        var topline = UIView(frame: CGRectMake(0, 0, header.contentView.frame.size.width, 1))
        topline.backgroundColor = UIColorFromRGB(0x31797D)
        
       // header.contentView.addSubview(topline)
        
        var bottomline = UIView(frame: CGRectMake(0, 30, header.contentView.frame.size.width, 1))
        bottomline.backgroundColor = UIColorFromRGB(0x31797D)
        
      //  header.contentView.addSubview(bottomline)

        
        var positionx = header.contentView.frame.size.width * 0.9
        var positiony = header.contentView.frame.size.height / 15//* 0.1
        var imageViewGame = UIImageView(frame: CGRectMake(positionx, positiony, 26, 26));
        var image = UIImage(named: "GreenSet");
        imageViewGame.image = image;
        header.contentView.addSubview(imageViewGame)
        
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var accountcell: accountsettings!
        var appcell: appsettings!
        var supportcell: supportsettings!
        var aboutcell: aboutsettings!
        
        
        
        if (indexPath.section == 0) {
            accountcell = tableView.dequeueReusableCellWithIdentifier("account", forIndexPath: indexPath) as! accountsettings
            
            accountcell.name.text = account[indexPath.row]
            accountcell.icon.image = accounticons[indexPath.row]
            
            
        } else if (indexPath.section == 1) {
            appcell = tableView.dequeueReusableCellWithIdentifier("app", forIndexPath: indexPath) as! appsettings
            
            appcell.name.text = app[indexPath.row]
            appcell.icon.image = appicons[indexPath.row]
            
           // appcell.userInteractionEnabled = false
            
           // var somebutton  = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            //var positionx = appcell.frame.size.width * 0.7 - 30
           // var positiony = (appcell.frame.size.height * 0.5) - 20
           // somebutton.frame = CGRectMake(positionx,positiony, 100, 40)
            //CGRect(x: 0, y: yPos, width: buttonWidth-0.5, height: self.buttonHeight)
            //  somebutton.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
            /*
            if indexPath.row == 3 {
            
            let positionx = appcell.frame.size.width * 0.7
            let positiony = (appcell.frame.size.height * 0.5) - 20
            let switcher=UISwitch(frame:CGRectMake(positionx, positiony, 0, 0))
            switcher.on = true
            switcher.setOn(true, animated: false)
            switcher.addTarget(self, action: "notificationswitcherchanged:", forControlEvents: .ValueChanged);
            appcell.addSubview(switcher)
            
            }
            */

            
        } else if (indexPath.section == 2) {
            supportcell = tableView.dequeueReusableCellWithIdentifier("support", forIndexPath: indexPath) as! supportsettings // just return the cell without any changes to show whats designed in storyboard
            supportcell.name.text = support[indexPath.row]
            supportcell.icon.image = supporticons[indexPath.row]
            
            
            
        } else if (indexPath.section == 3) {
         
             aboutcell = tableView.dequeueReusableCellWithIdentifier("about", forIndexPath: indexPath) as! aboutsettings
            aboutcell.name.text = about[indexPath.row]
            aboutcell.icon.image = abouticons[indexPath.row]
        }
        
        
        
        if (indexPath.section == 0) {
            
            return accountcell
        } else if (indexPath.section == 1) {
            
            return appcell
        } else if (indexPath.section == 2) {
            
            return supportcell
        } else {
            // 3 section
            return aboutcell
        }
    
    }
    
    
    
    @IBAction func unwindToSettingsVC(sender: UIStoryboardSegue) {
        // 
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    ////// EMAIL STUFF
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: NSLocalizedString("CantSend", comment: "NoConnection"), message: NSLocalizedString("NoEmailInfo", comment: ""), delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func reportproblem() { //BIGSENDER
        
        
        
        
        
        let receivermail : String = "pekkipodev@gmail.com"
        
        
        
        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setToRecipients([receivermail])
            mailComposer.setSubject("\(NSLocalizedString("reportproblem1", comment: ""))")
            
            
            var body: String = "<html><body><h1>Report</h1>" //<br/>"
            
            var usertext = NSLocalizedString("reportproblem2", comment: "")
            
            
            body = body + "<div><p>\(usertext)</p></div>"
            
            
            body = body + "</body></html>"
            mailComposer.setMessageBody(body, isHTML: true)
            
            
            
            
            self.presentViewController(mailComposer, animated: true, completion: nil)
            
        } else {
            self.showSendMailErrorAlert()
        }
        
    }

    
    func rateApp(){
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1083564553")!);
        
    }
    
    func contactdevs() { //BIGSENDER
        
        
        
        
        
        let receivermail : String = "pekkipodev@gmail.com"
        
        
        
        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setToRecipients([receivermail])
            mailComposer.setSubject("")
            
            
            var body: String = "<html><body><h1>Report</h1>" //<br/>"
            
           // var usertext = NSLocalizedString("reportproblem2", comment: "")
            
            
           // body = body +
            
            
            body = body + "</body></html>"
            mailComposer.setMessageBody(body, isHTML: true)
            
            
            
            
            self.presentViewController(mailComposer, animated: true, completion: nil)
            
        } else {
            self.showSendMailErrorAlert()
        }
        
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
        
            if indexPath.row == 0 {
                
                performSegueWithIdentifier("showaccountdetails", sender: self)
                
            } else if indexPath.row == 1 {
                
                self.synchronize()
                
            }  else if indexPath.row == 2 {
                
                performSegueWithIdentifier("OpenContacts", sender: self)
                
            } else if indexPath.row == 3 {
                
                performSegueWithIdentifier("sharinghistoryfromsettings", sender: self)
                
            } else if indexPath.row == 4 {
                
                userlogout()
            }
            

            
        } else if indexPath.section == 1 {
                
                if indexPath.row == 0 {
                    
                    performSegueWithIdentifier("editcategories", sender: self)
                    
                } else if indexPath.row == 1 {
                    
                    performSegueWithIdentifier("showfavouritesinfo", sender: self)
                    
                } else if indexPath.row == 2 {
                    
                    self.deleteevents() //YOOO
                    
                    //performSegueWithIdentifier("showcurrenciesinfo", sender: self)
                    
                }
                /*else if indexPath.row == 3 {
                    
                    performSegueWithIdentifier("languagessegue", sender: self)
                }   */
            } else if indexPath.section == 2 {
                    
                    if indexPath.row == 0 {
                        
                     contactdevs()
                        
                        // FEEDBACK
                        
                    } else if indexPath.row == 1 {
                        
                      // REPORT A PROBLEM
                        
                        reportproblem()
                      
                        
                    } else if indexPath.row == 2 {
                        
                       // RATE APP
                        rateApp()
                    }
                        
                } else if indexPath.section == 3 {
                            
                            if indexPath.row == 0 {
                                
                                performSegueWithIdentifier("aboutfromsettings", sender: self)
                                
                                //
                                
                            } else if indexPath.row == 1 {
                                
                                // 
                                performSegueWithIdentifier("showacknowledgments", sender: self)
                                
                                
                            } else if indexPath.row == 2 {
                                
                                //
                                performSegueWithIdentifier("showpolicy", sender: self)
                                
                                
            }
                    }



        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //println(self.shoppingListItemsIds[row])
    }


}
