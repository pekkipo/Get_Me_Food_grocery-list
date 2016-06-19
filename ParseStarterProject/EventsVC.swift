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

class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

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
    




    
    func displayContactAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "AddContactAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        //alertview.addAction(closeCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "AddContactAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        //alertview.addAction(closeCallback)
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

                       
                        
                    } else {
                       
                        print("error")
                    }
                })//pinInBackground()
                thisuser.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        

                        
                        print("saved user to server")
                        self.displayContactAlert(NSLocalizedString("useradded", comment: ""), message: NSLocalizedString("thisperson", comment: ""))

                    } else {
                       
                        self.displayFailAlert(NSLocalizedString("errorExc", comment: ""), message: "\(NSLocalizedString("error2", comment: "")) \(error)")
                        print("error")
                        
                    }
                    
                    self.tableView.reloadData()
                })

            }
        }
        
        
        
    }
    
    

    
    
    @IBOutlet var tableView: UITableView!
    
    
   

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        delegate?.refreshmainview()
        

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
            

            if let founduser = usercontacts.map({ $0.contactid }).indexOf(userevents[indexPath.row].eventreceiver[0] as! String) {
                let contactuser = usercontacts[founduser]
                
                cell.receiverimage.image = contactuser.contactimage
               
            } else {
                cell.receiverimage.image = defaultcatimages[1].itemimage            }


            
            cell.eventtext.text = NSLocalizedString("findout", comment: "")
            
            
            
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
        
        
        
      //  messagecontainer.layer.borderWidth = 1
      //   messagecontainer.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        
        
        receivedeventscount = 0

       
        
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
