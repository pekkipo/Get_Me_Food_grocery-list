//
//  ToDoListCreation.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 31/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation

var toDoItems = [toDoItem]()

protocol passtodoListtoMenuDelegate
{
    func gettodolistparameters(isFrom:Bool,listid:String,isreceived:Bool)
}


class ToDoListCreation: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshToDoListDelegate, UITextFieldDelegate, OptionsPopupDelegate, takepicturedelegate, UITextViewDelegate, UIGestureRecognizerDelegate {
    
    
    // New stuff
    
    var isediting : Bool = false
    
    
    @IBOutlet var additemfield: CustomTextField!
    
    @IBAction func beginedit(sender: AnyObject) {
        
        if !isediting {
        
        additemfield.text = ""
        
        additemfield.placeholder = NSLocalizedString("todoplchldr", comment: "")
            
        addbuttonoutlet.hidden = false
        
        addpulse()
            
            isediting = true
            
        }
        
    }
    
    @IBOutlet var addbuttonoutlet: UIButton!
    
    @IBAction func additem(sender: AnyObject) {
        
        quickadditem(currenttodolist)
    }
    
    @IBOutlet var openmenu: UIBarButtonItem!
    
    
    @IBAction func openmenuaction(sender: AnyObject) {
    }
    
    @IBOutlet var showsettings: UIBarButtonItem!
    
    @IBAction func showsettingsaction(sender: AnyObject) {
        
        clickthetitle()
    }
    
    func createpicture() {
        // generateImage(tableView)
        if toDoItems.count != 0 {
            messageimage = tableView.screenshot!
        }
    }
    
    func savetogallery() {
        if toDoItems.count != 0 {
            messageimage = tableView.screenshot!
        }
    }
    
    
    
    func changecolor(code: String) {
        
        colorcode = code
        
    }
    
    
    func popshowcategories(show: Bool) {
        //
    }
    
    func uncheckall() {
        //
    }
    
    func changecodeandsymbol(newcode: String, newsymbol: String) {
        //
    }
    
    
     var transitionOperator = TransitionOperator()
    
    var delegatefortodolist : passtodoListtoMenuDelegate?
    var senderVC : UIViewController?
    

    //performSegueWithIdentifier("createtodoitem", sender: self)
    
    func refreshtodotable() {
        //tableView.reloadData()
        
        
        if justCreated == true {
            
            
            activelist = currenttodolist
            if currenttodolist != "" {

                countitems()
                countchecked()


                tableView.reloadData()
                
            } else {
                
            }
            
        } else {

            countitems()
            countchecked()

          
            tableView.reloadData()
        }
        
    }
    
    var currenttodolist = String()
    
    var activelist = String()
    
    //var justCreated = Bool()
    var justCreated = true
    
    var isReceived = Bool()
    


    var itemtocheck = String()
    
    var itemtodelete = String()
    
    var itemtoedit = String()
    
    ////items part
    var itemsnames = [String]()
    
    var itemsquantity = Int()
    var checkeditemsquantity = Int()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    ///////// COLOR CODER PART
    var colorcode = String()
    
    var red:String = "F23D55"
    var dgreen:String = "31797D"
    var gold:String = "A2AF36"
    var black:String = "2A2F36"
    var grey:String = "838383"
    var magenta:String = "1EB2BB"
    var lgreen:String = "61C791"
    var lightmagenta: String = "7FC2C6"
    var pink: String = "E88996"
    var orange: String = "E18C16"
    var violet:String = "7D3169"
    var darkred:String = "713D3D"
    
    
    /////////////
    
    override func viewWillDisappear(animated: Bool) {
        
        additemstoarrayandsave()
    }
    
    
    func additemstoarrayandsave() {
    
    for item in toDoItems {
    idsinthislist.append(item.itemid)
    }
    
        let updatedate = NSDate()
        
        let query = PFQuery(className:"toDoLists")
        query.fromLocalDatastore()
        
        query.whereKey("listUUID", equalTo: currenttodolist)
        query.getFirstObjectInBackgroundWithBlock() {
            
            (todolist: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let todolist = todolist {
                
                todolist["ToDoListName"] = self.listname.text
                todolist["ToDoListNote"] = self.listnote.text
                //todoist["isFavourite"] = false
                if self.isReceived == false {
                    todolist["isReceived"] = false
                } else {
                    todolist["isReceived"] = true
                }
                
                if self.isReceived == false {
                    todolist["isSaved"] = false
                } else {
                    todolist["isSaved"] = true
                }
                
                
                
                
               
                
                print("ARRAY IS \(self.idsinthislist)")
                
                todolist["ItemsInTheToDoList"] = self.idsinthislist
                
                todolist["ItemsCount"] = self.itemsquantity
                todolist["CheckedItemsCount"] = self.checkeditemsquantity
                
                todolist["updateDate"] = updatedate
                
                todolist["ListColorCode"] = self.colorcode

                todolist.pinInBackground()

            }
        }
        

        
        if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            UserLists[foundlist].listname = listname.text
            UserLists[foundlist].listnote = listnote.text
            
            UserLists[foundlist].listitemscount = itemsquantity
            UserLists[foundlist].listcheckeditemscount = checkeditemsquantity

            UserLists[foundlist].listcolorcode = self.colorcode
            
        }

        if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            
            
            UserToDoLists[foundtodolist].listname = listname.text
            UserToDoLists[foundtodolist].listnote = listnote.text
            UserToDoLists[foundtodolist].listitemscount = itemsquantity
            UserToDoLists[foundtodolist].listcheckeditemscount = checkeditemsquantity
          //  UserToDoLists[foundtodolist].listcreationdate = updatedate
            UserToDoLists[foundtodolist].listcolorcode = self.colorcode
            
        }
        
