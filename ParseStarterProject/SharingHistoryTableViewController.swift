//
//  SharingHistoryTableViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 22/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation

class SharingHistoryTableViewController: UITableViewController {
    
    var sendercontroller = String()
    
    @IBAction func refreshinfo(sender: AnyObject) {
        automaticcheck()
    }
    
    @IBOutlet var backormenubar: UIBarButtonItem!
    
    
    @IBAction func backbar(sender: AnyObject) {
        
        
        if sendercontroller == "MainMenu" {
            performSegueWithIdentifier("MainMenuUnwind", sender: self)
        } else if sendercontroller == "SharingVC" {
            
            performSegueWithIdentifier("SharingVCUnwind", sender: self)
        } else if sendercontroller == "SettingsVC" {
            performSegueWithIdentifier("SettingsVCUnwind", sender: self)
        }
        
    }

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //var SharedLists = Dictionary<String, Array<AnyObject>>()
    var ListsNames = [String]()
    var ListsArray = [[AnyObject]]()//[String,String,String,String,Bool]()[AnyObject]() //not SURE
    var ListsIds = [String]()
    var ListsType = [String]()
    
    var isReceivedArray = [Bool]()
    var isReceived = [Bool]()
    var sendlistid = String()
    //var sendlistreceiveremail = String()
    var sendlistreceiverId = String()
   // var sections = Dictionary<String, Array<Dictionary<String, AnyObject>>>()
    
    var accepted : UIImage = UIImage(named: "4CheckMark")!
    var notaccepted : UIImage = UIImage(named: "notaccepted")!
    
