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


class ToDoListCreation: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshToDoListDelegate, UITextFieldDelegate, ToDoOptionsPopupDelegate, takepicturedelegate, UITextViewDelegate {
    
    
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
    
    
     var transitionOperator = TransitionOperator()
    
    var delegatefortodolist : passtodoListtoMenuDelegate?
    var senderVC : UIViewController?
    
    
    @IBOutlet var backbaroutlet: UIBarButtonItem!
    
    @IBAction func backBar(sender: AnyObject) {
        /*
        if senderVC == senderVC as? AllListsVC || senderVC == senderVC as? ChooseListToCreateView {
        
        //if senderVC == senderVC as? ChooseListToCreateView {
        additemstoarrayandsave()
            performSegueWithIdentifier("gobacktoalllists", sender: self)
            
        } else if senderVC == senderVC as? MainMenuViewController {
            
           // delegatefortodolist?.gettodolistparameters(true, listid:currenttodolist, isreceived: isReceived)
            
            
            additemstoarrayandsave()
            dismissViewControllerAnimated(true, completion: nil)
            
        }
*/

    }
    
    
    @IBAction func optionsBar(sender: AnyObject) {
        
        performSegueWithIdentifier("optionsfromtodo", sender: self)
 
        
    }
    
    @IBAction func AddItemBar(sender: AnyObject) {
        performSegueWithIdentifier("createtodoitem", sender: self)
    }
    
    
    //performSegueWithIdentifier("createtodoitem", sender: self)
    
    func refreshtodotable() {
        //tableView.reloadData()
        
        
        if justCreated == true {
            
            
            activelist = currenttodolist
            if currenttodolist != "" {
                
                /*
                countitems()
                itemsoverall.text = String(itemsquantity)
                countchecked()
                itemschecked.text = String(checkeditemsquantity)
*/
                countitems()
                countchecked()
                 itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
               // itemsoverall.text = "\(String(itemsquantity))/\(String(checkeditemsquantity))"
                
                tableView.reloadData()
                
            } else {
                
            }
            
        } else {
            /*
            countitems()
            itemsoverall.text = String(itemsquantity)
            countchecked()
            itemschecked.text = String(checkeditemsquantity)
            */
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
          //  itemsoverall.text = "\(String(itemsquantity))/\(String(checkeditemsquantity))"
            tableView.reloadData()
        }
        
    }
    
    var currenttodolist = String()
    
    var activelist = String()
    
    //var justCreated = Bool()
    var justCreated = true
    
    var isReceived = Bool()
    
    
    var checkedImage: UIImage = UIImage(named: "EditModeCheckIcon")!
    //UIImage(named: "check.png")!
    
    var notcheckedImage: UIImage = UIImage(named: "EditModeUncheckIcon")!

    var itemtocheck = String()
    
    var itemtodelete = String()
    
    var itemtoedit = String()
    
    ////items part
    var itemsnames = [String]()
    
    var itemsquantity = Int()
    var checkeditemsquantity = Int()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var listname: UITextField!
    
    @IBOutlet weak var listnote: UITextField!
    
    
  
