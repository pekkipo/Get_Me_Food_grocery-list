//
//  MainMenuViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 03/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation
import Parse
import SystemConfiguration

/*
protocol sendBackParametersToShopDelegate
{
    func getshopparameters(isFrom: Bool, listid:String, isreceived: Bool)
}
*/



var loggedusername = String()
var loggeduseremail = String()
var loggeduserimage = UIImage()

var receivedtodocount = Int32()
var receivedshopscount = Int32()
var receivedcount = Int()

var receivedeventscount = Int()

var mesalert = String()

var usercontacts = [Contact]()

var userevents = [Event]()

var contactsarray = [[AnyObject]]()

var commoncurrencies = [[String]]()

protocol refreshliststableDelegate
{
    func refreshListsTable(sentshowoption: String)
}

class MainMenuViewController: UIViewController, passtodoListtoMenuDelegate, refreshmainviewDelegate {//, passListtoMenuDelegate {//, sendBackParametersToShopDelegate {
    

    
    var delegateshowlists : refreshliststableDelegate?
    
    func refreshmainview() {
        
        
        
        tableView.reloadData()
    }
    
    
    @IBAction func LoginBar(sender: AnyObject) {
        
        performSegueWithIdentifier("showlogin", sender: self)
    }
    
    
    @IBAction func SettingsBar(sender: AnyObject) {
        
       performSegueWithIdentifier("opensettings", sender: self)
    }
    
    
    let progressHUD = ProgressHUD(text: "Loading")
    
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

        
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dimmerView: UIView!
    @IBOutlet var bgImageView: UIImageView!
    
    
    @IBOutlet var darkview: UIView!
    

    
    var isFromShopList = Bool()
    var shoplistid = String()
    var shopisreceived = Bool()

   

    //receiveinfo from shoppinglistcreation
   
    
    var isFromToDoList = Bool()
    var todolistid = String()
    var todoisreceived = Bool()
    
    func gettodolistparameters(isFrom:Bool,listid:String,isreceived:Bool) {
        
        isFromToDoList = isFrom
        todolistid = listid
        todoisreceived = isreceived
       
        
    }

    
    var snapshot : UIView = UIView()
    var transitionOperator = TransitionOperator()
    
    
    
    func sendtoalllists(sender: UIView!) {
        
      delegateshowlists?.refreshListsTable("alllists")
      
        
        performSegueWithIdentifier("showalllistssegue", sender: self)
        
    }
    
    func sendtoshoplist(sender: UIView!) {
        //performSegueWithIdentifier("createnewshoplist", sender: self)
        performSegueWithIdentifier("openshoplist", sender: self)
    }
    func sendtotodo(sender: UIView!) {
        //performSegueWithIdentifier("createnewtodolist", sender: self)
        performSegueWithIdentifier("opentodolist", sender: self)
    }
    
    
    