    var shopicon : UIImage = UIImage(named: "BlackCart")!
    var todoicon: UIImage = UIImage(named: "BlackDoH25")!
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addCancelAction(closeCallback)
    }

    func closeCallback() {
        print("CANCELED")
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

    
    
    func dataretrieval() -> [AnyObject] {
        
        //pause()
        self.ListsArray.removeAll(keepCapacity: true)
        self.ListsNames.removeAll(keepCapacity: true)
        self.ListsIds.removeAll(keepCapacity: true)
        self.ListsType.removeAll(keepCapacity: true)
        // var userquery = PF
        var query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isShared", equalTo: true)
        
        query.orderByAscending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
               // self.SharedLists.removeAll(keepCapacity: true)
               // self.ListsArray.removeAll(keepCapacity: true)
                if let lists = objects as? [PFObject] {
                    for object in lists {
                        print(object.objectId)
                        //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        var thislistissharedwith = [[AnyObject]]()
                        thislistissharedwith = object["ShareWithArray"] as! [[AnyObject]]
                        
                        for sharedlist in thislistissharedwith {
                        
                        //SharedLists[object["listUUID"] as! String]:sharedlist)
                           // self.SharedLists[object["listUUID"] as! String] = sharedlist
                            var listid : String = object["listUUID"] as! String
                            
                           // self.SharedLists = [listname:sharedlist]
                            
                            self.ListsArray.append(sharedlist)
                            self.ListsNames.append(object["ShopListName"] as! String)
                            self.ListsIds.append(listid)
                            self.ListsType.append("Shop")
                            
                           
                            //self.sections[commoncategory] = [items[i]]
                        
                        }
                        
                        self.ListsArray = self.ListsArray.reverse()
                        self.ListsNames = self.ListsNames.reverse()
                        self.ListsIds = self.ListsIds.reverse()
                        self.ListsType = self.ListsType.reverse()
                        
                        
                        
                        self.restore()
                        self.tableView.reloadData()
                    }
                    
                    self.automaticcheck()
                }
                
               // println(self.SharedLists)
                print(self.ListsNames)
                print(self.ListsArray)
               // self.automaticcheck()
                
            } else {
                self.restore()
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        ///now todos
        
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.fromLocalDatastore()
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.whereKey("isShared", equalTo: true)
        
        querytodo.orderByAscending("updateDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                // self.SharedLists.removeAll(keepCapacity: true)
                //self.ListsArray.removeAll(keepCapacity: true)
                
                if let lists = objects as? [PFObject] {
                    for object in lists {
                        print(object.objectId)
                        //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                        var thislistissharedwith = [[AnyObject]]()
                        thislistissharedwith = object["ShareWithArray"] as! [[AnyObject]]
                        
                        for sharedlist in thislistissharedwith {
                            
                            //SharedLists[object["listUUID"] as! String]:sharedlist)
                            // self.SharedLists[object["listUUID"] as! String] = sharedlist
                            var listid : String = object["listUUID"] as! String
                            
                            // self.SharedLists = [listname:sharedlist]
                            
                            self.ListsArray.append(sharedlist)
                            self.ListsNames.append(object["ToDoListName"] as! String)
                            self.ListsIds.append(listid)
                            self.ListsType.append("ToDo")
                            
                            
                            //self.sections[commoncategory] = [items[i]]
                            
                        }
                        
                        self.ListsArray = self.ListsArray.reverse()
                        self.ListsNames = self.ListsNames.reverse()
                        self.ListsIds = self.ListsIds.reverse()
                        self.ListsType = self.ListsType.reverse()

                        //self.automaticcheck()
                        
                        self.restore()
                        self.tableView.reloadData()
                    }
                    
                    self.automaticcheck()

                }
                
                // println(self.SharedLists)
                print(self.ListsNames)
                print(self.ListsArray)
               // self.automaticcheck()
                
            } else {
                // Log details of the failure
                self.restore()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        

        
        return ListsArray
    }
    
    
    func automaticcheck() {
        
        if CheckConnection.isConnectedToNetwork() {
        
            print(ListsArray.count)
            
            
        for var index = 0; index < ListsArray.count; index++ {
            
            if ListsArray[index][5] as! Bool == false {
                //means if that list is not received yet, then I check it
                
                sendlistid = ListsArray[index][4] as! String
                sendlistreceiverId = ListsArray[index][0] as! String
                let thislistidtochange : String = ListsIds[index]
                
                
                if ListsType[index] == "Shop" {
                    /////
                    //pause()
                    let queryrec = PFQuery(className:"shopLists")
                    queryrec.whereKey("listUUID", equalTo: sendlistid)
                    queryrec.getFirstObjectInBackgroundWithBlock {
                        (receivedlist: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print("The getFirstObject request failed.")
                            self.restore()
                        } else if let receivedlist = receivedlist {
                            // The find succeeded.
                            print("Successfully retrieved the object.")
                            
                            if receivedlist["confirmReception"] as! Bool == true {
                                
                                                               if let founditem = self.ListsArray.map({ $0[4] as! String }).lazy.indexOf(self.sendlistid) {
                           
                                    
                                    self.ListsArray[founditem][5] = true
                                }
                                
                                
                                self.tableView.reloadData()
                                
                                
                                
                                ///// NOW UPDATE THIS LIST INGO
                                
                                print(thislistidtochange)
                                
                                let querythislist = PFQuery(className:"shopLists")
                                querythislist.fromLocalDatastore()
                                querythislist.whereKey("listUUID", equalTo: thislistidtochange)//self.ListsIds[index])
                                querythislist.getFirstObjectInBackgroundWithBlock {
                                    (list: PFObject?, error: NSError?) -> Void in
                                    if error != nil {
                                        print("The getFirstObject request failed.")
                                        self.restore()
                                    } else if let list = list {
                                        // The find succeeded.
                                        print("Successfully retrieved the object.")
                                        
                                        var arrayofshared : [[AnyObject]] = list["ShareWithArray"] as! [[AnyObject]]
                                        
                                        print("11111 \(arrayofshared)")
                                        
                                        // for listinarray in arrayofshared {
                                        for var i = 0; i < arrayofshared.count; i++ {
                                            if (arrayofshared[i][0] as! String == self.sendlistreceiverId) && (arrayofshared[i][4] as! String == self.sendlistid) {
                                                
                                                arrayofshared[i][5] = true

                                                break;
                                            } else {
                                                print("Not that list")
                                            }
                                            
                                        }
                                        //save this array and send to parse
                                        
                                        print("22222 \(arrayofshared)")
                                        
                                        list["ShareWithArray"] = arrayofshared
                                        
                                        
                                        
                                        list.pinInBackgroundWithBlock({ (success, error) -> Void in
                                            if success {
                                                print("Saved the info to local store!")
                                                
                                                
                                            } else {
                                                print("Wasn't saved to local for some reason")
                                            }
                                        })
                                        
                                        list.saveEventually()
                                        
                                        
                                    }
                                }

                                
                            } else {
                                
                                print("NOPE")

                                
                            }
                            
                            
                            self.restore()
                        }
                        
                        
                        ///////
                    }
                    
                    
                } else if ListsType[index] == "ToDo" {
                    
                    
                   // pause()
                    let queryrec = PFQuery(className:"toDoLists")
                    queryrec.whereKey("listUUID", equalTo: sendlistid)
                    queryrec.getFirstObjectInBackgroundWithBlock {
                        (receivedlist: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print("The getFirstObject request failed.")
                            self.restore()
                        } else if let receivedlist = receivedlist {
                            // The find succeeded.
                            print("Successfully retrieved the object.")
                            
                            if receivedlist["confirmReception"] as! Bool == true {
                               // self.ListsArray[index][5] = true
                                
                                
                                
                                if let founditem = self.ListsArray.map({ $0[4] as! String }).lazy.indexOf(self.sendlistid) {
                                    //let catalogitem = catalogitems[founditem]
                                    
                                    self.ListsArray[founditem][5] = true
                                }
                                
                                self.tableView.reloadData()
                                
                                
                                
                                ///// NOW UPDATE THIS LIST INGO
                                
                                let querythislist = PFQuery(className:"toDoLists")
                                querythislist.fromLocalDatastore()
                                querythislist.whereKey("listUUID", equalTo: thislistidtochange)//self.ListsIds[index])
                                querythislist.getFirstObjectInBackgroundWithBlock {
                                    (list: PFObject?, error: NSError?) -> Void in
                                    if error != nil {
                                        print("The getFirstObject request failed.")
                                        self.restore()
                                    } else if let list = list {
                                        // The find succeeded.
                                        print("Successfully retrieved the object.")
                                        
                                        var arrayofshared : [[AnyObject]] = list["ShareWithArray"] as! [[AnyObject]]
                                        
                                        print("11111 \(arrayofshared)")
                                        
                                        // for listinarray in arrayofshared {
                                        for var i = 0; i < arrayofshared.count; i++ {
                                            if (arrayofshared[i][0] as! String == self.sendlistreceiverId) && (arrayofshared[i][4] as! String == self.sendlistid) {
                                                
                                                arrayofshared[i][5] = true

                                                break;
                                            } else {
                                                print("Not that list")
                                            }
                                            
                                        }
                                        //save this array and send to parse
                                        
                                        print("22222 \(arrayofshared)")
                                        
                                        list["ShareWithArray"] = arrayofshared
                                        
                                        
                                        
                                        list.pinInBackgroundWithBlock({ (success, error) -> Void in
                                            if success {
                                                print("Saved the info to local store!")
                                                
                                                
                                            } else {
                                                print("Wasn't saved to local for some reason")
                                            }
                                        })
                                        
                                        list.saveEventually()
                                        
                                        
                                    }
                                }

                                
                            } else {
                                
                                print("NOPE")
 
                                
                            }
                            
                            
                            self.restore()
                        }
                    }
                    
                    
                }
                
                
                
            }
            
            
        }
        
        
    } else {
            print("No internet")
            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("NoConnection", comment: ""))
    
    }
    }
    
    
    func checkifreceived(sender: UIButton!) {
        
        
        
        if CheckConnection.isConnectedToNetwork() {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! SharingHistoryCell
        let indexPathCheck = tableView.indexPathForCell(cell)

        sendlistid = ListsArray[indexPathCheck!.row][4] as! String

            sendlistreceiverId = ListsArray[indexPathCheck!.row][0] as! String

        
               if ListsType[indexPathCheck!.row] == "Shop" {
        /////
        pause()
        let queryrec = PFQuery(className:"shopLists")
        queryrec.whereKey("listUUID", equalTo: sendlistid)
        queryrec.getFirstObjectInBackgroundWithBlock {
            (receivedlist: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print("The getFirstObject request failed.")
                self.restore()
            } else if let receivedlist = receivedlist {
                // The find succeeded.
                print("Successfully retrieved the object.")
                
                if receivedlist["confirmReception"] as! Bool == true {
                    self.ListsArray[indexPathCheck!.row][5] = true
                    self.tableView.reloadData()
                    
                    
                    
                    ///// NOW UPDATE THIS LIST INGO
                    
                    let querythislist = PFQuery(className:"shopLists")
                    querythislist.fromLocalDatastore()
                    querythislist.whereKey("listUUID", equalTo: self.ListsIds[indexPathCheck!.row])
                    querythislist.getFirstObjectInBackgroundWithBlock {
                        (list: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print("The getFirstObject request failed.")
                            self.restore()
                        } else if let list = list {
                            // The find succeeded.
                            print("Successfully retrieved the object.")
                            
                            var arrayofshared : [[AnyObject]] = list["ShareWithArray"] as! [[AnyObject]]
                            
                            print("11111 \(arrayofshared)")
                            
                           // for listinarray in arrayofshared {
                            for var i = 0; i < arrayofshared.count; i++ {
                                if (arrayofshared[i][0] as! String == self.sendlistreceiverId) && (arrayofshared[i][4] as! String == self.sendlistid) {
                                
                                    arrayofshared[i][5] = true
                                /*
                                if (listinarray[0] as! String == self.sendlistreceiveremail) && (listinarray[3] as! String == self.sendlistid) {
                                    
                                    //change isReceived value in this subarray
                                    
                                    listinarray[4] = true
                                    //should have changed from let to var in else if list = list statement
                                    */
                                    break;
                                } else {
                                    print("Not that list")
                                }
                                
                            }
                            //save this array and send to parse
                            
                            print("22222 \(arrayofshared)")
                            
                            list["ShareWithArray"] = arrayofshared
                            
                            
                        
                            list.pinInBackgroundWithBlock({ (success, error) -> Void in
                                if success {
                                    print("Saved the info to local store!")
                                    
                                    
                                } else {
                                    print("Wasn't saved to local for some reason")
                                }
                            })
                            
                            list.saveEventually()
                            
                            
                        }
                    }
                    /////
                    
                    //self.displayAlert("Affirmative!", message: "User has successfully received your list!")
                    
                } else {
                 
                    print("NOPE")
                    //self.displayAlert("Haven't saved yet!", message: "User has not save your list yet!")
                    
                }
                
                
            self.restore()
            }
            }
            
            
        } else if ListsType[indexPathCheck!.row] == "ToDo" {
                
                
                pause()
                let queryrec = PFQuery(className:"toDoLists")
                queryrec.whereKey("listUUID", equalTo: sendlistid)
                queryrec.getFirstObjectInBackgroundWithBlock {
                    (receivedlist: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print("The getFirstObject request failed.")
                        self.restore()
                    } else if let receivedlist = receivedlist {
                        // The find succeeded.
                        print("Successfully retrieved the object.")
                        
                        if receivedlist["confirmReception"] as! Bool == true {
                            self.ListsArray[indexPathCheck!.row][5] = true
                            self.tableView.reloadData()
                            
                            
                            
                            ///// NOW UPDATE THIS LIST INGO
                            
                            let querythislist = PFQuery(className:"toDoLists")
                            querythislist.fromLocalDatastore()
                            querythislist.whereKey("listUUID", equalTo: self.ListsIds[indexPathCheck!.row])
                            querythislist.getFirstObjectInBackgroundWithBlock {
                                (list: PFObject?, error: NSError?) -> Void in
                                if error != nil {
                                    print("The getFirstObject request failed.")
                                    self.restore()
                                } else if let list = list {
                                    // The find succeeded.
                                    print("Successfully retrieved the object.")
                                    
                                    var arrayofshared : [[AnyObject]] = list["ShareWithArray"] as! [[AnyObject]]
                                    
                                    print("11111 \(arrayofshared)")
                                    
                                    // for listinarray in arrayofshared {
                                    for var i = 0; i < arrayofshared.count; i++ {
                                        if (arrayofshared[i][0] as! String == self.sendlistreceiverId) && (arrayofshared[i][4] as! String == self.sendlistid) {
                                            
                                            arrayofshared[i][5] = true
                                            /*
                                            if (listinarray[0] as! String == self.sendlistreceiveremail) && (listinarray[3] as! String == self.sendlistid) {
                                            
                                            //change isReceived value in this subarray
                                            
                                            listinarray[4] = true
                                            //should have changed from let to var in else if list = list statement
                                            */
                                            break;
                                        } else {
                                            print("Not that list")
                                        }
                                        
                                    }
                                    //save this array and send to parse
                                    
                                    print("22222 \(arrayofshared)")
                                    
                                    list["ShareWithArray"] = arrayofshared
                                    
                                    
                                    
                                    list.pinInBackgroundWithBlock({ (success, error) -> Void in
                                        if success {
                                            print("Saved the info to local store!")
                                            
                                            
                                        } else {
                                            print("Wasn't saved to local for some reason")
                                        }
                                    })
                                    
                                    list.saveEventually()
                                    
                                    
                                }
                            }
                            /////
                            
                            //self.displayAlert("Affirmative!", message: "User has successfully received your list!")
                            
                        } else {
                            
                            print("NOPE")
                           // self.displayAlert("Haven't saved yet!", message: "User has not save your list yet!")
                            
                        }
                        
                        
                        self.restore()
                    }
                }
                
                
        }
        
            
        } else {
            print("No internet")
            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("NoConnection", comment: ""))
        }
        //CHECK CONNECTION END

        
       
    }
    
    override func viewWillAppear(animated: Bool) {
       // dataretrieval()
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
        
        dataretrieval()
        
       // automaticcheck()
        
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

    
    
    override func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return ListsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sharinghistorycell", forIndexPath: indexPath) as! SharingHistoryCell

        // Configure the cell...
        
        //cell.issavedlabel.text = "Unknown"
        
        cell.listname.text = ListsNames[indexPath.row]//ListsArray[indexPath.row][]
        
        cell.listdate.text = ListsArray[indexPath.row][3] as? String
        
        cell.receivername.text = ListsArray[indexPath.row][1] as? String
        
        cell.receiveremail.text = ListsArray[indexPath.row][2] as? String
        
        //cell.checkifreceived.addTarget(self, action: "checkifreceived:", forControlEvents: .TouchUpInside)
        
        if ListsArray[indexPath.row][5] as! Bool == true {
            cell.issavedlabel.text = NSLocalizedString("accepted", comment: "")
            cell.iconimage.image = accepted
        } else {
            cell.issavedlabel.text = NSLocalizedString("notaccepted", comment: "")
            cell.iconimage.image = notaccepted
        }
        
        if ListsType[indexPath.row] == "Shop" {
            cell.listtype.image = shopicon
        } else {
            cell.listtype.image = todoicon
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
