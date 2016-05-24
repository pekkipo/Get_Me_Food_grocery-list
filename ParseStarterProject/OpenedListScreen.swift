//
//  ShoppingListCreation.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 21/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var shoppingLists = [""]
//array of proudcts name in lists
var shoppingListItems = [""]

//var shoppingListItemsIds = [""]

class ShoppingListCreation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //var testarray = [String]()
    //@IBOutlet
    // var tableView: UITableView!
    
    @IBOutlet var tableView: UITableView! //TO DO THIS IS ALWAYS NECESSARY WHEN USING TABLEVIEW in VC
    
    @IBOutlet var ShopListNameOutlet: UITextField!
    
    @IBOutlet var ShopListNoteOutlet: UITextField!
    
    @IBAction func SaveListButton(sender: AnyObject) {
        
        
        var shopList = PFObject(className:"shopLists")
        shopList["ShopListName"] = ShopListNameOutlet.text
        shopList["ShopListNote"] = ShopListNoteOutlet.text
        shopList["ItemsInTheShopList"] = shoppingListItemsIds
        
        shopList.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
    
    //var shoppingListItemsIds = [""] //seems like the reason for one redundant cell, for this "" id!
    var shoppingListItemsIds = [String]()
    var shoppingListItemsNames = [String]()
    var shoppingListItemsNotes = [String]()
    var shoppingListItemsQuantity = [String]()
    var shoppingListItemsImages = [PFFile]()
    
    
    func dataretrieval(){
        
        
        var query = PFQuery(className:"shopItems")
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                self.shoppingListItemsIds.removeAll(keepCapacity: true)
                self.shoppingListItemsNames.removeAll(keepCapacity: true)
                self.shoppingListItemsNotes.removeAll(keepCapacity: true)
                self.shoppingListItemsQuantity.removeAll(keepCapacity: true)
                self.shoppingListItemsImages.removeAll(keepCapacity: true)
                
                
                if let listitems = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in listitems {
                        println(object.objectId)
                        self.shoppingListItemsIds.append(object.objectId!)//["itemName"] as)
                        self.shoppingListItemsNames.append(object["itemName"] as String)
                        self.shoppingListItemsNotes.append(object["itemNote"] as String)
                        self.shoppingListItemsQuantity.append(object["itemQuantity"] as String)
                        self.shoppingListItemsImages.append(object["itemImage"] as PFFile)
                        
                        self.tableView.reloadData() // without this thing, table would contain only 1 row
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }
    
    
    
    func addBarButtonTapped(){
        performSegueWithIdentifier("AddItemToTheList", sender: self)
        
        
        
    }
    
    @IBAction func NewItemButtonTapped(sender: AnyObject) {
        addBarButtonTapped()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped:")
        
        //var rightListsButtonItem: UIBarButtonItem = UIBarButtonItem(image: ListsIcon, style: UIBarButtonItemStyle.Plain, target: self, action: "ListsTapped:")
        var rightListsButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Lists", style: UIBarButtonItemStyle.Plain, target: self, action: "ListsTapped:")
        
        var rightSettingsButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "SettingsTapped:")
        
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightListsButtonItem, rightSettingsButtonItem], animated: true)
        
        
        //var query = PFUser.query()
        //query?.findObjectsInBackgroundWithBlock({)
        
        
        
        dataretrieval()
        
        println(self.shoppingListItemsIds)
        
    }
    
    
    
    func ListsTapped(sender:UIButton) {
        println("All lists pressed")
    }
    
    func SettingsTapped(sender:UIButton) {
        println("Settings pressed")
    }
    // 5
    func addTapped (sender:UIButton) {
        println("add pressed")
        // Do any additional setup after loading the view.
        
        addBarButtonTapped()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        //self.tableView.reloadData()
        
        //I do all this first - not to duplicate items, second - to add items after going back from add item screen
        
        //self.shoppingListItemsIds.removeAll(keepCapacity: true) - here it isn't necessary, necessary only within dataretrieval function
        dataretrieval()
        
        //self.tableView.reloadData()
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
        return shoppingListItemsIds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "NewListItem"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as ItemShopListCell
        
        //this is for getting image as a data
        shoppingListItemsImages[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            //we extract the image from parse and post them
            
            if let downloadedImage = UIImage(data: data!) {
                
                cell.itemImage.image = downloadedImage
                
            }
            
        }
        
        
        cell.itemName.text = shoppingListItemsNames[indexPath.row]
        cell.itemNote.text = shoppingListItemsNotes[indexPath.row]
        cell.itemQuantity.text = shoppingListItemsQuantity[indexPath.row]
        
        //cell.itemName.text = self.testarray[indexPath.row]
        
        //self.tableView.reloadData()
        
        // Configure the cell...
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(self.shoppingListItemsIds[row])
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
