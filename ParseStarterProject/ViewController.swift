//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import SystemConfiguration

var loggedIn = false


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //var notcheckedImage: UIImage = UIImage(named: "notchecked.png")!
    
    var ListsIds = [String]()
    var ListsNames = [String]()
    var ListsNotes = [String]()
    var shopimage: UIImage = UIImage()
    var ListsCreationDate = [NSDate]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var LoginButton: UIBarButtonItem!
    
    @IBOutlet weak var greetingslabel: UILabel!
    
    
    
    func listsretrievalfromcloud() {
        /*
        var query = PFQuery(className:"shopLists")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isReceived", equalTo: false)
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                /*
                self.ListsIds.removeAll(keepCapacity: true)
                self.ListsNames.removeAll(keepCapacity: true)
                self.ListsNotes.removeAll(keepCapacity: true)
                self.ListsCreationDate.removeAll(keepCapacity: true)
                
                */
                
                if let lists = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in lists {
                        
                        if self.contains(self.ListsIds, element: object.objectId!) {
                            println("List is already loaded from the local datastore")
                       
                        } else {
                            println(object.objectId)
                          //  self.ListsIds.append(object.objectId!)//["itemName"] as)
                            self.ListsIds.append(object["listUUID"] as! String)
                            self.ListsNames.append(object["ShopListName"] as! String)
                            
                            self.ListsCreationDate.append(object.updatedAt!)
                            /*
                            //new var
                            var dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            var date = object.createdAt
                            var strDate = dateFormatter.stringFromDate(date)
                            self.ListsCreationDate.append(strDate)
                            */
                            
                            
                            self.tableView.reloadData() // without this thing, table would contain only 1 row
                        }
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    */
    }

     func listsretrieval() {
        
       // if PFUser.currentUser() != nil {
            
            var query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        
      //  println(PFUser.currentUser()!.objectId!)
        
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isReceived", equalTo: false)
        query.orderByDescending("createdAt")

    query.findObjectsInBackgroundWithBlock {
    (objects: [AnyObject]?, error: NSError?) -> Void in
    
    if error == nil {
    
    print("Successfully retrieved \(objects!.count) scores.")
    // Do something with the found objects
    
    self.ListsIds.removeAll(keepCapacity: true)
    self.ListsNames.removeAll(keepCapacity: true)
    self.ListsNotes.removeAll(keepCapacity: true)
        self.ListsCreationDate.removeAll(keepCapacity: true)
    
    
    
    if let lists = objects as? [PFObject] {
    
    //shoppingListItemsIds.removeAll(keepCapacity: true)
    
    for object in lists {
    print(object.objectId)
    //self.ListsIds.append(object.objectId!)//["itemName"] as)
       self.ListsIds.append(object["listUUID"] as! String)
    self.ListsNames.append(object["ShopListName"] as! String)
        
    self.ListsCreationDate.append(object.updatedAt!)
        /*
        //new var
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = object.createdAt
        var strDate = dateFormatter.stringFromDate(date)
    self.ListsCreationDate.append(strDate)
        */
    
    
    self.tableView.reloadData() // without this thing, table would contain only 1 row
    }
    }
    } else {
    // Log details of the failure
    print("Error: \(error!) \(error!.userInfo)")
    }
    }
    //
           }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //println(PFUser.currentUser()!.objectId!)
        
        if (PFUser.currentUser() != nil) {
          //  listsretrieval()
            
            if CheckConnection.isConnectedToNetwork() {
                
                dispatch_async(dispatch_get_main_queue(), {
            self.listsretrievalfromcloud()
                })
            } else {
                print("No internet connection found")
            }
    } else {
            /*PFAnonymousUtils.logInWithBlock {
                (user: PFUser?, error: NSError?) -> Void in
                if error != nil || user == nil {
                    println("Anonymous login failed.")
                } else {
                    println("Anonymous user logged in.")
                }
            }*/
            loggedIn = false
            
                      print("No user yet")
        }
        
        
        if (PFUser.currentUser() != nil) {
            loggedIn = true
        } else {
            loggedIn = false
        }
        
        if loggedIn == false {
            PFAnonymousUtils.logInWithBlock {
                (user: PFUser?, error: NSError?) -> Void in
                if error != nil || user == nil {
                    print("Anonymous login failed.")
                } else {
                    print("Anonymous user logged in.")
                }
            }
        } else {
            print("the current user is \(PFUser.currentUser())")
        }
    }
    
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

    
    override func viewDidAppear(animated: Bool) {
        if loggedIn == false {
            //LoginButton.
           //greetingslabel.hidden = true
            greetingslabel.text = "You're not logged in. Some functionality is unavailable."
            
        } else {
            self.LoginButton = UIBarButtonItem(title: "test", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
            
            greetingslabel.hidden = false
            greetingslabel.text = "Logged in as \(PFUser.currentUser()!.username)"
            
        }
        /*
        if (PFUser.currentUser() != nil) {
            listsretrieval()
        } else {
            println("No user yet")
        }
*/
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "ListCreation" {
            //let destinationVC1 : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
            //THIS IS HOW IT IS DONE WHEN NAV CONTROLLER GOES FIRST
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let tableVC = navVC.viewControllers.first as! ShoppingListCreation
            
            tableVC.justCreatedList = true
            tableVC.isReceivedList = false
            
                            //destinationVC1.justCreatedList = true
            }
        
        //createtodolist
        
        if segue.identifier == "createtodolist" {
            //let destinationVC1 : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
            //THIS IS HOW IT IS DONE WHEN NAV CONTROLLER GOES FIRST
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let tabletodoVC = navVC.viewControllers.first as! ToDoListCreation
            
            tabletodoVC.justCreated = true
            tabletodoVC.isReceived = false
            
            //destinationVC1.justCreatedList = true
        }

        
        if segue.identifier == "OpenRecentList" {
            let destinationNavVC = segue.destinationViewController as! UINavigationController
            let destinationVC = destinationNavVC.viewControllers.first as! ShoppingListCreation
            // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
            
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                //destinationVC.activeList = ListsIds[indexPath.row]
                destinationVC.activeList = ListsIds[indexPath.row]
                destinationVC.justCreatedList = false
            }
            
        }
        
        
        }
    
    
 
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    return ListsIds.count
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let ItemCellIdentifier = "RecentListCell"
    let recentcell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! RecentListsCell
    
    //this is for getting image as a data
    //var newarray = [ListsNames[ListsNames.count - 1]; ListsNames[ListsNames.count - 2], ListsNames[ListsNames.count - 3], ListsNames[ListsNames.count - 4]]
    //newNames = Lists
    
    shopimage = UIImage(named: "ListSmall.png")!
    
    recentcell.iconImage.image = shopimage
    //recentcell.recentListName.text = newarray[indexPath.row]
    recentcell.recentListName.text = ListsNames[indexPath.row]
    
    //creation date
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let date = dateFormatter.stringFromDate(ListsCreationDate[indexPath.row] as NSDate)
    recentcell.creationdate.text = date
    print(ListsCreationDate[indexPath.row])

    /*
    if lastActive != nil {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
        let date = dateFormatter.stringFromDate(lastActive as NSDate)
    
*/
    /* Basically the same
    var dateFormatter = NSDateFormatter()
    
    myDateFormatter.dateFormat = "yyyy-MM-dd"
    
    self.date = gameScore["date"] as NSDate
    
    var strDate = myDateFormatter.stringFromDate(self.date)
    
    self.dateLabel.text = strDate
*/
    // Configure the cell...
    
    return recentcell
}



func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    let row = indexPath.row
    //println(self.shoppingListItemsIds[row])
}

}
