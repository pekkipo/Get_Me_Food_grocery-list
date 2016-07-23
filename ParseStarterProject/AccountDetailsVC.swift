//
//  AccountDetailsVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 20/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Parse

class AccountDetailsVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var maindelegate : refreshmainviewDelegate?
    
    var senderVC = String()
    
    @IBOutlet var backbutton: UIBarButtonItem!
    
    @IBAction func backaction(sender: AnyObject) {
        
        if senderVC == "MainMenu" {
            performSegueWithIdentifier("backtomainfromaccount", sender: self)
        } else if senderVC == "SettingsVC" {
            performSegueWithIdentifier("backtosettingsfromaccount", sender: self)
        } else {
            performSegueWithIdentifier("backtomainfromaccount", sender: self)
        }
        
        
    }
    
    
    @IBOutlet var toolbar: UIToolbar!
    
    
    @IBOutlet var userimage: UIImageView!
    
    
    @IBOutlet var userdisplayname: CustomTextField!//UITextField!
    
    
    @IBOutlet var useremaillogin: CustomTextField!//UITextField!
    
    
   
    
    
    
    let progressHUDdelete = ProgressHUD(text: NSLocalizedString("deleting", comment: ""))
    let progressHUDsave = ProgressHUD(text: NSLocalizedString("saving", comment: ""))

    
    func pausesave() {
        
        
        self.view.addSubview(progressHUDsave)
        
        progressHUDsave.setup()
        progressHUDsave.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    func restoresave() {
        
        progressHUDsave.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func pausedelete() {
        
        
        self.view.addSubview(progressHUDdelete)
        
        progressHUDdelete.setup()
        progressHUDdelete.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    func restoredelete() {
        
        progressHUDdelete.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }

    
    
    @IBAction func changepassword(sender: AnyObject) {
        
        if PFUser.currentUser()?.email != nil {
        PFUser.requestPasswordResetForEmailInBackground(PFUser.currentUser()!.email!)
            
            self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("checkemail", comment: ""))
        } else {
            print("Can't do that")
            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
        }
        
    }
    
    
    
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        PFFacebookUtils.facebookLoginManager().logOut() // not sure, but it must work
        
        GIDSignIn.sharedInstance().signOut()
        
        
        
        /// un assign device for pushes
        
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
        
        performSegueWithIdentifier("backtostartview", sender: self)
        
    }
    
    func displayInfoAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", cancelButtonText: "\(NSLocalizedString("cancelbutton", comment: ""))", color: UIColorFromHex(0x2A2F36, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addAction(closeCallbackDelete)
        alertview.addCancelAction(cancelCallbackDelete)
    }
    
    func closeCallbackDelete() {
        
        print("OK")
        deleteaccountinformation()
        
    }
    
    func cancelCallbackDelete() {
        
        print("canceled")
        
    }
    
    
    
    func deleteaccountinformation() {
        
        pausedelete()
        
        let deleteuserid = PFUser.currentUser()!.objectId!
        
        UserLists.removeAll(keepCapacity: true)
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
        UserFavLists.removeAll(keepCapacity: true)
        // itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
        
        customcategories.removeAll(keepCapacity: true)
        customcatalogitems.removeAll(keepCapacity: true)
        userevents.removeAll(keepCapacity: true)
        usercontacts.removeAll(keepCapacity: true)
        
        let queryshoplists = PFQuery(className:"shopLists")
        queryshoplists.whereKey("BelongsToUser", equalTo: deleteuserid)
        queryshoplists.fromLocalDatastore()
        queryshoplists.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    for object in objects {
                        object.unpinInBackground()
                        object.deleteInBackground()
                
            }
            // shop items
            let queryshopitems = PFQuery(className:"shopItems")
            queryshopitems.whereKey("belongsToUser", equalTo: deleteuserid)
            queryshopitems.fromLocalDatastore()
            queryshopitems.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {

                    if let objects = objects {
                        for object in objects {
                            object.unpinInBackground()
                            object.deleteInBackground()
                        }
                        
                        // CUSTOM CATALOG ITEMS
                        let queryshopcatalog = PFQuery(className:"shopListCatalogItems")
                        queryshopcatalog.whereKey("itemsbelongstouser", equalTo: deleteuserid)
                        queryshopcatalog.fromLocalDatastore()
                        queryshopcatalog.findObjectsInBackgroundWithBlock {
                            (objects: [AnyObject]?, error: NSError?) -> Void in
                            
                            if error == nil {
                                
                                if let objects = objects {
                                    for object in objects {
                                        object.unpinInBackground()
                                        object.deleteInBackground()
                                    }
                                    
                                    // CUSTOM CATEGORIES
                                    let queryshopcats = PFQuery(className:"shopListsCategory")
                                    queryshopcats.whereKey("CatbelongsToUser", equalTo: deleteuserid)
                                    queryshopcats.fromLocalDatastore()
                                    queryshopcats.findObjectsInBackgroundWithBlock {
                                        (objects: [AnyObject]?, error: NSError?) -> Void in
                                        
                                        if error == nil {
                                            
                                            if let objects = objects {
                                                for object in objects {
                                                    object.unpinInBackground()
                                                    object.deleteInBackground()
                                                }
                                                // TO DO Items
                                                let querytodoitems = PFQuery(className:"toDoItems")
                                                querytodoitems.whereKey("BelongsToUser", equalTo: deleteuserid)
                                                querytodoitems.fromLocalDatastore()
                                                querytodoitems.findObjectsInBackgroundWithBlock {
                                                    (objects: [AnyObject]?, error: NSError?) -> Void in
                                                    
                                                    if error == nil {
                                                        
                                                        if let objects = objects {
                                                            for object in objects {
                                                                object.unpinInBackground()
                                                                object.deleteInBackground()
                                                            }
                                                            //TO DO Lists
                                                            let querytodolists = PFQuery(className:"toDoLists")
                                                            querytodolists.whereKey("BelongsToUser", equalTo: deleteuserid)

                                                             querytodolists.fromLocalDatastore()
                                                             querytodolists.findObjectsInBackgroundWithBlock {
                                                                (objects: [AnyObject]?, error: NSError?) -> Void in
                                                                
                                                                if error == nil {
                                                                    
                                                                    if let objects = objects {
                                                                        for object in objects {
                                                                            object.unpinInBackground()
                                                                            object.deleteInBackground()
                                                                        }
                                                                        
                                                                        // DELETE THE USER
                                                                        let queryuser:PFQuery = PFUser.query()!
                                                                        queryuser.fromLocalDatastore()
                                                                            queryuser.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
                                                                                (thisuser: PFObject?, error: NSError?) -> Void in
                                                                                if error != nil {
                                                                                    self.restoredelete()
                                                                                    print(error)
                                                                                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                                                                                } else if let thisuser = thisuser {
                                                                                    
                                                                                    
                                                                                    
                                                                                    thisuser.unpinInBackground()
                                                                                    thisuser.deleteInBackground()
                                                                                    self.restoredelete()
                                                                                    
                                                                                    
                                                                            PFUser.logOut()
                                                                                    self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("accountremoved", comment: ""))
                                                                                    
                                                                                    
                                                                                    loggedIn = false
                                                                                    self.maindelegate?.loaduserdata()
                                                                                    self.maindelegate?.refreshmainview()
                                                                                    
                                                                                    self.performSegueWithIdentifier("backtomainfromaccount", sender: self)
                                                                                    
                                                                  
                                                                                }
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                } else {
                                                                    // Log details of the failure
                                                                     self.restoredelete()
                                                                    print("Error: \(error!) \(error!.userInfo)")
                                                                }
                                                            }
                                                            
                                                            
                                                        }
                                                    } else {
                                                        // Log details of the failure
                                                         self.restoredelete()
                                                        print("Error: \(error!) \(error!.userInfo)")
                                                    }
                                                }
                                                
                                                
                                            }
                                        } else {
                                            // Log details of the failure
                                             self.restoredelete()
                                            print("Error: \(error!) \(error!.userInfo)")
                                        }
                                    }
                                    
                                    
                                }
                            } else {
                                // Log details of the failure
                                 self.restoredelete()
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                        }

                        
                        
                    }
                } else {
                    // Log details of the failure
                     self.restoredelete()
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }

                }
               
            }
            else {
                self.restoredelete()
                print("Error")
        }
        }

        
        /*
        // SHOP LISTS
        var queryshoplists = PFQuery(className:"shopLists")
        queryshoplists.whereKey("BelongsToUser", equalTo: deleteuserid)
        queryshoplists.fromLocalDatastore()
        var lists = queryshoplists.findObjects()
        if (lists != nil) {
            for list in lists! {
            
                list.unpin()
                list.deleteInBackground()
                
            }
        } else {
             self.restoredelete()
            println("No username yet")
        }
        
        
        // SHOP ITEMS
        var queryshopitems = PFQuery(className:"shopItems")
        queryshopitems.whereKey("belongsToUser", equalTo: deleteuserid)
        queryshopitems.fromLocalDatastore()
        var shopitems = queryshopitems.findObjects()
        if (shopitems != nil) {
            for shopitem in shopitems! {
                
                shopitem.unpin()
                shopitem.delete()
                
            }
        } else {
             self.restoredelete()
            println("No username yet")
        }
        
        
        // CUSTOM CATALOG ITEMS
        var queryshopcatalog = PFQuery(className:"shopListCatalogItems")
        queryshopcatalog.whereKey("itemsbelongstouser", equalTo: deleteuserid)
        queryshopcatalog.fromLocalDatastore()
        var catitems = queryshopcatalog.findObjects()
        if (catitems != nil) {
            for catitem in catitems! {
                
                catitem.unpin()
                catitem.delete()
                
            }
        } else {
             self.restoredelete()
            println("No username yet")
        }
        
        
        // CUSTOM CATEGORIES
        var queryshopcats = PFQuery(className:"shopListsCategory")
        queryshopcats.whereKey("CatbelongsToUser", equalTo: deleteuserid)
        queryshopcats.fromLocalDatastore()
        var cats = queryshopcats.findObjects()
        if (cats != nil) {
            for cat in cats! {
                
                cat.unpin()
                cat.delete()
                
            }
        } else {
             self.restoredelete()
            println("No username yet")
        }
        
        // TO DO Items
        var querytodoitems = PFQuery(className:"toDoItems")
        querytodoitems.whereKey("BelongsToUser", equalTo: deleteuserid)
        querytodoitems.fromLocalDatastore()
        var todoitems = querytodoitems.findObjects()
        if (todoitems != nil) {
            for todoitem in todoitems! {
                
               todoitem.unpin()
               todoitem.delete()
                
            }
        } else {
             self.restoredelete()
            println("No username yet")
        }
        
        
        // TO DO Lists
        var querytodolists = PFQuery(className:"toDoLists")
        querytodolists.whereKey("BelongsToUser", equalTo: deleteuserid)
        querytodolists.fromLocalDatastore()
        var todolists = querytodolists.findObjects()
        if (todolists != nil) {
            for todolist in todolists! {
                
                todolist.unpin()
                todolist.delete()
                
            }
        } else {
             self.restoredelete()
            println("No username yet")
        }
        
        
        /// I LEAVE EVENTS UNTOUCHED
        
        
        // Finally remove the user
        var queryuser:PFQuery = PFUser.query()!
        queryuser.
        queryuser.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                self.restoredelete()
                println(error)
                 self.displayFailAlert("Oops!", message: "Something went wrong, please try again later. \(error)")
            } else if let thisuser = thisuser {
                
                PFUser.logOut()
                
                thisuser.unpin()
                thisuser.delete()
                self.restoredelete()
                self.displaySuccessAlert("Done", message: "The account has been completely removed.")
                
                
                loggedIn = false
                self.maindelegate?.loaduserdata()
                self.maindelegate?.refreshmainview()
                
                self.performSegueWithIdentifier("backtomainfromaccount", sender: self)
                
                /* thisuser.deleteInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                self.restoredelete()
                self.displaySuccessAlert("Done", message: "The account has been completely removed.")
                } else {
                self.restoredelete()
                
                self.displayFailAlert("Oops!", message: "Something went wrong, please try again later. \(error)")
                }
                }
                */
            }
        }
        */
        self.restoredelete()
    }

    
    /*
    func deleteaccountinformation() {
        
        self.pausedelete()
        
        var deleteuserid = PFUser.currentUser()!.objectId!
        
        UserLists.removeAll(keepCapacity: true)
        UserShopLists.removeAll(keepCapacity: true)
        UserToDoLists.removeAll(keepCapacity: true)
        UserFavLists.removeAll(keepCapacity: true)
        // itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
        
        customcategories.removeAll(keepCapacity: true)
        customcatalogitems.removeAll(keepCapacity: true)
        userevents.removeAll(keepCapacity: true)
        usercontacts.removeAll(keepCapacity: true)
        
        // SHOP LISTS
        var queryshoplists = PFQuery(className:"shopLists")
        queryshoplists.whereKey("BelongsToUser", equalTo: deleteuserid)
        queryshoplists.fromLocalDatastore()
        queryshoplists.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        object.deleteInBackgroundWithBlock({ (success, error) -> Void in
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
                self.restoredelete()
                 self.displayFailAlert("Oops!", message: "Error: \(error!) \(error!.userInfo!)")
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        // SHOP ITEMS
        var queryshopitems = PFQuery(className:"shopItems")
        queryshopitems.whereKey("belongsToUser", equalTo: deleteuserid)
        queryshopitems.fromLocalDatastore()
        queryshopitems.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        object.deleteInBackgroundWithBlock({ (success, error) -> Void in
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
                self.restoredelete()
                self.displayFailAlert("Oops!", message: "Error: \(error!) \(error!.userInfo!)")
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        // CUSTOM CATALOG ITEMS
        var queryshopcatalog = PFQuery(className:"shopListCatalogItems")
        queryshopcatalog.whereKey("itemsbelongstouser", equalTo: deleteuserid)
        queryshopcatalog.fromLocalDatastore()
        queryshopcatalog.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        object.deleteInBackgroundWithBlock({ (success, error) -> Void in
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
                self.restoredelete()
                self.displayFailAlert("Oops!", message: "Error: \(error!) \(error!.userInfo!)")
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        // CUSTOM CATEGORIES
        var queryshopcats = PFQuery(className:"shopListsCategory")
        queryshopcats.whereKey("CatbelongsToUser", equalTo: deleteuserid)
        queryshopcats.fromLocalDatastore()
        queryshopcats.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        object.deleteInBackgroundWithBlock({ (success, error) -> Void in
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
                self.restoredelete()
                self.displayFailAlert("Oops!", message: "Error: \(error!) \(error!.userInfo!)")
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        // TO DO Items
        var querytodoitems = PFQuery(className:"toDoItems")
        querytodoitems.whereKey("BelongsToUser", equalTo: deleteuserid)
        querytodoitems.fromLocalDatastore()
        querytodoitems.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        object.deleteInBackgroundWithBlock({ (success, error) -> Void in
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
                self.restoredelete()
                self.displayFailAlert("Oops!", message: "Error: \(error!) \(error!.userInfo!)")
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }

        
        // TO DO Lists
        var querytodolists = PFQuery(className:"toDoLists")
        querytodolists.whereKey("BelongsToUser", equalTo: deleteuserid)
        querytodolists.fromLocalDatastore()
        querytodolists.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                
                if let lists = objects as? [PFObject] {
                    
                    
                    for object in lists {
                        
                        
                        object.unpinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                
                                println("List saved")
                                
                            } else {
                                println("no list found")
                            }
                        })
                        
                        object.deleteInBackgroundWithBlock({ (success, error) -> Void in
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
                self.restoredelete()
                self.displayFailAlert("Oops!", message: "Error: \(error!) \(error!.userInfo!)")
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        /// I LEAVE EVENTS UNTOUCHED

        
        // Finally remove the user
        var queryuser:PFQuery = PFUser.query()!
        queryuser.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                 self.restoredelete()
                println(error)
            } else if let thisuser = thisuser {
                
                thisuser.deleteEventually()
                thisuser.unpin()
                
               /* thisuser.deleteInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                         self.restoredelete()
                        self.displaySuccessAlert("Done", message: "The account has been completely removed.")
                    } else {
                        self.restoredelete()
                        
                        self.displayFailAlert("Oops!", message: "Something went wrong, please try again later. \(error)")
                    }
                }
                */
            }
        }
        
    }
    */
    
    @IBAction func deleteaccount(sender: AnyObject) {
        
        if CheckConnection.isConnectedToNetwork() {
        
      //  deleteaccountinformation()
            
            self.displayInfoAlert(NSLocalizedString("wantdelete1", comment: ""), message: NSLocalizedString("wantdelete2", comment: ""))
            
        } else {
             self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("NoConnection", comment: ""))
        }
        
        
    }
    
    @IBAction func changedisplayname(sender: AnyObject) {
    }
    
    
    @IBAction func changeemail(sender: AnyObject) {
    }
    
    var ischangeimage = false//Bool()
    
    @IBAction func changeavatar(sender: AnyObject) {
        
        
        let chosenimage = UIImagePickerController()
        chosenimage.delegate = self//self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = false
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        

        self.userimage.image = chosenimage
        
        ischangeimage = true
        
        
    }

    
 
    
    
 
    
    func displayFailAlert(title: String, message: String) {
        
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }
    
    func displaySuccessAlert(title: String, message: String) {
        
        
        let customIcon = UIImage(named: "SuccessAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }
    
    func closeCallback() {
        
        print("OK")
        
    }
    
    func cancelCallback() {
        
        print("canceled")
        
    }

    var emailexists = Bool()
    func checkexistance(typedemail: String) -> Bool {
        let query1:PFQuery = PFUser.query()!
        query1.whereKey("email", equalTo:typedemail)
        // self.checkemail = //query1.findObjects()!
        // var checkemailone : PFObject = query1.getFirstObject()
        let checkemailone = query1.getFirstObject()
        //if query1.isEqual(nil) {
        if checkemailone == nil {
            emailexists = false
        } else {
            emailexists = true
        }
        // query1.getFirstObject()
        
        
        return emailexists
        
    }
    
    
    @IBAction func savechanges(sender: AnyObject) {
        
        self.pausesave()
        
        var query:PFQuery = PFUser.query()!
        query.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
       // query.limit = 1
        query.getFirstObjectInBackgroundWithBlock() {
            
            (user: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                self.restoresave()
                self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
            } else if let user = user {
                
                if self.useremaillogin.text!.isEmpty != true || !((self.useremaillogin.text! as NSString).containsString("@")) {
                    
                    
                    if  self.useremaillogin.text != user["email"] as? String {
                       // if !self.emailexists {
                      //  user["username"] = self.useremaillogin.text
                      //  user["email"] = self.useremaillogin.text // Warning!
                        } else {
                       //     self.displayFailAlert("Oops!", message: "The email is already exists in our database")
                       // }
                        // PARSE CHECKS IT ITSELF!
                    }
                    
                //user["username"] = self.useremaillogin.text
                //user["email"] = self.useremaillogin.text
                } else {
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("wrongemail", comment: ""))

                }
                
                if self.userdisplayname.text!.isEmpty != true {
                user["name"] = self.userdisplayname.text
                } else {
                self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("typename", comment: ""))

                }
                if self.ischangeimage {
                var file = PFFile(data: UIImageJPEGRepresentation(self.userimage.image!, 0.7)!)
                user["Avatar"] = file
                }
                
                user.pinInBackground()
                self.restoresave()
                user.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        
                         self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("persdata", comment: ""))
                        
                        self.maindelegate?.loaduserdata()
                        
                        self.maindelegate?.refreshmainview()
                        
                        self.restoresave()
                        
                        
                        
                    } else {
                        self.restoresave()
                       // self.displayFailAlert("Error!", message: "Error occured: \(error)")
                        self.displayFailAlert(NSLocalizedString("errorExc", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        print("error")
                    }
                    
                })
                
            }
        }
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    
    /// Text field stuff
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        return
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //myTextField.delegate = self
    ///
    
    
    
    
    @IBOutlet var topspacing: NSLayoutConstraint!
    
    
    @IBOutlet var changepictoutlet: UIButton!
    
    @IBOutlet var smalltopview: UIView!
    
    
    @IBOutlet var saveoutlet: UIButton!
    
    
    @IBOutlet var logoutoutlet: UIButton!
    
    
    @IBOutlet var deleteoutlet: UIButton!
    
    
    
    @IBOutlet var OpenMenu: UIBarButtonItem!
    
    
    @IBOutlet var pictureview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OpenMenu.target = self.revealViewController()
        OpenMenu.action = Selector("revealToggle:")
        
        if let revealController = self.revealViewController() {
      
            revealController.tapGestureRecognizer()
        }

        
        
        userdisplayname.delegate = self
        
        useremaillogin.delegate = self
        


        
        userdisplayname.leftTextMargin = 13
        useremaillogin.leftTextMargin = 13
       

        
        self.userdisplayname.text = loggedusername
        self.useremaillogin.text = loggeduseremail
        self.userimage.image = loggeduserimage
        
        pictureview.layer.borderWidth = 1
        pictureview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        userdisplayname.layer.borderWidth = 1
        userdisplayname.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor

        
        useremaillogin.layer.borderWidth = 1
        useremaillogin.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor

        
        self.userimage.layer.cornerRadius = self.userimage.frame.size.width / 2
        self.userimage.layer.masksToBounds = true
        self.userimage.layer.borderWidth = 1
        self.userimage.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor
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

}