    @IBAction func SaveList(sender: AnyObject) {
    
            
            print(currenttodolist)
        
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
                    
                    
                    
                    
                    self.additemstoarray()
                    
                    print("ARRAY IS \(self.idsinthislist)")
                    
                    todolist["ItemsInTheToDoList"] = self.idsinthislist
                    
                    todolist["ItemsCount"] = self.itemsquantity
                    todolist["CheckedItemsCount"] = self.checkeditemsquantity
                    
                    todolist["CreationDate"] = updatedate
                    
                    todolist["updateDate"] = updatedate
                    
                    
                    
                    todolist.pinInBackground()
                    //shopList.saveInBackground()
                   // todolist.saveEventually()
                }
            }
        
        ////// NOW SAVE IN ITEMSLIST ARRAY
        
      //  if let foundlist = find(lazy(UserLists).map({ $0.listid }), currenttodolist) {
        
         if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            UserLists[foundlist].listname = listname.text
            UserLists[foundlist].listnote = listnote.text

            UserLists[foundlist].listitemscount = itemsquantity
            UserLists[foundlist].listcheckeditemscount = checkeditemsquantity
            UserLists[foundlist].listcreationdate = updatedate
            
        }
        
        //if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), currenttodolist) {
        if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            
            
            UserToDoLists[foundtodolist].listname = listname.text
            UserToDoLists[foundtodolist].listnote = listnote.text
            UserToDoLists[foundtodolist].listitemscount = itemsquantity
            UserToDoLists[foundtodolist].listcheckeditemscount = checkeditemsquantity
            UserToDoLists[foundtodolist].listcreationdate = updatedate
            
        }
        
        if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            
            
            UserFavLists[foundfavlist].listname = listname.text
            UserFavLists[foundfavlist].listnote = listnote.text
            UserFavLists[foundfavlist].listitemscount = itemsquantity
            UserFavLists[foundfavlist].listcheckeditemscount = checkeditemsquantity
            UserFavLists[foundfavlist].listcreationdate = updatedate
            
        }


            
            
            
        }
    
    
    ///////// COLOR CODER PART
    var colorcode = String()
    
    var red:String = "F23D55"
    var dgreen:String = "31797D"
    var lgreen:String = "61C791"
    var yellow:String = "DAFFA4"
    var black:String = "2A2F36"
    var gold:String = "A2AF36"
    var grey:String = "838383"
    
    
    /////////////
    
    
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
                //shopList.saveInBackground()
                //todolist.saveEventually()
            }
        }
        
        ////// NOW SAVE IN ITEMSLIST ARRAY
        
        //  if let foundlist = find(lazy(UserLists).map({ $0.listid }), currenttodolist) {
        
        if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(currenttodolist) {
            UserLists[foundlist].listname = listname.text
            UserLists[foundlist].listnote = listnote.text
            
            UserLists[foundlist].listitemscount = itemsquantity
            UserLists[foundlist].listcheckeditemscount = checkeditemsquantity
           // UserLists[foundlist].listcreationdate = updatedate
            UserLists[foundlist].listcolorcode = self.colorcode
            
        }
        
        //if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), currenttodolist) {
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
          //  UserFavLists[foundfavlist].listcreationdate = updatedate
            UserFavLists[foundfavlist].listcolorcode = self.colorcode
            
        }
        

    
    }
    
    
    
    
    @IBOutlet weak var itemsoverall: UILabel!
    
    
    @IBOutlet weak var itemschecked: UILabel!
    
    var idsinthislist = [String]()
    
    func additemstoarray() -> [String]{
            
           // var idsinthislist = [String]()
            
            for item in toDoItems {
                idsinthislist.append(item.itemid)
            }
            /*
            var query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            query.whereKey("listUUID", equalTo: currenttodolist)
            query.getFirstObjectInBackgroundWithBlock() {
                
                (todolist: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let todolist = todolist {
                    todolist["ItemsInTheToDoList"] = idsinthislist
                    todolist.pinInBackground()
                    todolist.saveEventually()
                }
            }
            */
            //ItemsCount = idsinthislist.count
            // return ItemsCount
        
        return idsinthislist
        
        }
    
    
    
    
    @IBAction func didendeditname(sender: AnyObject) {
        
        
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
               // todolist.saveEventually()
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
                    
                    // COUNT ITEMS BITCH!
                   /*
                    self.countitems()
                    self.itemsoverall.text = String(self.itemsquantity)
                    self.countchecked()
                    self.itemschecked.text = String(self.checkeditemsquantity)
                    */
                    self.countitems()
                    self.countchecked()
                    self.itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(self.itemsquantity))/\(String(self.checkeditemsquantity))"
                    // self.itemsoverall.text = "\(String(self.itemsquantity))/\(String(self.checkeditemsquantity))"
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
        //shopListNew.saveInBackgroundWithBlock {
        /*
        toDoListNew.saveEventually() {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // self.currentList = shopListNew.objectId!
                //self.trycurrent = shopListNew.objectId!
                print("Current list is \(self.currenttodolist)")
            } else {
                // There was a problem, check error.description
            }
            
            print("Current list is \(self.currenttodolist)")
        }
        */
        // self.currentList = trycurrent
        
        itemsquantity = 0
        checkeditemsquantity = 0
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
        //itemsoverall.text = "\(String(self.itemsquantity))/\(String(self.checkeditemsquantity))"//String(0)
        //itemschecked.text = String(0)
        
    }
    
    func edititem(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ToDoListCell
        let indexPathItem = tableView.indexPathForCell(cell)
        
        //itemtoedit = shoppingListItemsIds[indexPathItem!.row]
        itemtoedit = toDoItems[indexPathItem!.row].itemid
        
       // performSegueWithIdentifier("edittodoitemsegue", sender: self)
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

        
        let checkbutton = cell.viewWithTag(71) as! UIButton
        
        checkbutton.setImage(notcheckedImage, forState: .Normal)
        
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
        
        
       // toDoItems[indexPathCheck!.row].ischecked = false
        
        
        
        checkeditemsquantity -= 1
       // itemschecked.text = String(checkeditemsquantity)
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
      //  itemsoverall.text = "\(String(self.itemsquantity))/\(String(self.checkeditemsquantity))"
    }
    
    func checkitem(sender: UIButton!) {
    
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ToDoListCell
        let indexPathCheck = tableView.indexPathForCell(cell)
        

        itemtocheck = toDoItems[indexPathCheck!.row].itemid
        

        if toDoItems[indexPathCheck!.row].ischecked == false {
            
            button.setImage(checkedImage, forState: .Normal)
            
              toDoItems[indexPathCheck!.row].ischecked = true
            
            cell.checkview.frame = cell.bounds
            
            cell.checkview.hidden = false
            
            let attributes = [NSStrikethroughStyleAttributeName : 1]
            // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
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
                    itemList["isChecked"] = true
                    itemList.pinInBackground()
                   // itemList.saveEventually()
                    
                }
                
                
            }
            
            //toDoItems[indexPathCheck!.row].ischecked = true

            
            checkeditemsquantity += 1
           // itemschecked.text = String(checkeditemsquantity)
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
            //itemsoverall.text = "\(String(self.itemsquantity))/\(String(self.checkeditemsquantity))"
            
        } else {
            
            /*
            button.setImage(notcheckedImage, forState: .Normal)
            
            
            let attributes = [NSStrikethroughStyleAttributeName : 0]
            var title = NSAttributedString(string: toDoItems[indexPathCheck!.row].itemname, attributes: attributes)
            
            cell.itemname.attributedText = title
            
            
            var querynew = PFQuery(className:"toDoItems")
            querynew.fromLocalDatastore()
            querynew.whereKey("itemUUID", equalTo: itemtocheck)
            querynew.getFirstObjectInBackgroundWithBlock() {
                (itemList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let itemList = itemList {
                    itemList["isChecked"] = false
                    itemList.pinInBackground()
                    itemList.saveEventually()
                    
                }
                
                
            }

            
            toDoItems[indexPathCheck!.row].ischecked = false
            
     
            
            checkeditemsquantity -= 1
            itemschecked.text = String(checkeditemsquantity)
            
            */
        }

        
        
    }
    
    
    func countchecked() -> Int {
        /*
        var checkeditems : Int {
            
            get{return 0}
            set{0}
            
            
        }
        */
      
        /*
        var quantityofchecked = [Bool]()
        
        for item in itemsDataDict {
        if item["ItemIsChecked"] as! Bool == true {
        quantityofchecked.append(item["ItemIsChecked"] as! Bool)
        } else {
        print("Not checked")
        }
        }
        checkeditemsqty = quantityofchecked.count
        return checkeditemsqty
*/
        
        var quantityofchecked = [Bool]()
        
        for item in toDoItems {
            if item.ischecked == true {
                quantityofchecked.append(item.ischecked)
               // checkeditems += 1
            } else {
                print("Not checked")
            }
        }
        //checkeditemsqty = quantityofchecked.count
        checkeditemsquantity = quantityofchecked.count
       // checkeditemsquantity = checkeditems
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

/*
                countitems()
                itemsoverall.text = String(itemsquantity)
                countchecked()
                itemschecked.text = String(checkeditemsquantity)
*/
                countitems()
                countchecked()
                itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
               // itemsoverall.text = "\(String(itemsquantity))/\(String(checkeditemsquantity))"
                tableView.reloadData()

            } else {
                print("WHERE THE FUCK IS THIS VARIABLE?!")
            }

        } else {
        /*
        countitems()
        itemsoverall.text = String(itemsquantity)
        countchecked()
        itemschecked.text = String(checkeditemsquantity)
        */
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
           // itemsoverall.text = "\(String(itemsquantity))/\(String(checkeditemsquantity))"
        tableView.reloadData()
        }
    }
    
    /*
    func configurenavigation() {
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped:")
        
        //var rightListsButtonItem: UIBarButtonItem = UIBarButtonItem(image: ListsIcon, style: UIBarButtonItemStyle.Plain, target: self, action: "ListsTapped:")
        var rightListsButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Lists", style: UIBarButtonItemStyle.Plain, target: self, action: "ListsTapped:")
        
        var rightSettingsButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "SettingsTapped:")
      
        
        
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightListsButtonItem, rightSettingsButtonItem], animated: true)
    }
    */
    
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
        
        
        if segue.identifier == "showtodooptions" {
            
            let popoverViewController = segue.destinationViewController as! OptionsToDo//
            
            popoverViewController.delegate = self //
            
            
            popoverViewController.colorcode = colorcode
            
            popoverViewController.senderVC = "ToDoList"
            
        }

        
        if segue.identifier == "addtodoitemsegue" {
            let navVC = segue.destinationViewController as! UINavigationController
            
            let additemVC = navVC.viewControllers.first as! AddToDoItemViewController
            
            //additemVC.currentitem = //currentList
            additemVC.currentlist = currenttodolist
            
            additemVC.existingitem = false
            
            
        }
        
        if segue.identifier == "ShareFromToDoCreationNew" {//"ShareFromToDo" {
        let shareNav = segue.destinationViewController as! UINavigationController
        
        let shareVC = shareNav.viewControllers.first as! SharingViewController
        
        additemstoarrayandsave()
        
        shareVC.listToShare = currenttodolist
        shareVC.listToShareType = "ToDo"
        shareVC.delegate = self
        shareVC.senderVC = "ToDoCreationVC"
            
        }
        
        //edittodoitemsegue
        /*
        if segue.identifier == "edittodoitemsegue" {
            let naveditVC = segue.destinationViewController as! UINavigationController
            
            let edititemVC = naveditVC.viewControllers.first as! AddToDoItemViewController
            
            //additemVC.currentitem = //currentList
            edititemVC.currentlist = currenttodolist
            
            edititemVC.currentitem = itemtoedit
            
            edititemVC.existingitem = true
            
            
        }
        */
        
         if segue.identifier == "createtodoitem" {
        
      
        
        
        let toViewController = segue.destinationViewController as! AddToDoItemViewController

        toViewController.tododelegate = self // NEED THIS FOR REFRESHING FUNCTION!

        toViewController.currentlist = currenttodolist
        toViewController.existingitem = false
        }
        
        if segue.identifier == "edittodoitem" {
            
           
            
            
            let toViewController = segue.destinationViewController as! AddToDoItemViewController
           
            
           // self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            
            
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

        /*
        countitems()
        itemsoverall.text = String(itemsquantity)
        countchecked()
        itemschecked.text = String(checkeditemsquantity)
        */
        countitems()
        countchecked()
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
       // itemsoverall.text = "\(String(itemsquantity))/\(String(checkeditemsquantity))"
        
        //IF SHOWCATS == TRUE
        
        
        
        
    }
    
    
    @IBAction func unwindToCreationOfToDoList(sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet var sharebaroutlet: UIBarButtonItem!
    
    @IBAction func shareaction(sender: AnyObject) {
        
        
        
        
    }
    @IBOutlet var savebaroutlet: UIBarButtonItem!
    
    
 
    
    @IBOutlet var toptoolbar: UIToolbar!
    
    @IBOutlet var bottomtoolbar: UIToolbar!
    
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
                                
                                
                                //self.tableView.reloadData() // without this thing, table would contain only 1 row
                                
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

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
                        
                        cell.checkitem.setImage(checkedImage, forState: .Normal)
                        
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
                        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"

                        
                    } else {
                        
           
                    }
                    
                    
                    
                    ////
                    
                }
            }
        }
    }

    
    @IBOutlet var lighbgview: UIView!
    
    @IBOutlet var topview: UIView!
    
    @IBOutlet var smalltopview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backbaroutlet.target = self.revealViewController()
        backbaroutlet.action = Selector("revealToggle:")
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableAfterPush", name: "reloadTableToDo", object: nil)
        
        smalltopview.backgroundColor = UIColorFromRGB(0x31797D)
        
        lighbgview.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        topview.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        self.view.backgroundColor = UIColorFromRGB(0x31797D)//2A2F36)
        
        
        listname.delegate = self
        
        listnote.delegate = self
        
        var swipecell = UISwipeGestureRecognizer(target: self, action: "didSwipeCell:")
        swipecell.direction = .Right
        self.tableView.addGestureRecognizer(swipecell)
        
        toptoolbar.barTintColor = UIColorFromRGB(0x31797D)//2a2f36)
        
      
        
        self.view.backgroundColor = UIColorFromRGB(0x31797D)//2a2f36)
        
       
        
       

         //Navigation configuration
        /*
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped:")
        
        //var rightListsButtonItem: UIBarButtonItem = UIBarButtonItem(image: ListsIcon, style: UIBarButtonItemStyle.Plain, target: self, action: "ListsTapped:")
        var rightListsButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Lists", style: UIBarButtonItemStyle.Plain, target: self, action: "ListsTapped:")
        
        var rightSettingsButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "SettingsTapped:")
        
        
        
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightListsButtonItem, rightSettingsButtonItem], animated: true)
        */
        //configurenavigation()
        
        // Do any additional setup after loading the view.
        
        if justCreated == true {
            
            let todaydate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let namedate = dateFormatter.stringFromDate(todaydate)
            
            self.listname.text = "\(NSLocalizedString("listtodo", comment: ""))"
            colorcode = lgreen
            
            newPFObject()
            
            
            
        } else {
            currenttodolist = activelist
            
           
            
           
            
            itemsretrieval(activelist)//currenttodolist)
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(activelist) {
            if (UserLists[foundlist].listcolorcode != nil) {
                colorcode = UserLists[foundlist].listcolorcode!
                
            } else {
                colorcode = black
            }
            }
            
           
            
            tableView.reloadData()

        }
        
        // COUNT ITEMS BITCH!
        countitems()
        countchecked()
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsquantity))/\(String(checkeditemsquantity))"
       // itemsoverall.text = "\(String(itemsquantity))/\(String(checkeditemsquantity))"
        //Navigation configuration
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
        
        if toDoItems[indexPath.row].ischecked == false {
        
        itemtoedit = toDoItems[indexPath.row].itemid

        performSegueWithIdentifier("edittodoitem", sender: self)
        } else {
            print("checked")
        }
        
       // let row = indexPath.row
        
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
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
        
        return 81
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
        let deleteAction = UITableViewRowAction(style: .Normal, title: NSLocalizedString("delete", comment: "")) { (action , indexPath ) -> Void in
            
            
            
            self.editing = false
           
            self.swipedeleteitem(indexPath)
        }
        
        deleteAction.backgroundColor = UIColorFromRGB(0xF23D55)

        
        
        return [deleteAction]//, shareAction]
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "todoitemcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToDoListCell
        
        
        
      

   
        
        
        cell.itemname.text = toDoItems[indexPath.row].itemname
        cell.itemnote.text = toDoItems[indexPath.row].itemnote
        
        if toDoItems[indexPath.row].itemimportant == true {
            cell.importantimage.hidden = false
       
        } else {
            cell.importantimage.hidden = true
            
        }
        
        
        if toDoItems[indexPath.row].ischecked == true {
            cell.checkitem.setImage(checkedImage, forState: .Normal)
            
            let attributes = [NSStrikethroughStyleAttributeName : 1]
            // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
            let title = NSAttributedString(string: toDoItems[indexPath.row].itemname, attributes: attributes)
            cell.itemname.attributedText = title
            
            cell.checkview.frame = cell.bounds
            
            cell.checkview.hidden = false
            
            cell.restoreitem.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
            
        } else {
            cell.checkitem.setImage(notcheckedImage, forState: .Normal)
            
            let attributes = [NSStrikethroughStyleAttributeName : 0]
            // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
            let title = NSAttributedString(string: toDoItems[indexPath.row].itemname, attributes: attributes)
            cell.itemname.attributedText = title
            
            cell.checkview.frame = cell.bounds
            
            cell.checkview.hidden = true
            
            cell.restoreitem.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
            
        }

        
         cell.checkitem.addTarget(self, action: "checkitem:", forControlEvents: .TouchUpInside)
        
        //cell.edititemoutlet.addTarget(self, action: "edititem:", forControlEvents: .TouchUpInside)

      
        
       // prodhistorycell.plus.tag = indexPath.row
       // prodhistorycell.addedlabel.hidden = true
       // prodhistorycell.plus.addTarget(self, action: "addItemToTheList:", forControlEvents: .TouchUpInside)
        
        // Configure the cell...
        
        
        return cell
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
