//
//  ContactsViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 15/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPGTextFieldDelegate,UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    ////AUTOCOMPLETE PART
    var sampleData = [Dictionary<String, AnyObject>]()
    var contentsemails = [String]()
    var contentsnames = [String]()
    var dictionary = Dictionary<String, AnyObject>()
    
    func generateData(tempprefix: String){

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
                    
                    for i in 0 ..< self.contentsnames.count {
                        var name = self.contentsnames[i] as String//["username"] as! String
                        //name += " " + lName
                        var email = self.contentsemails[i] as String
                        self.dictionary = ["DisplayText":email,"DisplaySubText":name, "CustomObject":self.contentsnames[i]]
                        
                        self.sampleData.append(self.dictionary)
                        
                    }
                    
                }
            } else {
                // Log details of the failure
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

    
    
    /////
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
       //var emptyDict = [String: String]()
    //var test: [[String:String]] = [[:]]
    //var contactsarray: NSMutableDictionary= NSMutableDictionary()
    //var contactsdictionary = [String:String]() //dictionary
    var contactsdictionary = [[String]]()

   //var contactsarray = [[String:String]]()
    //var contactsarray = [[AnyObject]]() //that bitch works unlike dictionary, dict I ll use for different purpose
    
    //var contactsarrayafter = [[String:String]]()
    //var contactsarray = [["":""]]

    //var contactsarray = [contactsdictionary]()
    
    var contactsavatars = [PFFile]()
    var contactsimages = [UIImage]()
    var contacsimagespaths = [String]()
    var contactsnames = [String]()
    var contactsemails = [String]()
    
    var checkemail = []
    
    //var checkemailone = PFObject()
    
    var emailexists = Bool()
    
    var avatarFile = PFFile()
    var avatar = UIImage()
    
    var imagePath = String()
    var imageToLoad = UIImage()
    
    
   // var defaultimage: UIImage = UIImage()
    var defaultimage: UIImage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
    
    
    //var dict = [ 1 : "abc", 2 : "cde"] // dict is Dictionary<Int, String>
    
    //dict[3] = "efg"
    
    
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
    
    func displaySuccessAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "AddContactAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addAction(cancelCallback)
    }

    func cancelCallback() {
        print("CANCELED")
    }
    
    func closeCallback() {
        
         self.tableView.reloadData()
        
    }
    
    /*
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.tableView.reloadData()
            alert.dismissViewControllerAnimated(true, completion: nil)
            
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
    */
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
        
        imagePath = "item\(uuid).png"
        
        return imagePath
    }
    
    

    
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
        
        return UIImage(named: "checkeduser.png")!
    }
    */
    /*
    func retrieveContacts1() {
        
        var contactquery:PFQuery = PFUser.query()!
        contactquery.fromLocalDatastore()
        contactquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        contactquery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
               self.contactsarray.removeAll(keepCapacity: true)
                self.contactsemails.removeAll(keepCapacity: true)
                self.contactsnames.removeAll(keepCapacity: true)
                self.contactsavatars.removeAll(keepCapacity: true)
                if let users = objects as? [PFObject] {
                    for object in users {
                        println(object.objectId)
                        //self.contactsarray.append(object["UserContacts"] as! [[String : String]])
                        if object["UserContacts"] != nil {
                        self.contactsarray = (object["UserContacts"] as! [[AnyObject]]) //getting the contacts array
                            //AnyObject because two strings and one pffile
                          
                            
                          println(self.contactsarray)
                           
                            //contactsarrayafter = contactsarray
                        
                        //getting names and emails from array
                            for element in self.contactsarray {
                                //self.contactsdictionary[element.values.first! as String] = "certain name"//"certain name"
                               // self.contactsdictionary.append(self.contactsarray[element])
                                //self.contactsemails.append(element.values.first! as String)
                                self.contactsnames.append(element[0] as! String)
                                self.contactsemails.append(element[1] as! String)
                                self.contactsavatars.append(element[2] as! PFFile)
                                /*
                                var getavatar = UIImage()
                                
                                element[3].getDataInBackgroundWithBlock { (data, error) -> Void in
                                    if let downloadedImage = UIImage(data: data!) {
                                        getavatar = downloadedImage
                                    }
                                    
                                }
                                */
                                
                                
                                
                                
                            }
                        } else {
                            println("no contacts so far")
                        }
                        println("my contacts are \(self.contactsdictionary)")
                        println("my contacts emails are \(self.contactsemails)")
                        println("my contacts names are \(self.contactsnames)")
                        println("my contacts avatars are \(self.contactsavatars)")

                        /*
                        if self.contactsdictionary != ["":""] {
                        self.contactsnames = [self.contactsdictionary.values.first! as String] //have to cast String
                        //self.contactsemails = [self.contactsdictionary.values.endIndex as String]
                        //let v = dict.allValues[0] as String
                        //previous method I will use for sharedWith
                            println("my contacts are \(self.contactsdictionary)")
                            println("my contacts names are \(self.contactsnames)")
                        } else {
                            println("No contacts available")
                        }
                        */
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
         self.tableView.reloadData()
    }
    */
    /*
    func checkexistance() -> Bool {
        var query1:PFQuery = PFUser.query()!
        query1.whereKey("email", equalTo:self.contactemail.text)
       // self.checkemail = //query1.findObjects()!
       // var checkemailone : PFObject = query1.getFirstObject()
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
    */
    
    @IBOutlet var contactemail: MPGTextField_Swift!
    
    var loadeddata : Bool = false
    
    @IBAction func emaileditingchanged(sender: AnyObject) {
        
        var string : String = contactemail.text!
        
        print(string)
        
        var length = string.characters.count//count(string)
        
        print(length)
        
        //if length >= 6 {
        if (length == 4) {

            
            
            if !loadeddata {
                self.generateData(string)
                loadeddata = true
            }
            
          //  print(sampleData)
            
        }
        
       // print(sampleData)
        
    }
    
    
    
    var imagefile = PFFile()
    var newusername = String()
    var newuserid = String()
    
    func getcontactavatar(usermail:String) -> (ava: PFFile, name: String, id: String) {
        
        
        
        let contactimagequery:PFQuery = PFUser.query()!
        contactimagequery.whereKey("email", equalTo: usermail)
        contactimagequery.limit = 1
        let users = contactimagequery.findObjects()
        if (users != nil) {
            for user in users! {
                if let avatar = user["Avatar"] as? PFFile { //used to be username
                    
                    imagefile = user["Avatar"] as! PFFile //used to be username
                }
                if let name = user["name"] as? String { //used to be username
                    
                    newusername = user["name"] as! String //used to be username
                } else {
                    newusername = NSLocalizedString("unknown", comment: "")
                }
                
                //if let id = user["objectId"] as? String { //used to be username
                if user.objectId != nil {
                    newuserid = user.objectId!! //user["objectId"] as! String //used to be username
                } else {
                    newuserid = ""
                }//}
                
            }
        } else {
            print("No username yet")
        }
        
        
        return (imagefile, newusername, newuserid)
    }
    
    
   
    
    func sendevent(receiverid:String, receiveravatar:UIImage, receiveremail:String, receivername:String) {
        
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
        var eventid = "contact\(uuid)"
        
        event["EventText"] = ""
        event["EventType"] = "AddContact"
        event["SenderId"] = PFUser.currentUser()!.objectId!
        event["receiverEmail"] = receiveremail
        event["ReceiverId"] = receiverid
        event["isReceived"] = false
        event["senderInfo"] = [(PFUser.currentUser()!.objectId!),currentuseremail,currentusername]
        event["receiverInfo"] = [receiverid, receiveremail, receivername]
        event["eventUUID"] = eventid
        
        //let imageData = UIImagePNGRepresentation(receiveravatar)
       // let imageFile = PFFile(name:"senderuseravatar.png", data:imageData!)
        if !(PFAnonymousUtils.isLinkedWithUser(PFUser.currentUser())) {
        let file : PFFile = (PFUser.currentUser()?["Avatar"] as? PFFile)!
        
        event["senderavatar"] = file
        } else {
            let imageData = UIImagePNGRepresentation(UIImage(contentsOfFile: "UserIcon")!)
             let imageFile = PFFile(name:"senderuseravatar.png", data:imageData!)
            
            event["senderavatar"] = imageFile
        }
        
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
                
                userevents.append(Event(eventtype: "AddContact", eventnote: "", eventdate: date, eventuser: [(PFUser.currentUser()!.objectId!),currentuseremail,currentusername], eventreceiver: [receiverid,receiveremail,receivername], eventid: eventid))
                
                
                print("Contact event was sent")
                
                let userQuery = PFUser.query()
                userQuery!.whereKey("objectId", equalTo: receiverid)
                let pushQuery = PFInstallation.query()
                pushQuery!.whereKey("user", matchesQuery: userQuery!)
                
                var push:PFPush = PFPush()
                push.setQuery(pushQuery)
               
               // var alert : String = "\(currentusername) (\(currentuseremail)) added you to contact list"
                
                var alert : String = "\(currentusername) (\(currentuseremail)) \( NSLocalizedString("addedyou", comment: ""))"
                
               // var data:NSDictionary = ["alert":alert,"badge":"Increment"]
                var data:NSDictionary = ["alert":alert,"badge":"Increment", "sound":"default"]
                push.setData(data as [NSObject : AnyObject])
                push.sendPushInBackground()
                
                
               // dispatch_async(dispatch_get_main_queue(), {
                    userevents.sortInPlace({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
                                   // })
            } else {
                self.restore()
               // self.displaySuccessAlert("Oops!", message: "There was a problem with ")
                // There was a problem, check error.description
            }
        }
        
        
        
    }
    
    

    @IBAction func addcontact(sender: AnyObject) {
        if self.contactemail.text != "" && (self.contactemail.text! as NSString).containsString("@") {
        pause()

        self.getcontactavatar(self.contactemail.text!)

        var query:PFQuery = PFUser.query()!
        query.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!) {
            (thisuser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let thisuser = thisuser {
                
                var useravatar = UIImage()
            
                    var imageData = self.imagefile.getData()
                    if (imageData != nil) {
                        var image = UIImage(data: imageData!)
                        
                        print(imageData)

                        useravatar = image!
                    } else {
                        useravatar = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                }

                print(contactsarray)
             
                    
                usercontacts.append(Contact(contactid: self.newuserid,contactimage: useravatar, contactname: self.newusername, contactemail: self.contactemail.text!))
                    
                contactsarray.append([(self.newusername),(self.contactemail.text)!, self.imagefile, self.newuserid]) //NO ID?!
                
                thisuser["UserContacts"] = contactsarray

                    thisuser.pinInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            //self.restore()
                            self.restore()
                            print("saved user to local datastore")

                            dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                            }
                            
                            /// Now ADD EVENT
                            
                            self.sendevent(self.newuserid, receiveravatar: useravatar, receiveremail: self.contactemail.text!, receivername: self.newusername)
                            
                        } else {
                            print("error")
                        }
                    })//pinInBackground()
                    thisuser.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            
                            
                            //self.restore()
                            
                            print("saved user to server")
                            self.displaySuccessAlert( NSLocalizedString("DoneExc", comment: ""), message: NSLocalizedString("useraddedfull", comment: ""))
                            self.tableView.reloadData()
                           // self.displayAlert("User added!", message: "Everything went fine!")
                        } else {
                            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                            print("error")
                        }
                        
                        self.tableView.reloadData()
                    })

                           }
        }
 
        
        } else {
            
            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("validemail", comment: ""))
        }
    }
    
    func swipedelete(indexPath: NSIndexPath) {
        
        var contacttodelete = usercontacts[indexPath.row].contactid
        
        var contacttodeleteemail = usercontacts[indexPath.row].contactemail
        
   
        
        var contactquery:PFQuery = PFUser.query()!
        contactquery.fromLocalDatastore()
        contactquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        contactquery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                //usercontacts.removeAll(keepCapacity: true)
                
                if let users = objects as? [PFObject] {
                    
                    
                    for object in users {
                        // println(object.objectId)
                        if let arr = object["UserContacts"] as? [AnyObject] {//!= nil {
                            
                            print(contactsarray)
                            
                            
                            for var i = 0;i<contactsarray.count;++i {
                                
                                
                                print(i)
                          
                                if contactsarray[i][3] as! String == contacttodelete {
                                    contactsarray.removeAtIndex(i)
                                }
                                
                          
                                if let foundcontact2 = usercontacts.map({ $0.contactid }).lazy.indexOf(contacttodelete) {
                                    
                                    usercontacts.removeAtIndex(foundcontact2)
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            
                  
                            
                            object["UserContacts"] = contactsarray
                            
                            print("USER CONTACTS AFTER \(contactsarray)")
                            
                            object.pinInBackground()
                            object.saveEventually()
                            
                        } else {
                            print("no contacts so far")
                        }
                        
                    }
 
                    dispatch_async(dispatch_get_main_queue()) {

                         self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                        self.tableView.reloadData()
                    }
                    
                    
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }

        }

        
        
        
    }
    
   
    @IBOutlet var tableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
    //retrieveContacts1()
    
    print(contactsarray)

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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactemail.delegate = self
        
        contactemail.mDelegate = self
        
        //contactemail.layer.sublayerTransform = CATransform3DMakeTranslation(4, 0, 0)
        
        contactemail.leftTextMargin = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //retrieveContacts1()
        
        print(contactsarray)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "helpcontact" {
            
            let popoverViewController = segue.destinationViewController as! HelpContact //UIViewController
            
            
            popoverViewController.preferredContentSize = CGSize(width: 300, height: 300)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            
            
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
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColorFromRGB(0xEFEFEF)//UIColor(red: 238/255, green: 168/255, blue: 15/255, alpha: 0.8)
        header.textLabel!.textColor = UIColorFromRGB(0x2A2F36)//UIColor.whiteColor()
        header.alpha = 1
        
        var topline = UIView(frame: CGRectMake(0, 0, header.contentView.frame.size.width, 1))
        topline.backgroundColor = UIColorFromRGB(0x2A2F36)
        
        header.contentView.addSubview(topline)
        
        var bottomline = UIView(frame: CGRectMake(0, 30, header.contentView.frame.size.width, 1))
        bottomline.backgroundColor = UIColorFromRGB(0x2A2F36)
        
        header.contentView.addSubview(bottomline)
        
      
        
    }
    */
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return ((ListsNames.count) - (ListsNames.count - 4))
        return usercontacts.count//contactsemails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "ContactsCell"
        let contactcell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ContactsCell
        
        //contactcell.contactnameoutlet.text = contact
       // recentcell.recentListName.text = newarray[indexPath.row]
        
        //contactcell.contactnameoutlet.text = contactsarray[indexPath.row]
        //contactcell.contactemailoutlet.text = contactsemails[indexPath.row]
        
        contactcell.contactnameoutlet.text = usercontacts[indexPath.row].contactname//contactsnames[indexPath.row]
        contactcell.contactemailoutlet.text = usercontacts[indexPath.row].contactemail//contactsemails[indexPath.row]
        contactcell.contactavatar.image = usercontacts[indexPath.row].contactimage
        
       // contactcell.deletebutton.addTarget(self, action: "deletecontact:", forControlEvents: .TouchUpInside)
        
        //contactcell.contactavatar.image = contactsavatars[indexPath.row]
       /* println(contactsnames)
        println(contactsnames[indexPath.row])
        println(contactsemails)
         println(contactsemails[indexPath.row])
        println(contactsavatars)
        println(contactsavatars[indexPath.row])*/
        /*
        contactsavatars[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                contactcell.contactavatar.image = downloadedImage
            }

        }
    */
        /*
        contactsarray[indexPath.row][2].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                contactcell.contactavatar.image = downloadedImage
            }
            
        }
        */

                return contactcell
    }

    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Normal, title: NSLocalizedString("deletebig", comment: "")) { (action , indexPath ) -> Void in
            
            
            // var thissection = indexPath.section
            
            self.editing = false
            
            self.swipedelete(indexPath)
            
        }
        
        deleteAction.backgroundColor = UIColorFromRGB(0xF23D55)
        
        
        return [deleteAction]//, shareAction]
    }



    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        
            }


}