    func getavatar() -> UIImage{
        let query:PFQuery = PFUser.query()!
         query.fromLocalDatastore()
            query.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let thisuser = thisuser {
                
                let pfavatar = thisuser["Avatar"] as! PFFile
                pfavatar.getDataInBackgroundWithBlock { (data, error) -> Void in
                    if let downloadedImage = UIImage(data: data!) {
                        loggeduserimage = downloadedImage
                    }
                    
                }
                
                self.tableView.reloadData()
            }
        }
        return loggeduserimage
    }
    
    
    @IBAction func unwindToMainMenu (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //// I DON'T USE THIS FUNCTION NOW
    func countreceivedlists() {
        //Count shops
        let query1 = PFQuery(className:"shopLists")
        query1.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query1.whereKey("isReceived", equalTo: true)
        query1.whereKey("isSaved", equalTo: false)
        query1.whereKey("isDeleted", equalTo: false)
        query1.whereKey("confirmReception", equalTo: false)
        query1.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                receivedshopscount = count
            }
        }
        //Count todos
        let query2 = PFQuery(className:"toDoLists")
        query2.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query2.whereKey("isReceived", equalTo: true)
        query2.whereKey("isSaved", equalTo: false)
        query2.whereKey("isDeleted", equalTo: false)
        query2.whereKey("confirmReception", equalTo: false)
        query2.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                receivedtodocount = count
            }
        }

    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 8
    }
    
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clearColor()
    return headerView
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
     
        return nil
        
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var cell: UITableViewCell!
        var showall : showallcell!
        var logincell: LoginInfoCell!
        var createshop: createshopcell!
        var createtodo: createtodocell!
        var history: menusharecell!
        var events: menueventscell!
        var settings: menusettingscell!
        var help: menuhelpcell!
        
       
        
        if indexPath.section == 0 {
        logincell = tableView.dequeueReusableCellWithIdentifier("logininfocell", forIndexPath: indexPath) as! LoginInfoCell
             logincell.backgroundColor = UIColor.clearColor()
            //logincell.backgroundColor = UIColorFromRGB(0x2A2F36)
            
            logincell.username.text = loggedusername
            if loggedIn == true {
            logincell.useremail.text = loggeduseremail
            } else {
               logincell.useremail.text = NSLocalizedString("TapHere", comment: "TapInfo")
            }
            //var size = CGSize(width: 100, height: 100)
            logincell.userimage.image = loggeduserimage//UIImage(named: "checkeduser.png")!//loggeduserimage
            logincell.userimage.layer.cornerRadius = logincell.userimage.layer.frame.size.width / 2
            logincell.userimage.layer.masksToBounds = true


            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            logincell.selectedBackgroundView = backgroundView
            
            
        } else if indexPath.section == 1 {
             createshop = tableView.dequeueReusableCellWithIdentifier("createshoplist", forIndexPath: indexPath) as! createshopcell
             createshop.backgroundColor = UIColor.clearColor()

            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            createshop.selectedBackgroundView = backgroundView
        }
        else if indexPath.section == 2 {
            createtodo = tableView.dequeueReusableCellWithIdentifier("createtodolist", forIndexPath: indexPath) as! createtodocell
             createtodo.backgroundColor = UIColor.clearColor()

            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            createtodo.selectedBackgroundView = backgroundView
        }
        else if indexPath.section == 3 {
            showall = tableView.dequeueReusableCellWithIdentifier("showalllists", forIndexPath: indexPath) as! showallcell
                showall.backgroundColor = UIColor.clearColor()
             let itemcount : String = String(UserLists.count)
            
                showall.receiveditemcount.text = String(receivedcount)
                if receivedcount > 0 {
                showall.receivedcontainer.hidden = false
                } else {
                   showall.receivedcontainer.hidden = true
                }
            
            showall.itemname.text = "\(NSLocalizedString("mylists", comment: ""))  (\(itemcount))"
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            showall.selectedBackgroundView = backgroundView
        }
        else if indexPath.section == 4 {
           history = tableView.dequeueReusableCellWithIdentifier("showsharing", forIndexPath: indexPath) as! menusharecell
             history.backgroundColor = UIColor.clearColor()

            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            history.selectedBackgroundView = backgroundView
        }
        else if indexPath.section == 5 {
            events = tableView.dequeueReusableCellWithIdentifier("showevents", forIndexPath: indexPath) as! menueventscell
             events.backgroundColor = UIColor.clearColor()
            if receivedeventscount > 0 {
                events.eventscountlabel.text = String(receivedeventscount)
                events.redview.hidden = false
            } else {
                events.redview.hidden = true
            }
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            events.selectedBackgroundView = backgroundView
            
        }
        else if indexPath.section == 6 {
            settings = tableView.dequeueReusableCellWithIdentifier("showsettings", forIndexPath: indexPath) as! menusettingscell
             settings.backgroundColor = UIColor.clearColor()
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            settings.selectedBackgroundView = backgroundView
        }
        else if indexPath.section == 7 {
            help = tableView.dequeueReusableCellWithIdentifier("showhelp", forIndexPath: indexPath) as! menuhelpcell
            help.backgroundColor = UIColor.clearColor()
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp:0.3)
            help.selectedBackgroundView = backgroundView
        }

        if indexPath.section == 0 {
        return logincell
        } else if indexPath.section == 1 {
            return createshop
        } else if indexPath.section == 2 {
            return createtodo
        } else if indexPath.section == 3 {
            return showall
        } else if indexPath.section == 4 {
            return history
        } else if indexPath.section == 5 {
            return events
        } else if indexPath.section == 6 {
            return settings
        } else if indexPath.section == 7 {
            return help
        } else {
            return cell
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            
           // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
            //if UIScreen.mainScreen().sizeType == .iPhone4 {
               if UIScreen.mainScreen().nativeBounds.height == 960 {
            
                return 66
            }
            
        return 74.0 //Choose your custom row height
        } else {
            
          //  if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
           // if UIScreen.mainScreen().sizeType == .iPhone4 {
                if UIScreen.mainScreen().nativeBounds.height == 960 {
                return 40
            }
            
        return 56//49
        }
    }
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.snapshot.removeFromSuperview()
        
        if (indexPath.section == 0) {
            
            if loggedIn == true {
                performSegueWithIdentifier("menushowaccount", sender: self)
            } else {
                 performSegueWithIdentifier("showlogin", sender: self)
            }

            //performSegueWithIdentifier("menushowaccount", sender: self)
        } else if (indexPath.section == 1) {
            performSegueWithIdentifier("createnewshoplist", sender: self)
            
            
            ///might need this!
            // MARK: commented itemsDataDict removal
           // itemsDataDict.removeAll(keepCapacity: true)
            HistoryitemsDataDict.removeAll(keepCapacity: true)
            
            for var i = 0;i<catalogitems.count;++i {
                
                catalogitems[i].itemischecked = false
                
            }
            
        } else if (indexPath.section == 2) {
            performSegueWithIdentifier("createnewtodolist", sender: self)
            toDoItems.removeAll(keepCapacity: true)
        } else if (indexPath.section == 3) {
            performSegueWithIdentifier("showalllistssegue", sender: self)
        } else if (indexPath.section == 4) {
            performSegueWithIdentifier("showstatisticsmenu", sender: self)
        } else if (indexPath.section == 5) {
            performSegueWithIdentifier("showeventssegue", sender: self)
        } else if (indexPath.section == 6) {
            performSegueWithIdentifier("opensettings", sender: self)
        } else if (indexPath.section == 7) {
            performSegueWithIdentifier("showhelp", sender: self)
        }
        
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /*
        let toViewController = segue.destinationViewController as! UIViewController
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self.transitionOperator
        */
        /////// This is for fancy slide-out stuff
        
        
        if segue.identifier == "showstatisticsmenu" {
            
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let  toViewController = navVC.viewControllers.first as! GraphsVC
            
            
            toViewController.senderVC = "Menu"
            
            
            
            
        }
        
        if segue.identifier == "showalllistssegue" {
            
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let  toViewController = navVC.viewControllers.first as! AllListsVC
            

            toViewController.showoption = "alllists"
            
            toViewController.maindelegate = self
            
           
        }
        
        //createnewshoplist

        if segue.identifier == "createnewshoplist" {

            let navVC1 = segue.destinationViewController as! UINavigationController
            
            let toViewController = navVC1.viewControllers.first as! ShoppingListCreation

                toViewController.justCreatedList = true
                toViewController.senderVC = self
                toViewController.isReceivedList = false
            
            
            
        }
        
        if segue.identifier == "openshoplist" {
            let toViewController = segue.destinationViewController as! ShoppingListCreation


            
            toViewController.justCreatedList = false
            //toViewController.currentList = globalshoplistid
            toViewController.activeList = shoplistid
            toViewController.senderVC = self
            toViewController.isReceivedList = shopisreceived
            

        
        }

        
        if segue.identifier == "createnewtodolist" {
            

            
            let navVC1 = segue.destinationViewController as! UINavigationController
            
            let toViewController = navVC1.viewControllers.first as! ToDoListCreation
            
            toViewController.justCreated = true
           
            toViewController.senderVC = self
            
            toViewController.delegatefortodolist = self
            
            toViewController.isReceived = false
        }
        
        if segue.identifier == "opentodolist" {
            
            let toViewController = segue.destinationViewController as! ToDoListCreation
            
            
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            toViewController.transitioningDelegate = self.transitionOperator
            
          //  if isFromToDoList == true {
                
            toViewController.justCreated = false
            //toViewController.currentList = globalshoplistid
            toViewController.activelist = todolistid
            toViewController.senderVC = self
            toViewController.isReceived = todoisreceived
            
            toViewController.delegatefortodolist = self
        

        }

        
        if segue.identifier == "opensettings" {
            
            //let toViewController = segue.destinationViewController as! SettingsViewController
            let navVC = segue.destinationViewController as! UINavigationController
            
            let  SettingsVC = navVC.viewControllers.first as! SettingsViewController
            
            SettingsVC.maindelegate = self
        }
        
        if segue.identifier == "showlogin" {
            

            let navVC = segue.destinationViewController as! UINavigationController
            
            let loginVC = navVC.viewControllers.first as! LoginViewController
            
            loginVC.maindelegate = self
        }
        
        if segue.identifier == "menushowaccount" {
            

            let navVC = segue.destinationViewController as! UINavigationController
            
           let accountVC = navVC.viewControllers.first as! AccountDetailsVC
            
            accountVC.maindelegate = self
            accountVC.senderVC = "MainMenu"
        }
        
        if segue.identifier == "menushowsharing" {
            
            //let toViewController = segue.destinationViewController as! SettingsViewController
            let navVC = segue.destinationViewController as! UINavigationController
            
            let shareVC = navVC.viewControllers.first as! SharingHistoryTableViewController
            
            shareVC.sendercontroller = "MainMenu"
            
            
        }
        
        if segue.identifier == "showeventssegue" {
            
            //let toViewController = segue.destinationViewController as! SettingsViewController
         let tabVC = segue.destinationViewController as! UITabBarController//UINavigationController
            
            let eventsVC = tabVC.viewControllers!.first as! UINavigationController //EventsVC
            
            let VC = eventsVC.viewControllers.first as! SharingHistoryTableViewController
            
            
           // eventsVC.delegate = self
            
            
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
    
    
    
    ///// LOADING THE LISTS PART
    
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
   
    
    func listsretrieval() {
        
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
        UserLists.removeAll(keepCapacity: true)
        UserFavLists.removeAll(keepCapacity: true)
        
        pause()
        
        var query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
       // query.orderByDescending("updateDate")
        query.orderByDescending("creationDate")
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
                                
                       // var listcreationdate = object["updateDate"] as! NSDate
                          var listcreationdate = object["creationDate"] as! NSDate
                                
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
                            
                            //Doing this in order to compensate for deleted color in previous versions
                            if listscolor == "DAFFA4" {
                                listscolor = "A2AF36"
                            }
                        
                        
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
        // querytodo.orderByDescending("updateDate")
        querytodo.orderByDescending("CreationDate")
        
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
                       // var listcreationdate = object["updateDate"] as! NSDate
                         var listcreationdate = object["CreationDate"] as! NSDate
                                
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
    
    
    func sortListsDESC(compare:UserList, to:UserList) -> Bool {
        return compare.listcreationdate.compare(to.listcreationdate) == NSComparisonResult.OrderedAscending//Descending
    }

    func containslistid(values: [String], element: String) -> Bool {

        for value in values {

            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }

   // var receivedcount : Int = 0
    
    func checkreceivedlists() {
        
       // receivedcount = 0
        
        
        //CHECK SHOP LISTS
        var query = PFQuery(className:"shopLists")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isReceived", equalTo: true)
        query.whereKey("isSaved", equalTo: false)
        query.whereKey("isDeleted", equalTo: false)
        query.whereKey("confirmReception", equalTo: false)
       // query.orderByDescending("updateDate")
        query.orderByDescending("creationDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                
                if let lists = objects as? [PFObject] {
                    
                    for object in lists {
                        print(object.objectId)
                        
                        if (object["listUUID"] != nil) && (object["ShopListName"] != nil) && (object["ShopListNote"] != nil) && (object["updateDate"] != nil) && (object["isFavourite"] != nil) && (object["isReceived"] != nil) && (object["BelongsToUser"] != nil) && (object["sentFromArray"] != nil) &&
                            (object["isSaved"] != nil) && (object["confirmReception"] != nil) &&
                            (object["listUUID"] != nil) && (object["ShopListName"] != nil) &&
                            (object["isDeleted"] != nil) && (object["isShared"] != nil) &&
                            (object["ShareWithArray"] != nil) && (object["ItemsCount"] != nil) &&
                            (object["CheckedItemsCount"] != nil) && (object["CurrencyArray"] != nil) &&
                            (object["ShowCats"] != nil) &&
                            (object["ListColorCode"] != nil) { //ListCurrency doesn't matter now
                     
                        if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserShopLists.map({ $0.listid }), element: object["listUUID"] as! String){
                            
                            print("object is already retrieved from local datastore")
                        } else {
                            
                            var listid = object["listUUID"] as! String
                            var listname = object["ShopListName"] as! String
                            var listnote = object["ShopListNote"] as! String
                          //  var listcreationdate = object["updateDate"] as! NSDate
                             var listcreationdate = object["creationDate"] as! NSDate
                            
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
                            
                            var receivedshoplist : UserList = UserList(
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
                                listcolorcode:listscolor
                                
                            )
                            
                           // object.pinInBackground()
                            
                            UserShopLists.append(receivedshoplist)
                            
                            //UserLists.extend(UserShopLists)
                            UserLists.append(receivedshoplist)
                            
                            if listisfav == true {
                                UserFavLists.append(receivedshoplist)
                            }

                            
                            
                            //self.tableView.reloadData() // without this thing, table would contain only 1 row
                            
                            receivedcount += 1
                            receivedshopscount += 1
                            
                            dispatch_async(dispatch_get_main_queue()) {
                            
                            self.tableView.reloadData()
                            }
                        }
                        
                        
                    } else {
                            //self.restore()
                        print("There is a nil value in a list!")
                    }
                       // }
                        
                        //receivedcount += 1
                        
                        //object.pinInBackground()
                        //I think I do it later when saving
                    }
                    
                    
                }
            } else {
                // Log details of the failure
               // self.restore()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
        //CHECK TODO LISTS
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.whereKey("isReceived", equalTo: true)
        querytodo.whereKey("isSaved", equalTo: false)
        querytodo.whereKey("isDeleted", equalTo: false)
        querytodo.whereKey("confirmReception", equalTo: false)
       // querytodo.orderByDescending("updateDate")
        querytodo.orderByDescending("CreationDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                
                if let lists = objects as? [PFObject] {
                    
                    for object in lists {
                        print(object.objectId)
                        
                        if (object["listUUID"] != nil) && (object["ToDoListName"] != nil) && (object["ToDoListNote"] != nil) && (object["updateDate"] != nil) && (object["isFavourite"] != nil) && (object["isReceived"] != nil) && (object["BelongsToUser"] != nil) && (object["SentFromArray"] != nil) &&
                            (object["isSaved"] != nil) && (object["confirmReception"] != nil) &&
                            (object["listUUID"] != nil) && (object["ShopListName"] != nil) &&
                            (object["isDeleted"] != nil) && (object["isShared"] != nil) &&
                            (object["ShareWithArray"] != nil) && (object["ItemsCount"] != nil) &&
                            (object["CheckedItemsCount"] != nil) &&
                            (object["ListColorCode"] != nil) {
                                

                        
                        if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserShopLists.map({ $0.listid }), element: object["listUUID"] as! String){
                            
                            print("object is already retrieved from local datastore")
                        } else {

                        
                        var listid = object["listUUID"] as! String
                        var listname = object["ShopListName"] as! String
                        var listnote = object["ShopListNote"] as! String
                       // var listcreationdate = object["updateDate"] as! NSDate
                            var listcreationdate = object["CreationDate"] as! NSDate
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
                        var listtype = "ToDo"
                        var listscolor = object["ListColorCode"] as! String
                       // var listcurrency = object["ListCurrency"] as! String
                       // var listshowcats = object["ShowCats"] as! Bool
                        
                        
                        var receivedtodolist : UserList = UserList(
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
                            listcolorcode:listscolor
                            
                        )
                        
                        UserToDoLists.append(receivedtodolist)
                        UserLists.append(receivedtodolist)
                            
                            if listisfav == true {
                                UserFavLists.append(receivedtodolist)
                            }

                        
                        
                       // self.tableView.reloadData() // without this thing, table would contain only 1 row
                        
                            receivedcount += 1
                            receivedtodocount += 1
                            
                            
                        }
                        
                    } else {
                        print("There is a nil value in a list!")
                        
                    }
                    
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.tableView.reloadData()
                    }

                    
                    if receivedcount != 0 {
                        
                        //self.displayAlert("Incoming lists!", message: "You have received \(String(self.receivedcount)) lists")
                    }
                    //self.displayAlert("Incoming lists!", message: "You have received lists")
                    
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
       
        
        for var i = 0;i<catalogitems.count;++i {
            
            catalogitems[i].itemischecked = false
            
        }
        
        tableView.reloadData()
    }
    
    func loaddata() {
        
    }
    
    
    func loaduserdata() {
        
       
        customcategories.removeAll(keepCapacity: true)
        customcatalogitems.removeAll(keepCapacity: true)
        
        
        itemsDataDict.removeAll(keepCapacity: true)
        itemsinbuffer.removeAll(keepCapacity: true)
        itemsinbuffertopaste.removeAll(keepCapacity: true)
        HistoryitemsDataDict.removeAll(keepCapacity: true)
        
        userevents.removeAll(keepCapacity: true)
        usercontacts.removeAll(keepCapacity: true)
        blacklistarray.removeAll(keepCapacity: true)
        contactsarray.removeAll(keepCapacity: true)
        
        for var i = 0;i<catalogitems.count;++i {
            
            catalogitems[i].itemischecked = false
            
        }
        
        toDoItems.removeAll(keepCapacity: true)
        
        if (PFUser.currentUser() != nil) && !PFAnonymousUtils.isLinkedWithUser(PFUser.currentUser()) {
            
            
            //loggedusername = PFUser.currentUser()!.username!
            if PFUser.currentUser()!.email != nil {
                loggeduseremail = PFUser.currentUser()!.email!
                //loggedusername = PFUser.currentUser()!.username!
                loggedusername = PFUser.currentUser()?["name"] as! String
                loggedIn = true
            } else {
                loggedIn = false
                loggeduseremail = ""
                loggedusername = NSLocalizedString("Anonymous", comment: "")
            }
            if PFUser.currentUser()?["Avatar"] != nil {
                let file : PFFile = (PFUser.currentUser()?["Avatar"] as? PFFile)!
                
                file.getDataInBackgroundWithBlock { (data, error) -> Void in
                    if let downloadedImage = UIImage(data: data!) {
                        //downloadedImage.frame = CGRectMake(0,0,50,50)
                        loggeduserimage = downloadedImage
                        self.tableView.reloadData()
                    }
                    
                }
                
                // loggeduserimage = UIImage(named: "checkeduser.png")!
                print("Image is \(loggeduserimage)")
            } else {
                loggeduserimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
            }
            
            listsretrieval()
            
            retrievecustomcategories() // includes retrieval of custom items
            
            loadcontacts()
            
            loadevents()
            
            loadblacklist()
            
            tableView.reloadData()
            
        } else if (PFUser.currentUser() != nil) {//{
            /// if currentUser = nil
            
            loggedIn = false
            
            // login anonymous
            PFAnonymousUtils.logInWithBlock {
                (user: PFUser?, error: NSError?) -> Void in
                if error != nil || user == nil {
                    print("Anonymous login failed.")
                } else {
                    print("Anonymous user logged in.")
                }
            }
            
            
            loggedusername = NSLocalizedString("Anonymous", comment: "AnonymousUser")
            loggeduseremail = ""
            loggeduserimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
            
            
        }
        
        if !(PFAnonymousUtils.isLinkedWithUser(PFUser.currentUser())) {
            
            if CheckConnection.isConnectedToNetwork() {
                
                //dispatch_async(dispatch_get_main_queue(), {
                    self.checkreceivedlists()
                    self.checkreceivedevents()
                //})
            } else {
                print("No internet connection found")
            }
            
            
        }
        
        self.restore()
        self.tableView.reloadData()
    }
    
    
    
    ///// CATEGORIES STUFF
    
    func addcustomstocategories(customlist: [Category]) -> [Category] {
        
        //retrievecustomcategories()
        
        catalogcategories.appendContentsOf(customlist)
        
        return catalogcategories
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
                return ""
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    var imageToLoad = UIImage()
    
    
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

    
    
    func retrievecustomcategories() {
        //DO THE WHOLE STUFF IN PREVIOUS VC
        
        
        // customCatsIds.removeAll(keepCapacity: true)
        //MOST PROBABLY NEED JUST TO CLEAN THE ARRAY HERE
        var query = PFQuery(className:"shopListsCategory")
        query.fromLocalDatastore()
        query.whereKey("CatbelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isDeleted", equalTo: false) //TEMPORARILY SWITCHED THIS OFF!
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                    customcategories.removeAll(keepCapacity: true)
                    
                    if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        var customId = object["categoryUUID"] as! String
                        var customName = object["catname"] as! String
                        var customIs = object["isCustom"] as! Bool
                        var customImagePath = object["imagePath"] as! String
                        var customIsAllowed = object["ShouldShowInCatalog"] as! Bool //TEMPORARILY SWITCHED THIS OFF!
                        var customImage = UIImage()
                        //customImage
                        
                        //self.loadImageFromLocalStore(customImagePath)
                        
                        if object["defaultpicture"] as! Bool == true {
                            
                            var imagename = object["OriginalInDefaults"] as! String
                            
                            if (UIImage(named: "\(imagename)") != nil) {
                                customImage = UIImage(named: "\(imagename)")!
                            } else {
                                customImage = imagestochoose[0].itemimage
                            }
                            
                        } else {
                            
                            self.loadImageFromLocalStore(customImagePath)
                            customImage = self.imageToLoad
                            
                            /*
                            var imageFile = object["catimage"] as! PFFile
                            
                            var imageData = imageFile.getData()
                            if (imageData != nil) {
                                var image = UIImage(data: imageData!)
                                customImage = image!
                                
                            } else {
                                customImage = imagestochoose[0].itemimage
                            }
*/
                
                        }
                        
                        // var customImage = UIImage()

                        self.customcategory = Category(catId: customId, catname: customName, catimage: customImage, isCustom: customIs, isAllowed: customIsAllowed)
                        
                        print(self.customcategory)
                        
                        customcategories.append(self.customcategory!)
                        
                      
                        
                    }
                    
                   
                    
                    
                }
                

                print(customcategories)
                
                self.addcustomstocategories(customcategories)
                
                self.customitemsretrieval() // here it makes more sense than in didload, need all custom categories to be uploaded before retrieval of custom items
                
            } else {
                // Log details of the failure
                //self.restore()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    
    func addcustomstocatalogitems(customlist: [CatalogItem]) -> [CatalogItem] {
        
        //retrievecustomcategories()
        
        catalogitems.appendContentsOf(customlist)
        
        return catalogitems
    }
    /*
    var ItemimageToLoad = UIImage()
    
    func loadItemsImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        let path = dir.stringByAppendingPathComponent(imageName)
        
        if(!path.isEmpty){
            let image = UIImage(contentsOfFile: path)
            print(image);
            if(image != nil){
                //return image!;
                self.ItemimageToLoad = image!
                return ItemimageToLoad
            }
        }
        
        return UIImage(named: "FavStar.png")!
    }
    */

    
    var customcatalogitem : CatalogItem?
    /////
    func customitemsretrieval() {
        
        var query = PFQuery(className:"shopListCatalogItems")
        query.fromLocalDatastore()
        query.whereKey("itemsbelongstouser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isDeleted", equalTo: false) 
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                customcatalogitems.removeAll(keepCapacity: true)
                
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
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
                            self.loadImageFromLocalStore(customitemImagePath)
                            customImage = self.imageToLoad
                           
                        }
                        
                        
                         if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(customitemCategoryId) {
                           customitemcategory = catalogcategories[foundcategory]
                        } else {
                            
                            customitemcategory = catalogcategories[0]
                            
                        }
                        
                                               // var customImage = UIImage()
                        
                        self.customcatalogitem = CatalogItem(itemId: customitemId, itemname: customitemName, itemimage: customImage, itemcategory: customitemcategory!, itemischecked:false, itemaddedid: "")

                        
                        customcatalogitems.append(self.customcatalogitem!)

                        
                    }
                    
                    
                }
                
                self.addcustomstocatalogitems(customcatalogitems)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    //dimmerView.backgroundColor = UIColorFromRGB(0x1695A3)
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
           // alpha: CGFloat(0.3)
        )
    }
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }
    
    func UIColorFromRGBdark(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.85)
            // alpha: CGFloat(0.3)
        )
    }
    
    
    func containseventid(values: [String], element: String) -> Bool {
        
        for value in values {
            
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    

    
    ////// LOAD USER EVENTSx
    func loadevents() {
    
        var query1 = PFQuery(className:"UsersEvents")
        query1.whereKey("SenderId", equalTo: PFUser.currentUser()!.objectId!)
    
    
        var query2 = PFQuery(className:"UsersEvents")
        query2.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
        
        
        let query = PFQuery.orQueryWithSubqueries([query1, query2])

        query.fromLocalDatastore()

        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
               // userevents.removeAll(keepCapacity: true)
                print("Successfully events retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        var etype = object["EventType"] as! String
                        
                        if etype == "GoShop" {
                            // DONT USE THIS ANYMORE
                            /*
                        var enote = object["EventText"] as! String
                        var edate = object.createdAt//object["createdAt"] as! NSDate
                        var euser = object["senderInfo"] as! [AnyObject]
                        var erecuser = object["receiverInfo"] as! [AnyObject]
                        var eid = object["eventUUID"] as! String
                        
                          if !self.containseventid(userevents.map({ $0.eventid! }), element: eid) {
                        
                        userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid))
                          } else {
                            print("Such event is already loaded")
                       }
                        */
                            
                    } else if etype == "AddContact" {
                            
                            var enote = object["EventText"] as! String
                            var edate = object.createdAt//object["createdAt"] as! NSDate
                            var euser = object["senderInfo"] as! [AnyObject]
                            var erecuser = object["receiverInfo"] as! [AnyObject]
                          
                            var eid = object["eventUUID"] as! String
                            
                            var senderavatarfile = object["senderavatar"] as? PFFile
                            
                            var senderimage = UIImage()
                            
                            if senderavatarfile != nil {
                                var imageData = senderavatarfile!.getData()
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    senderimage = image!
                                } else {
                                    senderimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                                }
                            } else {
                                senderimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                            }
                            
                            
                            if !self.containseventid(userevents.map({ $0.eventid! }), element: eid) {
                                
                                userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid, eventreceiverimage: senderimage))
                            } else {
                                print("Such event is already loaded")
                            }
                           
                    }
                    
                    }
                    
                    userevents.sortInPlace({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
                    print("USER EVENTS \(userevents)")
                    
                }
                
                //self.addcustomstocatalogitems(customcatalogitems)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        //
        //UserLists.sort({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
       
        
    }
    ////// LOAD USER CONTACTS
    
    func checkreceivedevents() {
                var query = PFQuery(className:"UsersEvents")

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
                        
                        var etype = object["EventType"] as! String
                        
                        if etype == "GoShop" {
                        
                        var enote = object["EventText"] as! String
                        var edate = object.createdAt //["createdAt"] as! NSDate
                        var euser = object["senderInfo"] as! [AnyObject]
                        var erecuser = object["receiverInfo"] as! [AnyObject]
                        var eid = object["eventUUID"] as! String
                            
                            
                            
                            if !self.containseventid(blacklistarray, element: euser[0] as! String) {
                        
                             if !self.containseventid(userevents.map({ $0.eventid! }), element: eid) {
                            
                        userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid))
                        //  userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid, eventreceiverimage: senderimage))
                            
                        
                        object["isReceived"] = true
                        
                        receivedeventscount += 1
                                
                                
                        object.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                //self.restore()
                                print("saved item")
                                object["isReceived"] = true
                                object.saveEventually()
                                
                            } else {
                                print("no id found")
                            }
                        })
                                
                             } else {
                                print("Such event is already loaded")
                            }
                            } else {
                                print("This sender id is blocked")
                            }
                        
                        } else if etype == "AddContact" {
                            
                            var enote = object["EventText"] as! String
                            var edate = object.createdAt//object["createdAt"] as! NSDate
                            var euser = object["senderInfo"] as! [AnyObject]
                            var erecuser = object["receiverInfo"] as! [AnyObject]
                            
                            var eid = object["eventUUID"] as! String
                            
                            var senderavatarfile = object["senderavatar"] as? PFFile
                            
                            var senderimage = UIImage()
                            
                            if senderavatarfile != nil {
                                var imageData = senderavatarfile!.getData()
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    senderimage = image!
                                } else {
                                    senderimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                                }
                            } else {
                                senderimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                            }
                            
                            
                              if !self.containseventid(blacklistarray, element: euser[0] as! String) {
                            
                            if !self.containseventid(userevents.map({ $0.eventid! }), element: eid) {
                                
                                userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid, eventreceiverimage: senderimage))
                                
                                object["isReceived"] = true
                                
                                receivedeventscount += 1
                                
                                
                                object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                    if success {
                                        //self.restore()
                                        print("saved item")
                                        object["isReceived"] = true
                                        object.saveEventually()
                                        
                                    } else {
                                        print("no id found")
                                    }
                                })

                                
                                
                            } else {
                                print("Such event is already loaded")
                            }
                                
                              } else {
                                print("This sender id is blocked!")
                            }
                            
                        }
                        
                    }
                     userevents.sortInPlace({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        print(receivedeventscount)
                        
                        self.tableView.reloadData()
                    }
                    

                    
                }
                
                //self.addcustomstocatalogitems(customcatalogitems)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    // var contactsarray = [[AnyObject]]()
    
    func loadcontacts() {
    
    
            var contactquery:PFQuery = PFUser.query()!
            contactquery.fromLocalDatastore()
            contactquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
            contactquery.findObjectsInBackgroundWithBlock {
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
                                            avatar = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                                        }
                                    } else {
                                        avatar = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                                    }
                                    
                                    usercontacts.append(Contact(contactid:element[3] as! String,contactimage: avatar, contactname: element[0] as! String, contactemail: element[1] as! String))
                                    
                                   
                               
                                    
                                    
                                    
                                }
                                
                                print("USER CONTACTS \(usercontacts)")
                              //  print("USER CONTACT1 \(usercontacts[0].contactemail)")
                                
                            } else {
                                print("no contacts so far")
                            }

                        }
                    
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
                } else {
                    print("Error: \(error!) \(error!.userInfo)")
                }
            
            //self.tableView.reloadData()
        }
        

        
    }
    
    
    func loadblacklist() {
        let querycontacts:PFQuery = PFUser.query()!
        querycontacts.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        querycontacts.fromLocalDatastore()
        querycontacts.limit = 1
        let thisusercontacts = querycontacts.findObjects()
        if (thisusercontacts != nil) {
            for thisusercontact in thisusercontacts! {
                
                if let blacklist = thisusercontact["blacklist"] as? [AnyObject] { //used to be username
                    
                    print(thisusercontact["blacklist"])
                    
                    blacklistarray.appendContentsOf(thisusercontact["blacklist"] as! [String])
                    
                }
                
                
            }
        } else {
            print("Error")
        }
    }
    
    
    func displayReceivedAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "ListSentSuccess")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(closeCallback)
    }
    
    func displayReceivedEventAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "EventAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(closeCallback)
    }

    
    func closeCallback() {
        tableView.reloadData()
    }
    
    func reloadTableAfterPush() {
        
       // displayReceivedAlert("", message: mesalert)
        checkreceivedlists()
        
        checkreceivedevents()
        
        tableView.reloadData()
        
        
    }
    /*
    func reloadTableAfterPush2() {
        
        //displayReceivedEventAlert("", message: mesalert)
        tableView.reloadData()
        
        
    }
    */
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
        return 0
        } else {
            return 4
        }
    }
    
    
    func displayWalkthroughs()
    {
        // Create the walkthrough screens
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
        if !displayedWalkthrough {
            

            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
                

                
                self.presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
          //displayWalkthroughs()
        
    }
    
    func resizemenu() {
        
        
        
    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableAfterPush", name: "reloadTableMenu", object: nil)
        


        for var i = 0;i<catalogitems.count;++i {
            
            catalogitems[i].itemischecked = false
            
        }
        
       // toDoItems.removeAll(keepCapacity: true)
        
            //    receivedcount = 0
        //receivedeventscount = 0
        
        
        
        //tableView.separatorStyle = .None
              bgImageView.image = UIImage(named: "4GradBg")//"DarkBg")
        self.view.sendSubviewToBack(bgImageView)

        
    
    }

       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
