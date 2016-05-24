//
//  EventsVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 07/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Parse
import Foundation

class EventsVC: UIViewController, ContactsPopupDelegate, UIPopoverPresentationControllerDelegate,MPGEventsTextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var chosencontact : Contact?
    
    var fromcontacts = Bool()
    
    var delegate : refreshmainviewDelegate?
    
    
    @IBOutlet var messagecontainer: UIView!
    
    
    ////// AUTOCOMPLETE PART START
    
    ////AUTOCOMPLETE PART
    var sampleData = [Dictionary<String, AnyObject>]()
    var contentsemails = [String]()
    var contentsnames = [String]()
    var dictionary = Dictionary<String, AnyObject>()
    
    func generateData(tempprefix: String){
        /*
        var err : NSErrorPointer?
        var dataPath = NSBundle.mainBundle().pathForResource("sample_data", ofType: "json")
        var data = NSData.dataWithContentsOfFile(dataPath!, options: NSDataReadingOptions.DataReadingUncached, error: err!)
        */
        
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
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        for var i = 0;i<contentsnames.count;++i {
            var name = contentsnames[i] as String//["username"] as! String
            //name += " " + lName
            var email = contentsemails[i] as String
            dictionary = ["DisplayText":email,"DisplaySubText":name, "CustomObject":contentsnames[i]]
            
            sampleData.append(dictionary)
            
        }
        print("Users are \(sampleData)")
        print("names are \(dictionary)")
        print("names in contents are \(contentsnames)")
        
    }
    
    
    func dataForPopoverInTextField(textfield: MPG_Events) -> [Dictionary<String, AnyObject>]
    {
        return sampleData
    }
    
    func textFieldShouldSelect(textField: MPG_Events) -> Bool{
        return true
    }
    
    func textFieldDidEndEditing(textField: MPG_Events, withSelection data: Dictionary<String,AnyObject>){
        print("Dictionary received = \(data)")
    }
    
    
    @IBAction func emailedtitingchanged(sender: AnyObject) {
        
        var string : String = receiveremail.text!
        
        print(string)
        
        var length = string.characters.count
        
        print(length)
        
        //if length >= 6 {
        if length == 4 || length == 6 {
            
        
           // sampleData.removeAll(keepCapacity: true) // might need it
            
            print(length)
            print(string)
            // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.generateData(string)
              //  })
           // print(sampleData)
            
        }
        
       // print(sampleData)
    }
    

    
    ///// AUTOCOMPLETE PART END
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("wait", comment: ""))
    
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
    
    
    func displayContactAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "AddContactAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        //alertview.addAction(closeCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    func displaySuccessAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "SuccessAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        //alertview.addAction(closeCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    
    
    func cancelCallback() {
        print("CANCELED")
    }
    
    func closeCallback() {
        
        //self.tableView.reloadData()
        
        print("JUST CLOSED")
        
    }


    
    
    func addusertocontacts(sender: AnyObject) {
        
        pause()
        
        let button = sender as! UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ContactEventCell
        
        let indexPath = tableView.indexPathForCell(cell)
        
        
        /*
        let recname : String = userevents[indexPath.row].eventuser[2] as! String
        let recemail: String = userevents[indexPath.row].eventuser[1] as! String
        cell.nameandevent.text = recname
        cell.receiveremail.text = recemail
        cell.receiverimage.image = userevents[indexPath.row].eventreceiverimage!
        */
        
        var query:PFQuery = PFUser.query()!
        query.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let thisuser = thisuser {
                
                var useravatar : UIImage = userevents[indexPath!.row].eventreceiverimage!
                let newuserid: String = userevents[indexPath!.row].eventuser[0] as! String
                let recname : String = userevents[indexPath!.row].eventuser[2] as! String
                let recemail: String = userevents[indexPath!.row].eventuser[1] as! String
                
                usercontacts.append(Contact(contactid: newuserid, contactimage: useravatar, contactname: recname, contactemail: recemail))
                
                let imageData = UIImagePNGRepresentation(useravatar)
                let imageFile = PFFile(name:"avatar.png", data:imageData!)
                
                
                contactsarray.append([recname,recemail,imageFile,newuserid]) //NO ID?!
                
                thisuser["UserContacts"] = contactsarray
                
                thisuser.pinInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        //self.restore()
                       // self.restore()
                       
                       
                        
                    } else {
                        self.restore()
                        print("error")
                    }
                })//pinInBackground()
                thisuser.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        
                        
                        //self.restore()
                        
                        print("saved user to server")
                        self.displayContactAlert(NSLocalizedString("useradded", comment: ""), message: NSLocalizedString("thisperson", comment: ""))
                        self.restore()
                        //self.tableView.reloadData()
                        // self.displayAlert("User added!", message: "Everything went fine!")
                    } else {
                        self.restore()
                        self.displayFailAlert(NSLocalizedString("errorExc", comment: ""), message: "\(NSLocalizedString("error2", comment: "")) \(error)")
                        print("error")
                        
                    }
                    
                    self.tableView.reloadData()
                })
                /*thisuser.saveEventually({ (success, error) -> Void in
                if success {
                println("saved user to server")
                } else {
                println("error server")
                }
                })//saveEventually()
                */
                //self.tableView.reloadData()
            }
        }
        
        
        
    }
    
    
    
    @IBOutlet var receiveremail: MPG_Events!
    
    
    
    @IBAction func sendbutton(sender: AnyObject) {
        
        if CheckConnection.isConnectedToNetwork() {
        
        self.pause()
        var exist = Bool()
        var receiverid = String()
        var receivername = String()
        /// get user info
        var contactimagequery:PFQuery = PFUser.query()!
        contactimagequery.whereKey("email", equalTo: receiveremail.text!)
        contactimagequery.limit = 1
        var users = contactimagequery.findObjects()
        if (users != nil) {
            
            for user in users! {
                //if let userid = user. { //objectId! { //{user["objectId"] as? String {
                    receiverid = user.objectId!! //["objectId"] as! String
                
                if receiverid != "" {
                    exist = true
                } else {
                    exist = false
                    
                }
                
               // }//used to be username
                if let uname = user["name"] as? String {
                    receivername = user["name"] as! String
                } else {
                    receivername = "Unknown"
                }
                //}
 
            }
        } else {
            exist = false
             self.restore()
            displayFailAlert(NSLocalizedString("Oops", comment: "Oops"), message: NSLocalizedString("nouser", comment: ""))
            
            print("No such user!")
        }

        /*
        ///
        var currentuseremail = String()
        // get currentuser email
            var emailquery:PFQuery = PFUser.query()!
            emailquery.fromLocalDatastore()
            emailquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
            emailquery.limit = 1
            var curusers = emailquery.findObjects()
            if (curusers != nil) {
                for user in curusers! {
                     if let mail = user["email"] as? String {
                        currentuseremail = user["email"] as! String //used to be username
                     } else {
                        currentuseremail = "Anonymous"
                    }
                    
                }
            } else {
                println("No such user?!")
            }
            ///// 
            */
            
            if exist == true {
            
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
                currentusername = NSLocalizedString("Anonymous", comment: "")
            }

            
            
        var event = PFObject(className:"UsersEvents")
        
            
        var uuid = NSUUID().UUIDString
            
        event["EventText"] = ""
        event["EventType"] = "GoShop"
        event["SenderId"] = PFUser.currentUser()!.objectId!
        event["receiverEmail"] = receiveremail.text
        event["ReceiverId"] = receiverid
        event["isReceived"] = false
        event["senderInfo"] = [(PFUser.currentUser()!.objectId!),currentuseremail,currentusername]
        event["receiverInfo"] = [receiverid, receiveremail.text!, receivername]
        event["eventUUID"] = uuid
            
            /*
            let file : PFFile = (PFUser.currentUser()?["Avatar"] as? PFFile)!
            
            event["senderavatar"] = file
            
           
            
            var senderimage = UIImage()
            
          
                var imageData = file.getData()
                if (imageData != nil) {
                    var image = UIImage(data: imageData!)
                    senderimage = image!
                } else {
                    senderimage = UIImage(named: "checkeduser.png")!
                }
            */
            
            
            
            let acl = PFACL()
            //acl.setPublicReadAccess(true)
            //acl.setPublicWriteAccess(true)
            acl.setReadAccess(true, forUserId: receiverid)
            acl.setReadAccess(true, forUserId: PFUser.currentUser()!.objectId!)
            acl.setWriteAccess(true, forUserId: receiverid)
            acl.setWriteAccess(true, forUserId: PFUser.currentUser()!.objectId!)
            event.ACL = acl
        
         event.pinInBackground()
         event.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    self.restore()
                    
                    var date = NSDate()
                    
                    userevents.append(Event(eventtype: "GoShop", eventnote: "", eventdate: date, eventuser: [(PFUser.currentUser()!.objectId!),currentuseremail,currentusername], eventreceiver: [receiverid, self.receiveremail.text!,receivername], eventid: uuid))
                     //userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid, eventreceiverimage: senderimage))
                   // userevents.append(Event(eventtype: "GoShop", eventnote: "", eventdate: date, eventuser: [(PFUser.currentUser()!.objectId!),currentuseremail,currentusername], eventreceiver: [receiverid, self.receiveremail.text!,receivername], eventid: uuid, eventreceiverimage: senderimage))
                    
                     self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("messend", comment: ""))
                    print("event was sent")
                    
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        userevents.sortInPlace({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
                        self.tableView.reloadData()
                    })
                } else {
                    self.restore()
                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: "\(error)")
                     self.restore()
                    // There was a problem, check error.description
                }
        }
            
            
            let userQuery = PFUser.query()
            userQuery!.whereKey("objectId", equalTo: receiverid)
            let pushQuery = PFInstallation.query()
            pushQuery!.whereKey("user", matchesQuery: userQuery!)
            
            var push:PFPush = PFPush()
            push.setQuery(pushQuery)
            //push.setChannel("Reload")
            
            //var alert : NSString = "\(currentusername) is going shopping! Maybe you need something to buy?"
          //  var alert : String = "\(currentusername) is going shopping! Maybe you need something to buy?"
                
                  var alert : String = "\(currentusername) \(NSLocalizedString("goingshopping", comment: ""))"
          //  var data:NSDictionary = ["alert":alert,"badge":"0","content-available":"1","sound":""]
            //var data:NSDictionary = ["alert":alert,"badge":"Increment"]
           // push.setMessage("\(currentusername) is going shopping! Maybe you need something to buy?")
            //push.setData(data as [NSObject : AnyObject])
                var data:NSDictionary = ["alert":alert,"badge":"Increment", "sound":"default"]
                // push.setMessage(alert)
                push.setData(data as [NSObject : AnyObject])
            push.sendPushInBackground()
            
            } else {
                 self.restore()
                displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("nouser", comment: ""))
                print("no such user")
            }
        
        } else {
             self.restore()
             self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("NoConnection", comment: ""))
             print("No internet connection found")
        }
    }
    
    @IBAction func choosefromcontacts(sender: AnyObject) {
        
        performSegueWithIdentifier("showcontactspopup", sender: self)
    }
    
    
    
    
    
    @IBOutlet var tableView: UITableView!
    
    
    func choosecontact(chosenuser:Contact) {
        
        chosencontact = chosenuser
        receiveremail.text = chosenuser.contactemail
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        delegate?.refreshmainview()
        
        
        if segue.identifier == "showcontactspopup" {
            
            let popoverViewController = segue.destinationViewController as! ContactsPopup
            
            
            popoverViewController.preferredContentSize = CGSize(width: 300, height: self.view.frame.height*0.6)
            popoverViewController.view.backgroundColor = UIColor.whiteColor()
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            
            
            popoverViewController.delegate = self
            
        }
        
        if segue.identifier == "showreport" {
            
            let popoverViewController = segue.destinationViewController as! ReportPopup
            
            
           // popoverViewController.preferredContentSize = CGSize(width: 200, height: 150)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            //popoverViewController.popoverPresentationController!.delegate = self
            
            
            
            popoverViewController.userid = useridtoblock
            
            popoverViewController.useremail = useremailtoblock
            
        }
    }
    
    
    ///table
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var listarray = [AnyObject]()
    
    func blockuser(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let nextview = view.superview!
        //let cell = view.superview as! ItemShopListCell
        let cell = nextview.superview as! EventCell
        let indexPathBlock = tableView.indexPathForCell(cell)
        
        useridtoblock = userevents[indexPathBlock!.row].eventuser[0] as! String
        
        useremailtoblock = userevents[indexPathBlock!.row].eventuser[1] as! String
        
     
        performSegueWithIdentifier("showreport", sender: self)
    
        
    
    }
    
    func blockuser2(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let nextview = view.superview!
        //let cell = view.superview as! ItemShopListCell
        let cell = nextview.superview as! ContactEventCell
        let indexPathBlock = tableView.indexPathForCell(cell)
        
        useridtoblock = userevents[indexPathBlock!.row].eventuser[0] as! String
        
        useremailtoblock = userevents[indexPathBlock!.row].eventuser[1] as! String
        
        
        performSegueWithIdentifier("showreport", sender: self)
        
        
        
    }
    
    
    

    var useridtoblock = String()
    var useremailtoblock = String()
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if userevents[indexPath.row].eventtype == "GoShop" {
        
        let ItemCellIdentifier = "eventscell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! EventCell
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.stringFromDate(userevents[indexPath.row].eventdate)
        cell.eventdate.text = date
        
        let dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        let date2 = dateFormatter2.stringFromDate(userevents[indexPath.row].eventdate)
        cell.eventhours.text = date2
        
        
        if userevents[indexPath.row].eventuser[0] as! String == PFUser.currentUser()!.objectId! {
            //case when I send an event to a certain user
            let recname : String = userevents[indexPath.row].eventreceiver[2] as! String
            let recemail: String = userevents[indexPath.row].eventreceiver[1] as! String
            cell.nameandevent.text = recname
            cell.receiveremail.text = recemail
            
            cell.receiverimage.layer.cornerRadius = cell.receiverimage.frame.size.width / 2
            cell.receiverimage.layer.masksToBounds = true
            cell.receiverimage.layer.borderWidth = 0.7
            cell.receiverimage.layer.borderColor = UIColorFromRGB(0x979797).CGColor
            
            //cell.userimage.layer.cornerRadius = cell.userimage.frame.size.width / 2
           // cell.userimage.layer.masksToBounds = true
           // cell.userimage.layer.borderWidth = 2
           // cell.userimage.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
            //if PFUser.currentUser()?["UserContacts"] != nil
            
          //  if let founduser = find(lazy(usercontacts).map({ $0.contactid }), userevents[indexPath.row].eventreceiver[0] as! String) {
            if let founduser = usercontacts.map({ $0.contactid }).indexOf(userevents[indexPath.row].eventreceiver[0] as! String) {
                let contactuser = usercontacts[founduser]
                
                cell.receiverimage.image = contactuser.contactimage
               
            } else {
                cell.receiverimage.image = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
            }

            //cell.userimage.image = loggeduserimage
            
            cell.eventtext.text = NSLocalizedString("findout", comment: "")
            
            cell.blockuseroutlet.hidden = true
            
        } else {
            // case if someone sends event to me
            let recname : String = userevents[indexPath.row].eventuser[2] as! String
            let recemail: String = userevents[indexPath.row].eventuser[1] as! String
            cell.nameandevent.text = recname
            cell.receiveremail.text = recemail
            
            cell.receiverimage.layer.cornerRadius = cell.receiverimage.frame.size.width / 2
            cell.receiverimage.layer.masksToBounds = true
            cell.receiverimage.layer.borderWidth = 0.7
            cell.receiverimage.layer.borderColor = UIColorFromRGB(0x979797).CGColor
            
           // cell.userimage.layer.cornerRadius = cell.userimage.frame.size.width / 2
           // cell.userimage.layer.masksToBounds = true
           // cell.userimage.layer.borderWidth = 2
           // cell.userimage.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
            //if PFUser.currentUser()?["UserContacts"] != nil
            
           // if let founduser = find(lazy(usercontacts).map({ $0.contactid }), userevents[indexPath.row].eventuser[0] as! String) {//eventreceiver[0] as! String) {
            
            if let founduser = usercontacts.map({ $0.contactid }).indexOf(userevents[indexPath.row].eventuser[0] as! String) {
                let contactuser = usercontacts[founduser]
                
                //cell.userimage.image = contactuser.contactimage
                cell.receiverimage.image = contactuser.contactimage
            } else {
                
                cell.receiverimage.image = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                
                //cell.userimage.image = UIImage(named: "checkeduser.png")!
                /*
                if (userevents[indexPath.row].eventreceiverimage != nil) {
                cell.receiverimage.image = userevents[indexPath.row].eventreceiverimage!
                } else {
                cell.receiverimage.image = UIImage(named: "checkeduser.png")!
                }
                */
            }
            
           // cell.receiverimage.image = loggeduserimage
            
            cell.eventtext.text = NSLocalizedString("goingshopping", comment: "")
            
            cell.blockuseroutlet.hidden = false
            cell.blockuseroutlet.addTarget(self, action: "blockuser:", forControlEvents: UIControlEvents.TouchUpInside)
            
        }
        
        
       
        
        return cell
            
        } else {
            let ItemCellIdentifier = "addcontaceventcell"
            let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ContactEventCell
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let date = dateFormatter.stringFromDate(userevents[indexPath.row].eventdate)
            cell.eventdate.text = date
            
            let dateFormatter2 = NSDateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            let date2 = dateFormatter2.stringFromDate(userevents[indexPath.row].eventdate)
            cell.eventhours.text = date2
            
            
            if userevents[indexPath.row].eventuser[0] as! String == PFUser.currentUser()!.objectId! {
                //case when I send an event to a certain user
                let recname : String = userevents[indexPath.row].eventreceiver[2] as! String
                let recemail: String = userevents[indexPath.row].eventreceiver[1] as! String
                cell.nameandevent.text = recname
                cell.receiveremail.text = recemail
                
                cell.receiverimage.layer.cornerRadius = cell.receiverimage.frame.size.width / 2
                cell.receiverimage.layer.masksToBounds = true
                cell.receiverimage.layer.borderWidth = 0.7
                cell.receiverimage.layer.borderColor = UIColorFromRGB(0x979797).CGColor
                
                //cell.userimage.layer.cornerRadius = cell.userimage.frame.size.width / 2
                // cell.userimage.layer.masksToBounds = true
                // cell.userimage.layer.borderWidth = 2
                // cell.userimage.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
                //if PFUser.currentUser()?["UserContacts"] != nil
                
                //  if let founduser = find(lazy(usercontacts).map({ $0.contactid }), userevents[indexPath.row].eventreceiver[0] as! String) {
                if let founduser = usercontacts.map({ $0.contactid }).indexOf(userevents[indexPath.row].eventreceiver[0] as! String) {
                    let contactuser = usercontacts[founduser]
                    
                    cell.receiverimage.image = contactuser.contactimage
                    
                } else {
                    cell.receiverimage.image = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                   
                }
                
                //cell.userimage.image = loggeduserimage
                
                cell.eventtext.text = NSLocalizedString("eventuseradded", comment: "")
                
                cell.blockuseroutlet.hidden = true
                
                cell.addcontact.hidden = true
                
            } else {
                // case if someone sends event to me
                let recname : String = userevents[indexPath.row].eventuser[2] as! String
                let recemail: String = userevents[indexPath.row].eventuser[1] as! String
                cell.nameandevent.text = recname
                cell.receiveremail.text = recemail
                
                cell.receiverimage.layer.cornerRadius = cell.receiverimage.frame.size.width / 2
                cell.receiverimage.layer.masksToBounds = true
                cell.receiverimage.layer.borderWidth = 0.7
                cell.receiverimage.layer.borderColor = UIColorFromRGB(0x979797).CGColor
                
                // cell.userimage.layer.cornerRadius = cell.userimage.frame.size.width / 2
                // cell.userimage.layer.masksToBounds = true
                // cell.userimage.layer.borderWidth = 2
                // cell.userimage.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
                //if PFUser.currentUser()?["UserContacts"] != nil
                
                // if let founduser = find(lazy(usercontacts).map({ $0.contactid }), userevents[indexPath.row].eventuser[0] as! String) {//eventreceiver[0] as! String) {
                
                if let founduser = usercontacts.map({ $0.contactid }).indexOf(userevents[indexPath.row].eventuser[0] as! String) {
                    let contactuser = usercontacts[founduser]
                    
                    //cell.userimage.image = contactuser.contactimage
                    cell.receiverimage.image = contactuser.contactimage
                } else {
                    //cell.userimage.image = UIImage(named: "checkeduser.png")!
                    //cell.receiverimage.image = UIImage(named: "checkeduser.png")!
                   
                        cell.receiverimage.image = userevents[indexPath.row].eventreceiverimage!
                   
                    
                }
                
                // cell.receiverimage.image = loggeduserimage
                
                cell.eventtext.text = NSLocalizedString("useraddedyou", comment: "")
                
                cell.blockuseroutlet.hidden = false
                cell.blockuseroutlet.addTarget(self, action: "blockuser2:", forControlEvents: UIControlEvents.TouchUpInside)
                
                if let founduser = usercontacts.map({ $0.contactid }).indexOf(userevents[indexPath.row].eventuser[0] as! String) {
                    
                    cell.addcontact.hidden = true
                } else {
                    cell.addcontact.hidden = false
                    cell.addcontact.addTarget(self, action: "addusertocontacts:", forControlEvents: UIControlEvents.TouchUpInside)
                }
                
                
            }
            
            
            
            
            return cell
            
            
        }
    }
    
    
  
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        return nil
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return userevents.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func viewWillAppear(animated: Bool) {
       userevents.sortInPlace({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
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
    
    func checkreceivedevents() {
        /*
        var query1 = PFQuery(className:"UsersEvents")
        query1.whereKey("SenderId", equalTo: PFUser.currentUser()!.objectId!)
        query1.whereKey("isReceived", equalTo: false)
        
        
        var query2 = PFQuery(className:"UsersEvents")
        query2.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
        query2.whereKey("isReceived", equalTo: false)
        
        
        let query = PFQuery.orQueryWithSubqueries([query1, query2])
        */
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
    
    func reloadTableAfterPush() {
        
       // displaySuccessAlert("", message: mesalert)
        
        checkreceivedevents()
        
        tableView.reloadData()

    }
    
    
    @IBAction func refresh(sender: AnyObject) {
        
        
        if CheckConnection.isConnectedToNetwork() {
            checkreceivedevents()
        } else {
            print("No internet connection found")
        }
        
        
        tableView.reloadData()
    }
    
    @IBOutlet var menuitem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuitem.target = self.revealViewController()
        menuitem.action = #selector(SWRevealViewController.revealToggle(_:)) // wtf?
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableAfterPush", name: "reloadTable", object: nil)
        
        receiveremail.delegate = self
        
      //  messagecontainer.layer.borderWidth = 1
      //   messagecontainer.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        
        
        receivedeventscount = 0

        receiveremail.mDelegate = self
        
        receiveremail.leftTextMargin = 5
        
        self.view.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "ContactEventCell", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "addcontaceventcell")
        
        
        if CheckConnection.isConnectedToNetwork() {
            //listsretrievalfromcloud()
           // checkreceivedevents()
        } else {
            print("No internet connection found")
        }
        
        
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