        if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            
            
            UserFavLists[foundfavlist].listname = listname.text
            UserFavLists[foundfavlist].listnote = listnote.text
            UserFavLists[foundfavlist].listitemscount = itemsquantity
            UserFavLists[foundfavlist].listcheckeditemscount = checkeditemsquantity
            UserFavLists[foundfavlist].listcolorcode = self.colorcode
            
        }
        

    
    }
    
    
    

    
    var idsinthislist = [String]()
    
    func additemstoarray() -> [String]{

            
            for item in toDoItems {
                idsinthislist.append(item.itemid)
            }

        
        return idsinthislist
        
        }
    
    
    
    @IBAction func nameendedit(sender: AnyObject) {
        
        
        let query = PFQuery(className:"toDoLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: currenttodolist)
        query.getFirstObjectInBackgroundWithBlock() {
            (todolist: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let todolist = todolist {
                
                todolist["ToDoListName"] = self.listname.text
                todolist.pinInBackground()
                //todolist.saveEventually()
                
                if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.currenttodolist) {
                    UserLists[foundlist].listname = self.listname.text
                    
                }
                
                if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(self.currenttodolist) {
                    
                    
                    UserToDoLists[foundtodolist].listname = self.listname.text
                    
                    
                }
                
                if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.currenttodolist) {
                    
                    
                    UserFavLists[foundfavlist].listname = self.listname.text
                    
                    
                }
                
                self.view.endEditing(true)
            }
        }
        
     
        
         self.navigationItem.title = self.listname.text
        
    }

    func textViewDidEndEditing(textView: UITextView) {
     
        if textView != quickitemnote {
            let query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            query.whereKey("listUUID", equalTo: currenttodolist)
            query.getFirstObjectInBackgroundWithBlock() {
                (todolist: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let todolist = todolist {
                    
                    todolist["ToDoListNote"] = self.listnote.text
                    todolist.pinInBackground()
                    
                    if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.currenttodolist) {
                        UserLists[foundlist].listnote = self.listname.text
                        
                    }
                    
                    if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(self.currenttodolist) {
                        
                        
                        UserToDoLists[foundtodolist].listnote = self.listname.text
                        
                        
                    }
                    
                    if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.currenttodolist) {
                        
                        
                        UserFavLists[foundfavlist].listnote = self.listname.text
                        
                        
                    }
                    
                    self.view.endEditing(true)
                    
                }
            }
            
        }
    }
    
    @IBAction func didendeditnote(sender: AnyObject) {
        
        let query = PFQuery(className:"toDoLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: currenttodolist)
        query.getFirstObjectInBackgroundWithBlock() {
            (todolist: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let todolist = todolist {
                
                todolist["ToDoListNote"] = self.listnote.text
                todolist.pinInBackground()

            }
        }
        
        
        
    }
    
    
    
    func itemsretrieval(list:String) {
        
        var query = PFQuery(className:"toDoItems")
        query.fromLocalDatastore()
        query.orderByDescending("creationDate")
        query.whereKey("ItemsList", equalTo: list)//currenttodolist)
        //query.limit = 1
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                if let listitems = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in listitems {
                        
                        var id = object["itemUUID"] as! String
                        var name = object["todoitemname"] as! String
                        var note = object["todoitemnote"] as! String
                        var important = object["isImportant"] as! Bool
                        var check = object["isChecked"] as! Bool
                        
                        var todoitem: toDoItem = toDoItem(itemid:id,itemname:name,itemnote:note,itemimportant:important, ischecked: check)
                        
                        print(toDoItems)
                        
                        toDoItems.append(todoitem)
                        
                        print(toDoItems)
                        
                        // self.tableView.reloadData()
                        
                    }
                    

                    self.countitems()
                    self.countchecked()
                   

                    self.tableView.reloadData()
                }
                
                
                
                print(toDoItems)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        // NOW NEW QUERY TO GET LIST NAME AND NOTE BY DEFAULT
        var queryListInfo = PFQuery(className:"toDoLists")
        queryListInfo.fromLocalDatastore()
        //queryListInfo.whereKey("objectId", equalTo: activeList!)
        queryListInfo.whereKey("listUUID", equalTo: list)
        queryListInfo.limit = 1
        queryListInfo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let list = objects as? [PFObject] {
                    
                    for object in list {
                        
                        self.listname.text = object["ToDoListName"] as! String
                        self.listnote.text = object["ToDoListNote"] as! String
                        
                        self.navigationItem.title = object["ToDoListName"] as! String
                        
                        //need to know if its received
                        self.isReceived = object["isReceived"] as! Bool
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    
    func newPFObject() {
        
        let uuid = NSUUID().UUIDString
        let listuuid = "todolist\(uuid)"
        
        let toDoListNew = PFObject(className:"toDoLists")
        
        
        toDoListNew["listUUID"] = listuuid
        
        toDoListNew["ToDoListName"] = listname.text
        toDoListNew["ToDoListNote"] = listnote.text
        //for user stuff
        toDoListNew["BelongsToUser"] = PFUser.currentUser()!.objectId!
        // shopListNew["BelongsToUsers"] = [PFUser.currentUser()!.objectId!]
        toDoListNew["isReceived"] = false
        toDoListNew["isFavourite"] = false
        toDoListNew["ShareWithArray"] = []
        toDoListNew["SentFromArray"] = ["",""]
        toDoListNew["ItemsInTheToDoList"] = []
        toDoListNew["isSaved"] = false
        
        toDoListNew["isDeleted"] = false
        toDoListNew["confirmReception"] = false
        toDoListNew["isShared"] = false
        
        let creationdate = NSDate()
        
        toDoListNew["CreationDate"] = creationdate
        toDoListNew["updateDate"] = creationdate
        
        toDoListNew["ServerUpdateDate"] = creationdate.dateByAddingTimeInterval(-120)
        
        toDoListNew["ItemsCount"] = 0
        toDoListNew["CheckedItemsCount"] = 0
        
        toDoListNew["ListColorCode"] = "31797D"
        
        self.currenttodolist = listuuid
        
        
        
        
        //// NOW ADD TO ARRAY
        let listid = listuuid
        let todolistname = listname.text!
        let todolistnote = listnote.text!
        let listcreationdate = creationdate
        let listisfav = false
        let listisreceived = false
        let listbelongsto = PFUser.currentUser()!.objectId!
        let listissentfrom = ["",""]
        let listissaved = false
        
        let listconfirm = false
        let listisdeleted = false
        let listisshared = false
        let listsharewitharray = []
        
        let listitemscount = 0
        let listcheckeditems = 0
        let listtype = "ToDo"
        let listscolor = "31797D"

        
        
        let todolist : UserList = UserList(
            listid:listid,
            listname:todolistname,
            listnote:todolistnote,
            listcreationdate:listcreationdate,
            listisfavourite:listisfav,
            listisreceived:listisreceived,
            listbelongsto:listbelongsto,
            listreceivedfrom:listissentfrom,
            listissaved:listissaved,
            listconfirmreception:listconfirm,
            listisdeleted:listisdeleted,
            listisshared:listisshared,
            listsharedwith:listsharewitharray as! [[AnyObject]],
            listitemscount:listitemscount,
            listcheckeditemscount:listcheckeditems,
            listtype:listtype,
            listcolorcode:listscolor
            
        )
        
        print("Before \(UserLists.count)")
        print("Before todo \(UserToDoLists.count)")
        
        UserToDoLists.append(todolist)
        UserLists.append(todolist)
        
        print("After \(UserLists.count)")
        print("After todo \(UserToDoLists.count)")

        
        //shopList["ItemsInTheShopList"] = shoppingListItemsIds
        toDoListNew.pinInBackground()

        
        itemsquantity = 0
        checkeditemsquantity = 0

        
    }
    
    func edititem(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ToDoListCell
        let indexPathItem = tableView.indexPathForCell(cell)

        itemtoedit = toDoItems[indexPathItem!.row].itemid

        performSegueWithIdentifier("edittodoitem", sender: self)
    }
    
    
    func restoreitem(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let nextview = view.superview!
        let cell = nextview.superview as! ToDoListCell
        let indexPathCheck = tableView.indexPathForCell(cell)

        itemtocheck = toDoItems[indexPathCheck!.row].itemid
        
        toDoItems[indexPathCheck!.row].ischecked = false

        
        cell.checkview.hidden = true
        
        
        let attributes = [NSStrikethroughStyleAttributeName : 0]
        let title = NSAttributedString(string: toDoItems[indexPathCheck!.row].itemname, attributes: attributes)
        
        cell.itemname.attributedText = title
        
        
        let querynew = PFQuery(className:"toDoItems")
        querynew.fromLocalDatastore()
        querynew.whereKey("itemUUID", equalTo: itemtocheck)
        querynew.getFirstObjectInBackgroundWithBlock() {
            (itemList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let itemList = itemList {
                itemList["isChecked"] = false
                itemList.pinInBackground()
               // itemList.saveEventually()
                
            }
            
            
        }

        checkeditemsquantity -= 1


    }
    
    func checkitem(indexPath: NSIndexPath) {
    
     

        itemtocheck = toDoItems[indexPath.row].itemid
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToDoListCell

       // if toDoItems[indexPath.row].ischecked == false {

            
              toDoItems[indexPath.row].ischecked = true
            
            cell.checkview.frame = cell.bounds
            
            cell.checkview.hidden = false
            
            let attributes = [NSStrikethroughStyleAttributeName : 1]

            let title = NSAttributedString(string: toDoItems[indexPath.row].itemname, attributes: attributes)
            cell.itemname.attributedText = title
            
            let querynew = PFQuery(className:"toDoItems")
            querynew.fromLocalDatastore()
            querynew.whereKey("itemUUID", equalTo: itemtocheck)
            querynew.getFirstObjectInBackgroundWithBlock() {
                (itemList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let itemList = itemList {
                    itemList["isChecked"] = true
                    itemList.pinInBackground()
                   // itemList.saveEventually()
                    
                }
                
                
            }
            
            //toDoItems[indexPathCheck!.row].ischecked = true

            
            checkeditemsquantity += 1

            
       // } else {
          
       // }

        
        
    }
    
    
    func countchecked() -> Int {
        
        var quantityofchecked = [Bool]()
        
        for item in toDoItems {
            if item.ischecked == true {
                quantityofchecked.append(item.ischecked)
               // checkeditems += 1
            } else {
                print("Not checked")
            }
        }

        checkeditemsquantity = quantityofchecked.count

        return checkeditemsquantity

    }
    

    
    func countitems() -> Int {
        //itemsoverallqty = shoppingListItemsIds.count
        itemsquantity = toDoItems.count
        return itemsquantity
    }

    
    
    override func viewWillAppear(animated: Bool) {
        
        
        if justCreated == true {
            
           
            activelist = currenttodolist
            if currenttodolist != "" {


                countitems()
                countchecked()


                tableView.reloadData()

            } else {
                print("WHERE THE FUCK IS THIS VARIABLE?!")
            }

        } else {

            countitems()
            countchecked()


        tableView.reloadData()
        }
    }
    

    
    func addButtonTapped(sender:UIButton) {
         performSegueWithIdentifier("addtodoitemsegue", sender: self)
    }
    
    func ListsTapped(sender:UIButton) {
        //performSegueWithIdentifier("addtodoitemsegue", sender: self)
        print("Lists")
    }
    
    func SettingsTapped(sender:UIButton) {
        //performSegueWithIdentifier("addtodoitemsegue", sender: self)
        print("Lists")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        
        if segue.identifier == "settingsfortodo" {
            
            let popoverViewController = segue.destinationViewController as! ListOptionsPopover
            
            popoverViewController.delegate = self //
            
            
            popoverViewController.colorcode = colorcode
            
            popoverViewController.senderVC = "ToDoList"
            
            popoverViewController.listtype = "ToDo"
            
            popoverViewController.listtoupdate = currenttodolist
            
        }

        
        if segue.identifier == "addtodoitemsegue" {
            let navVC = segue.destinationViewController as! UINavigationController
            
            let additemVC = navVC.viewControllers.first as! AddToDoItemViewController
            
            //additemVC.currentitem = //currentList
            additemVC.currentlist = currenttodolist
            
            additemVC.existingitem = false
            
            
        }
        
        if segue.identifier == "ShareFromToDoCreation" {//"ShareFromToDo" {
        let shareVC = segue.destinationViewController as! SharingViewController
        
        //additemstoarrayandsave()
        
        shareVC.listToShare = currenttodolist
        shareVC.listToShareType = "ToDo"
        shareVC.delegate = self
        shareVC.senderVC = "ToDoCreationVC"
            
        }

        
         if segue.identifier == "createtodoitem" {
        
      
        
        
        let toViewController = segue.destinationViewController as! AddToDoItemViewController

        toViewController.tododelegate = self // NEED THIS FOR REFRESHING FUNCTION!

        toViewController.currentlist = currenttodolist
        toViewController.existingitem = false
        }
        
        if segue.identifier == "edittodoitem" {
            
           
            
            
            let toViewController = segue.destinationViewController as! AddToDoItemViewController

            toViewController.tododelegate = self // NEED THIS FOR REFRESHING FUNCTION!
            toViewController.existingitem = true
            toViewController.currentlist = currenttodolist
            toViewController.currentitem = itemtoedit
            
            
        }
        
        
         if segue.identifier == "optionsfromtodo" {
        
        let toViewController = segue.destinationViewController as! ToDoListCreation
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
            
            
            let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            
            let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController

            
            
                   toViewController.transitioningDelegate = mainmenu.transitionOperator
            //self.transitionOperator
        
        //toViewController.maindelegate = self
            
        }
        
        if segue.identifier == "showreminderfromtodo" {
            
            let popoverViewController = segue.destinationViewController as! ReminderPopover
            
             popoverViewController.modalPresentationStyle = .OverCurrentContext
            
            popoverViewController.todocaption = additemfield.text!
            popoverViewController.senderVC = "ToDoItem"
            
        }
        
        

    }

    func swipedeleteitem(deleterow: NSIndexPath) {
        
        
        
        
        itemtodelete = toDoItems[deleterow.row].itemid

        toDoItems.removeAtIndex(deleterow.row)
        
        
        dispatch_async(dispatch_get_main_queue(), {
            let querynew = PFQuery(className:"toDoItems")
            //querynew.fromLocalDatastore()
            //querynew.getObjectInBackgroundWithId(self.itemtodelete!) {
            querynew.whereKey("itemUUID", equalTo: self.itemtodelete)
            querynew.getFirstObjectInBackgroundWithBlock() {
                (itemList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let itemList = itemList {
                    
                    
                    itemList.deleteInBackground()
                    
                }

                
            }
        })
        
        let querynew1 = PFQuery(className:"toDoItems")
        querynew1.fromLocalDatastore()
        //  querynew1.getObjectInBackgroundWithId(itemtodelete!) {
        querynew1.whereKey("itemUUID", equalTo: itemtodelete)
        querynew1.getFirstObjectInBackgroundWithBlock() {
            (itemList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let itemList = itemList {
                
                itemList.unpinInBackground()
                
                
            }

        }
        
        
        // remove the deleted item from the `UITableView`
        self.tableView.deleteRowsAtIndexPaths([deleterow], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.reloadData()

        countitems()
        countchecked()

        
    }
    
    
    @IBAction func unwindToCreationOfToDoList(sender: UIStoryboardSegue){

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
    
   
    
    func containslistid(values: [String], element: String) -> Bool {
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
    
    func containseventid(values: [String], element: String) -> Bool {
        
        for value in values {
            
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    
    
    func reloadTableAfterPush() {
        
        
        // let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        // dispatch_async(dispatch_get_global_queue(priority, 0)) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            // checkreceivedlists
            var receivedcount : Int = 0
            
            //CHECK SHOP LISTS
            var query = PFQuery(className:"shopLists")
            query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("isReceived", equalTo: true)
            query.whereKey("isSaved", equalTo: false)
            query.whereKey("isDeleted", equalTo: false)
            query.whereKey("confirmReception", equalTo: false)
            query.orderByDescending("updateDate")
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    print("Successfully retrieved \(objects!.count) scores.")
                    
                    
                    if let lists = objects as? [PFObject] {
                        
                        for object in lists {
                            print(object.objectId)
                            if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserShopLists.map({ $0.listid }), element: object["listUUID"] as! String){
                                
                                print("object is already retrieved from local datastore")
                            } else {
                                
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
                                var listcurrency = object["ListCurrency"] as! String
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
                                
                                UserShopLists.append(receivedshoplist)
                                
                                //UserLists.extend(UserShopLists)
                                UserLists.append(receivedshoplist)
           
                                
                                receivedcount += 1
                                
                            }
                            
                            //receivedcount += 1
                            
                            //object.pinInBackground()
                            //I think I do it later when saving
                        }
                        
                        //self.tableView.reloadData()
                        
                    }
                } else {
                    // Log details of the failure
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
            querytodo.orderByDescending("updateDate")
            querytodo.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    print("Successfully retrieved \(objects!.count) scores.")
                    
                    
                    if let lists = objects as? [PFObject] {
                        
                        for object in lists {
                            print(object.objectId)
                            
                            if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserToDoLists.map({ $0.listid }), element: object["listUUID"] as! String){
                                
                                print("object is already retrieved from local datastore")
                            } else {
                                
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
                                
                                
                                // self.tableView.reloadData() // without this thing, table would contain only 1 row
                                
                                receivedcount += 1
                                
                            }
                        }
                        
                        // self.tableView.reloadData()
                        
                        if receivedcount != 0 {
                            
                            // self.displayAlert("Incoming lists!", message: "You have received \(String(receivedcount)) lists")
                            
                            //JSSAlertView().show(self, title: "You have received \(String(receivedcount)) lists")
                        }
                        //self.displayAlert("Incoming lists!", message: "You have received lists")
                        
                        
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
            
            
            
            // checkreceivedevents
            var queryevents = PFQuery(className:"UsersEvents")
            
            queryevents.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
            queryevents.whereKey("isReceived", equalTo: false)
            queryevents.findObjectsInBackgroundWithBlock {
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
                                        senderimage = UIImage(named: "checkeduser.png")!
                                    }
                                } else {
                                    senderimage = UIImage(named: "checkeduser.png")!
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
                        
                        
                        
                    }
                    
                    //self.addcustomstocatalogitems(customcatalogitems)
                    
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }) // end of dispatch
    }


    
    
    func didSwipeCell(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Ended {
            let swipeLocation = recognizer.locationInView(self.tableView)
            if let swipedIndexPath = tableView.indexPathForRowAtPoint(swipeLocation) {
                if let swipedCell = self.tableView.cellForRowAtIndexPath(swipedIndexPath) {
                    
                    ////// DO STUFF
                    
                 
                    var cell = swipedCell as! ToDoListCell
                    var indexPathCheck = swipedIndexPath
                    
                    
                    itemtocheck = toDoItems[indexPathCheck.row].itemid
                    
                    
                    if toDoItems[indexPathCheck.row].ischecked == false {
                        
                       // cell.checkitem.setImage(checkedImage, forState: .Normal)
                        
                        toDoItems[indexPathCheck.row].ischecked = true
                        
                        cell.checkview.frame = cell.bounds
                        
                        cell.checkview.hidden = false
                        
                        let attributes = [NSStrikethroughStyleAttributeName : 1]
                        // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
                        let title = NSAttributedString(string: toDoItems[indexPathCheck.row].itemname, attributes: attributes)
                        cell.itemname.attributedText = title
                        
                        let querynew = PFQuery(className:"toDoItems")
                        querynew.fromLocalDatastore()
                        querynew.whereKey("itemUUID", equalTo: itemtocheck)
                        querynew.getFirstObjectInBackgroundWithBlock() {
                            (itemList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let itemList = itemList {
                                itemList["isChecked"] = true
                                itemList.pinInBackground()
                                // itemList.saveEventually()
                                
                            }
                            
                            
                        }
                        
                        checkeditemsquantity += 1

                        
                    } else {
                        
           
                    }
                    
                    
                    
                    ////
                    
                }
            }
        }
    }

    
    var closepadimage = UIImage(named: "ClosePad")!
    var editproductimage = UIImage(named:"4EditProduct20")!
    var addproductimage = UIImage(named:"4AddProduct20")!
    
    
    func addproductfromkeyboard(sender: UIButton) {


        quickadditem(currenttodolist)

    }
    
    func editproductfromkeyboard(sender: UIButton) {
        self.view.endEditing(true)
        
        showproperties()
 
        
    }
    
    func showproperties() {
        
        smallpopover.hidden = false
        dimmerforpopover.hidden = false
        
        
        addpulse()
        
    }
 
    func addpulse() {
        
        var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
        pulseAnimation.duration = 1.0;
        pulseAnimation.fromValue = NSNumber(float: 0.9)
        pulseAnimation.toValue = NSNumber(float: 1.0);
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;
        addbuttonoutlet.layer.addAnimation(pulseAnimation, forKey: nil)
    }
    
    @IBOutlet var smallpopover: UIView!
    @IBOutlet var dimmerforpopover: UIView!
    
   
    @IBAction func cancelinpopover(sender: AnyObject) {
        
        hideproperties()
        
        self.quickitemnote.text = ""
        self.additemfield.text = NSLocalizedString("addtodoitemtext", comment: "")
        
        self.priorityswitcher.on = false
        
        isediting = false
        
        addbuttonoutlet.hidden = true
        
    }
    
    @IBAction func doneinpopover(sender: AnyObject) {
        
        quickadditem(currenttodolist)
    }
    
    func hideproperties() {

        self.view.endEditing(true)
        smallpopover.hidden = true
        dimmerforpopover.hidden = true

        addbuttonoutlet.layer.removeAllAnimations()
    }
    
    
    @IBOutlet var quickitemnote: UITextView!
    
    @IBOutlet var priorityswitcher: UISwitch!
    
    func quickadditem(list: String) {
        
        let todoitem = PFObject(className:"toDoItems")
        let uuid = NSUUID().UUIDString
        let itemuuid = "todoitem\(uuid)"
        
        todoitem["itemUUID"] = itemuuid
        todoitem["todoitemname"] = additemfield.text
        todoitem["todoitemnote"] = quickitemnote.text
        
        if priorityswitcher.on {
            todoitem["isImportant"] = true
        } else {
            todoitem["isImportant"] = false
        }
        
        let date = NSDate()
        
        todoitem["creationDate"] = date
        todoitem["updateDate"] = date
        
        todoitem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        todoitem["BelongsToUser"] = PFUser.currentUser()!.objectId!
        todoitem["ItemsList"] = list//currentlist
        
        todoitem["isChecked"] = false
        
        todoitem["isDeleted"] = false
        
        //create new object
        let id = itemuuid
        let name = additemfield.text
        let note = quickitemnote.text
        var importance = Bool()
        
        if priorityswitcher.on {
            importance = true
        } else {
            importance = false
        }
        let check = false
        
        //page 87 of Pro Design Patterns
        
        let newtodoitem: toDoItem = toDoItem(itemid:id,itemname:name!,itemnote:note,itemimportant:importance, ischecked:check)
        
        toDoItems.append(newtodoitem)
        
        
        tableView.reloadData()
        
        todoitem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                
                print("saved item")
                
            } else {
                print("no id found")
            }
        })
        
        
        hideproperties()
        
        self.quickitemnote.text = ""
        self.additemfield.text = NSLocalizedString("addtodoitemtext", comment: "")
        
        self.priorityswitcher.on = false
        
        isediting = false
        
        addbuttonoutlet.hidden = true
        

        
    }
    
    
    @IBOutlet var listname: UITextField!
    
    @IBOutlet var listnote: UITextView!
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    @IBAction func opensettings(sender: AnyObject) {
        
        performSegueWithIdentifier("settingsfortodo", sender: self)
        
    }
    
    @IBAction func sendthelist(sender: AnyObject) {
        
         performSegueWithIdentifier("ShareFromToDoCreation", sender: self)
        
    }
    
    @IBAction func closepopover(sender: AnyObject) {
        
        dimmer.removeFromSuperview()
        
        settingsconstraint.constant = -500
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.settingsview.hidden = true
                self.settingsopen = false
        })
        
        self.view.endEditing(true)
        
        
        
        

        
    }
    
    
    var settingsopen : Bool = false
    
    
    @IBOutlet var settingsconstraint: NSLayoutConstraint!
    
    // func clickthetitle(button: UIButton) {
    func clickthetitle() {
        
        if !settingsopen {
            

            showsettingsfunc()
            settingsopen = true
            
        } else if settingsopen {

            closesets()
            settingsopen = false
            
        }
        
        
    }
    
    let dimmer : UIView = UIView()
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//(1.0)
        )
    }
    
    
    func handlebvTap(sender: UITapGestureRecognizer? = nil) {
        
        dimmer.removeFromSuperview()
        
        settingsconstraint.constant = -500
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.settingsview.hidden = true
                self.settingsopen = false
        })
        
        self.view.endEditing(true)
        
        
        

        
    }
    
    
    func showsettingsfunc() {
        
        view.endEditing(true)
        
        // slidedown
        settingsview.hidden = false
        
        dimmer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dimmer.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 0.3)
        
        
        let blurredtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        blurredtap.delegate = self
        dimmer.userInteractionEnabled = true
        dimmer.addGestureRecognizer(blurredtap)
        
        self.view.addSubview(dimmer)
        
        settingsconstraint.constant = 0
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        self.view.bringSubviewToFront(settingsview)
        
    }

    
    func closesets() {
        
        dimmer.removeFromSuperview()
        
        
        settingsconstraint.constant = -500

        view.endEditing(true)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.settingsview.hidden = true
        })
        
        //self.shownoteview.hidden = true
    }
    
    
    @IBOutlet var settingsview: UIView!
    
    @IBOutlet var popovertopconstraint: NSLayoutConstraint! //0 or -500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        smallpopover.hidden = true
        
        addbuttonoutlet.hidden = true
        
        additemfield.delegate = self
        
        additemfield.leftTextMargin = 5
        
        additemfield.text = NSLocalizedString("addtodoitemtext", comment: "")
        
        tableView.tableFooterView = UIView()
        
        openmenu.target = self.revealViewController()
        openmenu.action = Selector("revealToggle:")
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableAfterPush", name: "reloadTableToDo", object: nil)

        
        let toolFrame = CGRectMake(0, 0, self.view.frame.size.width, 46); // x y w h
        let toolView: UIView = UIView(frame: toolFrame);
        toolView.backgroundColor = UIColorFromRGB(0xFAFAFA)
        let linetop : UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 1))
        linetop.backgroundColor = UIColorFromRGB(0xE0E0E0)
        let linebottom : UIView = UIView(frame: CGRectMake(0, 45, self.view.frame.size.width, 1))
        linebottom.backgroundColor = UIColorFromRGB(0x31797D)
        let closepadframe3: CGRect = CGRectMake(0, 0, self.view.frame.size.width / 2, 46)
        let closepadframe4: CGRect = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 46)
        let editproduct: UIButton = UIButton(frame: closepadframe3);
        let addproduct: UIButton = UIButton(frame: closepadframe4);
        editproduct.setTitle(NSLocalizedString("qeditproduct", comment: ""), forState: UIControlState.Normal)
        addproduct.setTitle(NSLocalizedString("qaddproduct", comment: ""), forState: UIControlState.Normal)
        editproduct.tintColor = UIColorFromRGB(0x1695A3)
        addproduct.tintColor = UIColorFromRGB(0x31797D)
        editproduct.setImage(editproductimage, forState: UIControlState.Normal)
        addproduct.setImage(addproductimage, forState: UIControlState.Normal)
        editproduct.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 12)
        addproduct.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 12)
        editproduct.setTitleColor(UIColorFromRGB(0x1695A3), forState: .Normal)
        editproduct.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        editproduct.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 10);
        addproduct.setTitleColor(UIColorFromRGB(0x31797D), forState: .Normal)
        addproduct.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        addproduct.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 10);
        toolView.addSubview(editproduct);
        toolView.addSubview(addproduct);
        toolView.addSubview(linetop);
        editproduct.addTarget(self, action: "editproductfromkeyboard:", forControlEvents: UIControlEvents.TouchDown);
        addproduct.addTarget(self, action: "addproductfromkeyboard:", forControlEvents: UIControlEvents.TouchDown);
        
        additemfield.inputAccessoryView = toolView
        
        
        
        
        
        
        
        listname.delegate = self
        
        listnote.delegate = self
        
       // var swipecell = UISwipeGestureRecognizer(target: self, action: "didSwipeCell:")
       // swipecell.direction = .Right
       // self.tableView.addGestureRecognizer(swipecell)



        
        if justCreated == true {
            
            
            
            self.listnote.text = ""
            
            self.listname.text = "\(NSLocalizedString("listtodo", comment: ""))"

            self.navigationItem.title = "\(NSLocalizedString("listtodo", comment: ""))"
            colorcode = magenta
            
            newPFObject()
            
            
            
        } else {
            currenttodolist = activelist
            
            
            itemsretrieval(activelist)
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(activelist) {
            if (UserLists[foundlist].listcolorcode != nil) {
                colorcode = UserLists[foundlist].listcolorcode!
                
            } else {
                colorcode = magenta
            }
            }
            
           
            
            tableView.reloadData()

        }

        countitems()
        countchecked()


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
        return toDoItems.count
    }
    
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            

    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        /*
        if toDoItems[indexPath.row].ischecked == false {
        
        itemtoedit = toDoItems[indexPath.row].itemid

        performSegueWithIdentifier("edittodoitem", sender: self)
        } else {
            print("checked")
        }
        */
        
        checkitem(indexPath)
       // let row = indexPath.row
        
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        return 50
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "    ") { (action , indexPath ) -> Void in
            
            
            
            self.editing = false
           
            self.swipedeleteitem(indexPath)
        }
        
        if let adelete = UIImage(named: "4DeleteButton50") {
            deleteAction.backgroundColor = UIColor.imageWithBackgroundColor(adelete, bgColor: UIColorFromRGB(0xF23D55), w: 50, h: 50)
        }
        

        // EDIT
        let editAction = UITableViewRowAction(style: .Normal, title: "    ") { (action , indexPath ) -> Void in
            
        self.itemtoedit = toDoItems[indexPath.row].itemid
        
        self.performSegueWithIdentifier("edittodoitem", sender: self)
        }
        
        if let editpict = UIImage(named: "4EditButton50") {
            editAction.backgroundColor = UIColor.imageWithBackgroundColor(editpict, bgColor: UIColorFromRGB(0x7ED0A5), w: 50, h: 50)
        }
        
        return [deleteAction, editAction]//, shareAction]
    }

    
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "todoitemcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToDoListCell
        
        
        cell.itemname.text = toDoItems[indexPath.row].itemname
        cell.itemnote.text = toDoItems[indexPath.row].itemnote
        
        if toDoItems[indexPath.row].itemimportant == true {
            cell.importantview.hidden = false
           cell.markview.backgroundColor = UIColorFromRGB(0x31797D)
        } else {
            cell.importantview.hidden = true
            cell.markview.backgroundColor = UIColorFromRGB(0xAAAAAA)
        }
        
        
        if toDoItems[indexPath.row].itemnote == "" {
            cell.topname.constant = 5
        } else {
            cell.topname.constant = 1
        }
        
        if toDoItems[indexPath.row].ischecked == true {
            
            
            let attributes = [NSStrikethroughStyleAttributeName : 1]

            let title = NSAttributedString(string: toDoItems[indexPath.row].itemname, attributes: attributes)
            cell.itemname.attributedText = title
            
            cell.checkview.frame = cell.bounds
            
            cell.checkview.hidden = false
            
            cell.restoreitem.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
            
        } else {
            
            
            let attributes = [NSStrikethroughStyleAttributeName : 0]

            let title = NSAttributedString(string: toDoItems[indexPath.row].itemname, attributes: attributes)
            cell.itemname.attributedText = title
            
            cell.checkview.frame = cell.bounds
            
            cell.checkview.hidden = true
            
            cell.restoreitem.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
            
        }


        

        
        return cell
    }



}
