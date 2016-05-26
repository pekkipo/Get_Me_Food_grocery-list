//
//  AllListsVC.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 04/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var UserLists = [UserList]()
var UserShopLists = [UserList]()
var UserToDoLists = [UserList]()
var UserFavLists = [UserList]()


protocol refreshnumbeofreceivedlistsDelegate
{
    
    func refreshreceivednumber()
}

var submitimage : UIImage = UIImage(named: "SubmitIcon")!
var closeimage : UIImage = UIImage(named: "CloseIcon")!


class AllListsVC: UIViewController, UIPopoverPresentationControllerDelegate, refreshliststableDelegate, sortlistsDelegate, UIGestureRecognizerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    
    
    func sortandrefreshlists()
    {
        tableView.reloadData()
    }
    
    var shopicon : UIImage = UIImage(named: "BlackCart")!//UIImage(named: "ShoppingCart")!
    var todoicon : UIImage = UIImage(named: "BlackDoH25")!
    
   //var showoption = String()
    
   var showoption : String = "alllists"
    
    
    @IBOutlet var tableView: UITableView!
    
    var maindelegate : refreshmainviewDelegate?
    
    
    @IBOutlet var showalloutlet: UIBarButtonItem!
    
    @IBOutlet var showshopsoutlet: UIBarButtonItem!
    
    @IBOutlet var showtodosoutlet: UIBarButtonItem!
    
    @IBOutlet var favsbaroutlet: UIBarButtonItem!
    
    @IBAction func showAll(sender: AnyObject) {
        
        showoption = "alllists"
        showalloutlet.tintColor = UIColorFromRGB(0xE0FFB2)
        showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        
       // UserLists.sort(self.sortListsDESC)
       // UserShopLists.sort(self.sortListsDESC)
       // UserToDoLists.sort(self.sortListsDESC)

        tableView.reloadData()
      

    }
    
    @IBAction func showShops(sender: AnyObject) {
        showoption = "shoplists"
        
      //// UserLists.sort(self.sortListsDESC)
        //UserShopLists.sort(self.sortListsDESC)
       // UserToDoLists.sort(self.sortListsDESC)
        
        showalloutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        showshopsoutlet.tintColor = UIColorFromRGB(0xE0FFB2)
        showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)

        tableView.reloadData()
        
       

    }
    
    
    @IBAction func showToDos(sender: AnyObject) {
        showoption = "todolists"
        
       // UserLists.sort(self.sortListsDESC)
       // UserShopLists.sort(self.sortListsDESC)
      //  UserToDoLists.sort(self.sortListsDESC)
        
        showalloutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        showtodosoutlet.tintColor = UIColorFromRGB(0xE0FFB2)
        favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)

        tableView.reloadData()
        /*
        println("all [\(UserLists), \(UserLists.count)]")
        println("Shops [\(UserShopLists), \(UserShopLists.count)]")
        println("ToDo [\(UserToDoLists), \(UserToDoLists.count)]")
        */
       


    }
    
    
    @IBOutlet var OpenMenu: UIBarButtonItem!
    
    @IBAction func MenuBar(sender: AnyObject) {
        
        if !(PFAnonymousUtils.isLinkedWithUser(PFUser.currentUser())) {
            
            if CheckConnection.isConnectedToNetwork() {
                
                   // maindelegate?.checkreceivedlists()
               
            } else {
                print("No internet connection found")
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    @IBAction func todoBar(sender: AnyObject) {
        
        performSegueWithIdentifier("createnewtodolistfromall", sender: self)
    }
    
    
    @IBAction func FavsBar(sender: AnyObject) {
        
        //showoption = "favs"
        //wait a bit
        
        if showoption != "favs" {
        
        showalloutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        favsbaroutlet.tintColor = UIColorFromRGB(0xE0FFB2)
        
        showoption = "favs"
        } else {
            showoption = "alllists"
            
            showalloutlet.tintColor = UIColorFromRGB(0xE0FFB2)
            showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        }
        tableView.reloadData()
        
        
    }
    
    @IBAction func AddBar(sender: AnyObject) {
        
        self.performSegueWithIdentifier("createnewshoplistfromall", sender: self)
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
      //  self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    //////////// VARS
    var lists = [Dictionary<String, AnyObject>]()
    
    var ShowFavourites = Bool()
    
    
    
    
    var ListsIds = [String]()
    var ListsNames = [String]()
    var ListsNotes = [String]()
    
    //new stuff
    var ListsCreationDates = [NSDate]()
    var ListsIsFavourite = [Bool]()
    //var ListsSharedWith = [String]()
    var ListsSharedWith = [[String]]()
    //var ListsSharedWithArray = [[String]]() //Multidimensional array.    //1st - sender, 2nd - receiver, dont use i
    
    
    var ListsConfirm = [Bool]()
    var ListsIsDeleted = [Bool]()
    var ListsIsShared = [Bool]()
    var ListsShareWith = [[AnyObject]]()
    
    var ListsItemsCount = [Int]()
    var ListsItemsCheckedCount = [Int]()
    
    //var ListsBelongsToUsers = [[String]]()
    
    var ListsBelongsToUser = [String]()
    
    var ListsIsReceived = [Bool]()
    
    var ListsReceivedFrom = [[String]]()
    
    var ListsIsSaved = [Bool]()
    
    var imagePath = String()
    
    //var ListsReceivedFromNames = [String]()
    
    var listtodelete: String?
    var listtofav: String?
    
    var listfromfav: String?
    
    var listtoshare: String?
    
    var listtosharetype = String()
    
    var listtosave: String?
    
    var favimage: UIImage = UIImage()
    var notfavimage: UIImage = UIImage()
    
    
    var ItemsInReceivedList = [String]()
    
    var ListsType = [String]()
    
    var listtoopen = String()
    
    
    
    

    //////////// END VARS
    
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("getting", comment: ""))
    let progressHUDdel = ProgressHUD(text: NSLocalizedString("wait", comment: ""))
    let progressHUDsave = ProgressHUD(text: NSLocalizedString("saving", comment: ""))
    
    func pause() {
        
        
        self.view.addSubview(progressHUD)
        
        progressHUD.setup()
        progressHUD.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func pausedeleting() {
        
        
        self.view.addSubview(progressHUDdel)
        
        progressHUDdel.setup()
        progressHUDdel.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func pausesaving() {
        
        
        self.view.addSubview(progressHUDsave)
        
        progressHUDsave.setup()
        progressHUDsave.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }


    
    func restore() {
        
        progressHUD.hide()
       
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func restoredel() {
        
        progressHUDdel.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func restoresaving() {
        
        progressHUDsave.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
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
    

    // checker
    func checkreceivedlists() {
        
        
       // var receivedcount : Int = 0
        
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
                    
                    UserLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
                    UserShopLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
                    UserToDoLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
                    UserFavLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
                    
                    dispatch_async(dispatch_get_main_queue(), {
                     self.tableView.reloadData()
                    })
                    
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
                     dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                        })
                    
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
        
    }
    
    func displayReceivedAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "ListSentSuccess")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(closeCallback)
    }
    
    func closeCallback() {
        tableView.reloadData()
    }
    
    
    
    func sortListsDESC(compare:UserList, to:UserList) -> Bool {
       // return compare.listcreationdate.compare(to.listcreationdate) == NSComparisonResult.OrderedDescending
        return compare.listcreationdate.compare(to.listcreationdate) == NSComparisonResult.OrderedAscending
        //ListsArray.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
    }

    
    func sortArray() {
        let sortedarray = ListsIds.reverse()
        
        
        
        //for (index, element) in enumerate(sortedarray) {
        for (index, element) in sortedarray.enumerate() { //swift 2
            ListsIds[index] = element
        }
        
        tableView.reloadData()
        //refreshControl?.endRefreshing()
    }

    
    /*
    override func viewDidAppear(animated: Bool) {
       
        checkreceivedlists()
        
        tableView.reloadData()
        
    }
    */
    
    
    @IBOutlet var toptoolbar: UIToolbar!
    
    @IBOutlet var bottomtoolbar: UIToolbar!
    
    
    func reloadTableAfterPush() {
        
    //displayReceivedAlert("", message: mesalert)
        
      checkreceivedlists()
      tableView.reloadData()
 
    }

    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    func displayInfoAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x2A2F36, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    
    
   
    
    func refreshlists() {
        
        
        if CheckConnection.isConnectedToNetwork() {
             checkreceivedlists()
        } else {
            print("No internet connection found")
            displayFailAlert(NSLocalizedString("NoConnection", comment: ""), message: NSLocalizedString("cannotcheck", comment: ""))
        }

        tableView.reloadData()
    }
    
    
    @IBOutlet var newlistname: CustomTextField!//UITextField!
    
    
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
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    @IBOutlet var smalltopview: UIView!
    
    @IBOutlet var OpenMenu2: UIBarButtonItem!
    
    
    func clickthetitle(button: UIButton) {
        
        print("Tapped the title")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // navigation title as a button
        
        let button =  UIButton(type: .Custom)
        //button.frame = CGRectMake(0, 0, 100, 40) as CGRect
        button.frame = CGRectMake((((self.view.frame.size.width) / 2) - 80),0,140,40) as CGRect
        //button.backgroundColor = UIColor.clearColor()
        button.setTitle("My lists", forState: UIControlState.Normal)
        //button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        button.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.setTitleColor(UIColorFromRGB(0x31797D), forState: .Normal)
        let spacing: CGFloat = 10; // the amount of spacing to appear between image and title
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        let titleimage = UIImage(named: "myliststitle") as UIImage?
        button.setImage(titleimage, forState: .Normal)
        button.addTarget(self, action: Selector("clickthetitle:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = button
        
        //
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableAfterPush", name: "reloadTableLists", object: nil)
        
        
        OpenMenu2.target = self.revealViewController()
        OpenMenu2.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        newclosebuttonoutlet.layer.borderWidth = 1
        newclosebuttonoutlet.layer.borderColor = UIColorFromRGB(0xF23D55).CGColor
        newclosebuttonoutlet.layer.cornerRadius = 4
        
        newdonebutton.layer.cornerRadius = 4
        
        newlistname.leftTextMargin = 10
        
        newnotetextview.layer.borderWidth = 1
        newnotetextview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        newnotetextview.layer.cornerRadius = 4
        
        newnotetextview.delegate = self
        newlistname.delegate = self
        
        newlistname.layer.borderWidth = 1
        newlistname.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        newlistname.layer.cornerRadius = 4
        
        blurredview.layer.cornerRadius = 4
        self.blurredview.clipsToBounds = true

        
       // toptoolbar.barTintColor = UIColorFromRGB(0x31797D)//2a2f36)
        

        
        self.view.layoutMargins = UIEdgeInsetsZero
        
        // Do any additional setup after loading the view.
         ShowFavourites = false
        
        print("Option is \(showoption)")
        
      //  showoption = "alllists"
        
        showalloutlet.tintColor = UIColorFromRGB(0xE0FFB2)
        
        /*
        print("all [\(UserLists), \(UserLists.count)]")
        print("all [\(UserShopLists), \(UserShopLists.count)]")
        print("all [\(UserToDoLists), \(UserToDoLists.count)]")
        
        
        print(UserLists.map({ $0.listtype }))
        print(UserShopLists.map({ $0.listtype }))
        print(UserToDoLists.map({ $0.listtype }))
*/
            //find(lazy(UserLists).map({ $0.listid }), listtosave!)
        
        //UserLists.sort(self.sortListsDESC)
        //UserShopLists.sort(self.sortListsDESC)
       // UserToDoLists.sort(self.sortListsDESC)
        
        UserLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
         UserShopLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
         UserToDoLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserFavLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        
        //SORT FUNCTION BY DATE
        
        let nib = UINib(nibName: "ReceivedListOldx", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "receivedlist")
        
        //tableView.reloadData()
        
        
    }
    
    func refreshListsTable(sentshowoption: String) {
        
        showoption = sentshowoption
        tableView.reloadData()
        
        
    }
    
     override func viewWillAppear(animated: Bool) {
        //not sure if need this BUT
        itemsDataDict.removeAll(keepCapacity: true)
        toDoItems.removeAll(keepCapacity: true)
        
        
        //listsretrieval()
        /*
        if CheckConnection.isConnectedToNetwork() {
            //listsretrievalfromcloud()
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
           // self.checkreceivedlists()
            })
        } else {
            print("No internet connection found")
        }
        */
       // UserLists.sort(self.sortListsDESC)
        //UserShopLists.sort(self.sortListsDESC)
        //UserToDoLists.sort(self.sortListsDESC)
        
        
        UserLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserShopLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserToDoLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserFavLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        
       // checkreceivedlists()
        
      //  showoption = "alllists"
        
        if showoption == "alllists" {
            showalloutlet.tintColor = UIColorFromRGB(0xE0FFB2)
            showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        } else if showoption == "shoplists" {
            showalloutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showshopsoutlet.tintColor = UIColorFromRGB(0xE0FFB2)
            showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        } else if showoption == "todolists" {
            showalloutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showtodosoutlet.tintColor = UIColorFromRGB(0xE0FFB2)
            favsbaroutlet.tintColor = UIColorFromRGB(0xFAFAFA)
        } else if showoption == "favs" {
            showalloutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showshopsoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            showtodosoutlet.tintColor = UIColorFromRGB(0xFAFAFA)
            favsbaroutlet.tintColor = UIColorFromRGB(0xE0FFB2)
        }
        
        
        
        
         tableView.reloadData()
        
      ////  print(UserLists.map({ $0.listtype }))
      //  print(UserShopLists.map({ $0.listtype }))
      //  print(UserToDoLists.map({ $0.listtype }))
      //  print(UserFavLists.map({ $0.listtype }))
        
        
        //badgestuff
        
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = label.font.pointSize * 1.2 / 2
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.whiteColor()
        label.text = String(receivedcount)
        
        if receivedcount > 0 {
        let toolbar = self.view.viewWithTag(999) as? UIToolbar
        //let menubar = self.view.viewWithTag(99) as? UIButton
            let menubar = toolbar!.viewWithTag(99) as? UIButton
        menubar?.addSubview(label)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//CGFloat(1.0)
        )
    }
    
    
        
    
    var idforoptions = String()
    
    func optionsaction(indexPath: NSIndexPath) {
        
        
        if showoption == "alllists" {
            idforoptions = UserLists[indexPath.row].listid
        } else if showoption == "shoplists" {
            idforoptions = UserShopLists[indexPath.row].listid
        } else if showoption == "todolists" {
            idforoptions = UserToDoLists[indexPath.row].listid
        } else if showoption == "favs" {
            idforoptions = UserFavLists[indexPath.row].listid
        }
        
        self.performSegueWithIdentifier("Alllistsoptions", sender: self)

    }
    
     var todoidforoptions = String()
    
    func todooptionsaction(indexPath: NSIndexPath) {
        
        
        if showoption == "alllists" {
            todoidforoptions = UserLists[indexPath.row].listid
        } else if showoption == "shoplists" {
            todoidforoptions = UserShopLists[indexPath.row].listid
        } else if showoption == "todolists" {
            todoidforoptions = UserToDoLists[indexPath.row].listid
        } else if showoption == "favs" {
            todoidforoptions = UserFavLists[indexPath.row].listid
        }
        
        self.performSegueWithIdentifier("todooptionssegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        
        if segue.identifier == "sortpopup" {
            
           let popoverViewController = segue.destinationViewController as! SortPopup//UIViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
           // popoverViewController.preferredContentSize = CGSize(width: 200, height: 220)
            
          //  popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
          //  popoverViewController.popoverPresentationController!.delegate = self
            
            popoverViewController.delegate = self
            
            
        }

        
        if segue.identifier == "presentNav" {

            let toViewController = segue.destinationViewController as! MenuViewController//UIViewController
            toViewController.view.backgroundColor = UIColorFromRGB(0x1695A3).colorWithAlphaComponent(0.85)
            self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            //toViewController.view.alpha = 0.7
            // self.presentViewController(self, animated: true, completion: nil)
        }
        
     
    
        if segue.identifier == "OpenListSegue" {
            
            
            let destinationVC : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            
            
            
          //  if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                // this is an interesting way but I can do much easier just using listtoopen variable
            
             //if var indexPath = sender as! NSIndexPath {
            if var indexPath = sender {
                
                destinationVC.justCreatedList = false
                
                var isreceived = Bool()
                
                print(UserLists[indexPath.row].listname)
                
                if showoption == "alllists" {
                    isreceived = UserLists[indexPath.row].listisreceived
                    destinationVC.activeList = UserLists[indexPath.row].listid
                }
                else if showoption == "shoplists" {
                    isreceived = UserShopLists[indexPath.row].listisreceived
                    destinationVC.activeList = UserShopLists[indexPath.row].listid
                    
                }
                else if showoption == "todolists" {
                    isreceived = UserToDoLists[indexPath.row].listisreceived
                    destinationVC.activeList = UserToDoLists[indexPath.row].listid
                    
                } else if showoption == "favs" {
                    isreceived = UserFavLists[indexPath.row].listisreceived
                    destinationVC.activeList = UserFavLists[indexPath.row].listid
                    
                } else {
                    isreceived = false
                }
                
                print("IS RECEIVED \(isreceived)")
                
                
                if isreceived == false {
                    destinationVC.isReceivedList = false
                } else {
                    destinationVC.isReceivedList = true
                }
                
            }

            
            
        }
        
        if segue.identifier == "ToDoOpenListSegue" {
            
           // let todoNav = segue.destinationViewController as! UINavigationController
           // let todoVC = todoNav.viewControllers.first as! ToDoListCreation
            
            let todoVC : ToDoListCreation = segue.destinationViewController as! ToDoListCreation

            
            //if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            
            if var indexPath = sender {
            
                //destinationVC.activeList = ListsIds[indexPath.row]
                //todoVC.activelist = ListsIds[indexPath.row]
                todoVC.justCreated = false
              //  if ListsIsReceived[indexPath.row] == false {
                
                var isreceived = Bool()
                
                if showoption == "alllists" {
                    isreceived = UserLists[indexPath.row].listisreceived
                    todoVC.activelist = UserLists[indexPath.row].listid
                }
                else if showoption == "shoplists" { //just in case, actually this case is impossible
                isreceived = UserShopLists[indexPath.row].listisreceived
                todoVC.activelist = UserShopLists[indexPath.row].listid

                }
                else if showoption == "todolists" {
                isreceived = UserToDoLists[indexPath.row].listisreceived
                todoVC.activelist = UserToDoLists[indexPath.row].listid
                    
                } else if showoption == "favs" {
                    isreceived = UserFavLists[indexPath.row].listisreceived
                    todoVC.activelist = UserFavLists[indexPath.row].listid
                    
                } else {
                isreceived = false
                }

                print("IS RECEIVED \(isreceived)")
               // var isreceived = Bool()
                
                    
                if isreceived == false {
                    
                    todoVC.isReceived = false
                } else {
                    todoVC.isReceived = true
                }
            }
            
            
            
        } //createnewshoplistfromall
        
        if segue.identifier == "createnewshoplistfromall" {
            
          //  let shopNav = segue.destinationViewController as! UINavigationController
            //let shopVC = shopNav.viewControllers.first as! ShoppingListCreation
           
             let shopVC = segue.destinationViewController as! ShoppingListCreation
            
            shopVC.senderVC = self
            shopVC.justCreatedList = true
            shopVC.isReceivedList = false

            
          
            
            
        }
        
        if segue.identifier == "createnewtodolistfromall" {
            
            //  let shopNav = segue.destinationViewController as! UINavigationController
            //let shopVC = shopNav.viewControllers.first as! ShoppingListCreation
            
            let todoVC = segue.destinationViewController as! ToDoListCreation
            
            todoVC.senderVC = self
            todoVC.justCreated = true
            todoVC.isReceived = false
            
            
        }


        
        if segue.identifier == "shareListSegue" {
            
            let shareNav = segue.destinationViewController as! UINavigationController
            
            let shareVC = shareNav.viewControllers.first as! SharingViewController
            
            
            shareVC.listToShare = listtoshare
            shareVC.listToShareType = listtosharetype
            
            shareVC.senderVC = "AllListsVC"
            
            
        }
        
        if segue.identifier == "Alllistsoptions" {
            
           let optionsVC = segue.destinationViewController as! ListOptionsPopover
            
         // optionsVC.view.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 0.8)

            optionsVC.senderVC = "AllListsVC"
            optionsVC.listtoupdate = idforoptions
            
            
        }
        
        if segue.identifier == "todooptionssegue" {
            
            let optionsVC = segue.destinationViewController as! OptionsToDo
            
            // optionsVC.view.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 0.8)
            
            optionsVC.senderVC = "AllListsVC"
            optionsVC.listtoupdate = todoidforoptions
            
            
        }
        
        

        
    }
    
    
    func adddeletefav(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ShopListCellNew
        let indexPathFav = tableView.indexPathForCell(cell)
        
        //listfromfav = ListsIds[indexPathFav!.row]
        
        if showoption == "alllists" {
            listfromfav = UserLists[indexPathFav!.row].listid
            
            //////ALL
            
            if UserLists[indexPathFav!.row].listisfavourite == true {
                //delete from favs
                
                pause()
                if UserLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"shopLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let shopList = shopList {
                            shopList["isFavourite"] = false
                            shopList.pinInBackground()
                            // shopList.saveInBackground()
                          //  shopList.saveEventually()
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = false
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                   // if let foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listfromfav!) {
                    if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserShopLists[foundshoplist].listisfavourite = false
                        
                    }
                    
                    //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                    if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                       UserFavLists.removeAtIndex(foundlistinfav)
                        
                    }

                    
                } else if UserLists[indexPathFav!.row].listtype == "ToDo" {
                    
                    let queryfav1 = PFQuery(className:"toDoLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.fromLocalDatastore()
                    queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.getFirstObjectInBackgroundWithBlock() {
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let todoList = todoList {
                            todoList["isFavourite"] = false
                            todoList.pinInBackground()
                            // shopList.saveInBackground()
                           // todoList.saveEventually()
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = false
                            
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                    //if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listfromfav!) {
                    if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserToDoLists[foundtodolist].listisfavourite = false
                    }
                    
                    //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                    if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserFavLists.removeAtIndex(foundlistinfav)
                        
                    }


                }
                
                notfavimage = UIImage(named: "ICFavStar") as UIImage!
                cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                
                
                
                
            } else {
                //add to favs
                
                pause()
                
                if UserLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"shopLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let shopList = shopList {
                            shopList["isFavourite"] = true
                            shopList.pinInBackground()
                            // shopList.saveInBackground()
                           // shopList.saveEventually()
                            
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = true
                            
                            
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                   // if let foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listfromfav!) {
                    
                     if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                        UserShopLists[foundshoplist].listisfavourite = true
                        UserFavLists.append(UserShopLists[foundshoplist])
                    }
                    
                    
                    
                } else if UserLists[indexPathFav!.row].listtype == "ToDo" {
                    
                    let queryfav1 = PFQuery(className:"toDoLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.fromLocalDatastore()
                    queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.getFirstObjectInBackgroundWithBlock() {
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let todoList = todoList {
                            todoList["isFavourite"] = true
                            todoList.pinInBackground()
                            // shopList.saveInBackground()
                           // todoList.saveEventually()
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = true
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                    //if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listfromfav!) {
                    if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                            UserToDoLists[foundtodolist].listisfavourite = true
                            UserFavLists.append(UserToDoLists[foundtodolist])
                        }
                }
                
                favimage = UIImage(named: "ICFavStarActive") as UIImage!
                cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
            }

            
            //////END ALL
        }
            
            /////// SHOPS ONLY
        else if showoption == "shoplists" {
             listfromfav = UserShopLists[indexPathFav!.row].listid
            
            
            
            if UserShopLists[indexPathFav!.row].listisfavourite == true {
                //delete from favs
                
                pause()
                
               // if let foundshoplist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                if let foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserLists[foundshoplist].listisfavourite = false
                }
                
                //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserFavLists.removeAtIndex(foundlistinfav)
                    
                }

                
                
               // if UserShopLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"shopLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let shopList = shopList {
                            shopList["isFavourite"] = false
                            shopList.pinInBackground()
                            // shopList.saveInBackground()
                           // shopList.saveEventually()
                            
                            
                            UserShopLists[indexPathFav!.row].listisfavourite = false
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                       
                        
                    }
                    
               // } else if UserShopLists[indexPathFav!.row].listtype == "ToDo"
                
                notfavimage = UIImage(named: "ICFavStar") as UIImage!
                cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                
                
            } else {
                //add to favs
                
                 pause()
                
               // if let foundshoplist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                if let foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserLists[foundshoplist].listisfavourite = true
                    UserFavLists.append(UserLists[foundshoplist])
                }
                
               
                
              //  if UserShopLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"shopLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let shopList = shopList {
                            shopList["isFavourite"] = true
                            shopList.pinInBackground()
                            // shopList.saveInBackground()
                            //shopList.saveEventually()
                            
                            
                            
                            UserShopLists[indexPathFav!.row].listisfavourite = true
                            
                            
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
              //  } else if UserShopLists[indexPathFav!.row].listtype == "ToDo"
                
                favimage = UIImage(named: "ICFavStarActive") as UIImage!
                cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
            }
            ////// END SHOPS ONLY
            
        }
        else if showoption == "todolists" {
             listfromfav = UserToDoLists[indexPathFav!.row].listid
            
            ///// TO DO ONLY
            
            if UserToDoLists[indexPathFav!.row].listisfavourite == true {
                //delete from favs
                
                pause()
                
               // if let foundshoplist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                if let foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserLists[foundshoplist].listisfavourite = false
                }
                
               // if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserFavLists.removeAtIndex(foundlistinfav)
                    
                }

                
                
              //  if UserToDoLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"toDoLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let todoList = todoList {
                            todoList["isFavourite"] = false
                            todoList.pinInBackground()
                            // shopList.saveInBackground()
                           // todoList.saveEventually()
                            
                            
                            UserToDoLists[indexPathFav!.row].listisfavourite = false
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
              //  } else if UserToDoLists[indexPathFav!.row].listtype == "ToDo"
                
                notfavimage = UIImage(named: "ICFavStar") as UIImage!
                cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                
                
            } else {
                //add to favs
                
                pause()
                
               // if let foundtodolist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                if let foundtodolist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserLists[foundtodolist].listisfavourite = true
                    UserFavLists.append(UserLists[foundtodolist])
                }
                
                //else if UserToDoLists[indexPathFav!.row].listtype == "ToDo" {
                    
                    let queryfav1 = PFQuery(className:"toDoLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.fromLocalDatastore()
                    queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.getFirstObjectInBackgroundWithBlock() {
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let todoList = todoList {
                            todoList["isFavourite"] = true
                            todoList.pinInBackground()
                            // shopList.saveInBackground()
                           // todoList.saveEventually()
                            
                            
                            UserToDoLists[indexPathFav!.row].listisfavourite = true
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                    
                
                
                favimage = UIImage(named: "ICFavStarActive") as UIImage!
                cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
            }

            
            ///// END TO DO ONLY
            
            
        }
        

        
        
    }
    
    
    func adddeletereceivedfav(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ReceivedListOld
        let indexPathFav = tableView.indexPathForCell(cell)
        
        //listfromfav = ListsIds[indexPathFav!.row]
        
        if showoption == "alllists" {
            listfromfav = UserLists[indexPathFav!.row].listid
            
            //////ALL
            
            if UserLists[indexPathFav!.row].listisfavourite == true {
                //delete from favs
                
                pause()
                if UserLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"shopLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let shopList = shopList {
                            shopList["isFavourite"] = false
                            shopList.pinInBackground()
                            // shopList.saveInBackground()
                            //shopList.saveEventually()
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = false
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                    //if let foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listfromfav!) {
                    if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                        UserShopLists[foundshoplist].listisfavourite = false
                    }
                    
                    //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                     if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserFavLists.removeAtIndex(foundlistinfav)
                        
                    }

                    
                } else if UserLists[indexPathFav!.row].listtype == "ToDo" {
                    
                    let queryfav1 = PFQuery(className:"toDoLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.fromLocalDatastore()
                    queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.getFirstObjectInBackgroundWithBlock() {
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let todoList = todoList {
                            todoList["isFavourite"] = false
                            todoList.pinInBackground()
                            // shopList.saveInBackground()
                           // todoList.saveEventually()
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = false
                            
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                  //  if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listfromfav!) {
                    if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {

                    UserToDoLists[foundtodolist].listisfavourite = false
                    }
                    
                    //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                    if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserFavLists.removeAtIndex(foundlistinfav)
                        
                    }
                    
                }
                
                notfavimage = UIImage(named: "ICFavStar") as UIImage!
                cell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                
                
                
                
            } else {
                //add to favs
                
                pause()
                
                if UserLists[indexPathFav!.row].listtype == "Shop" {
                    
                    let queryfav = PFQuery(className:"shopLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.fromLocalDatastore()
                    queryfav.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let shopList = shopList {
                            shopList["isFavourite"] = true
                            shopList.pinInBackground()
                            // shopList.saveInBackground()
                           // shopList.saveEventually()
                            
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = true
                            
                            
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                   // if let foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listfromfav!) {
                    if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                        UserShopLists[foundshoplist].listisfavourite = true
                        UserFavLists.append(UserShopLists[foundshoplist])
                    }
                    
                } else if UserLists[indexPathFav!.row].listtype == "ToDo" {
                    
                    let queryfav1 = PFQuery(className:"toDoLists")
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.fromLocalDatastore()
                    queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    queryfav1.getFirstObjectInBackgroundWithBlock() {
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                        } else if let todoList = todoList {
                            todoList["isFavourite"] = true
                            todoList.pinInBackground()
                            // shopList.saveInBackground()
                           // todoList.saveEventually()
                            
                            
                            UserLists[indexPathFav!.row].listisfavourite = true
                            
                            
                            self.restore()
                        }
                        self.tableView.reloadData()
                        //self.listsretrieval()
                        
                    }
                    
                   // if let foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listfromfav!) {
                    if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                        UserToDoLists[foundtodolist].listisfavourite = true
                        UserFavLists.append(UserToDoLists[foundtodolist])
                    }
                }
                
                favimage = UIImage(named: "ICFavStarActive") as UIImage!
                cell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
            }
            
            
            //////END ALL
        }
            
            /////// SHOPS ONLY
        else if showoption == "shoplists" {
            listfromfav = UserShopLists[indexPathFav!.row].listid
            
            
            
            if UserShopLists[indexPathFav!.row].listisfavourite == true {
                //delete from favs
                
                pause()
                
                //if let foundshoplist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                if let foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {

                UserLists[foundshoplist].listisfavourite = false
                }
                
                //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserFavLists.removeAtIndex(foundlistinfav)
                    
                }

                
                
                // if UserShopLists[indexPathFav!.row].listtype == "Shop" {
                
                let queryfav = PFQuery(className:"shopLists")
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav.fromLocalDatastore()
                queryfav.whereKey("listUUID", equalTo: listfromfav!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav.getFirstObjectInBackgroundWithBlock() {
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                        self.restore()
                    } else if let shopList = shopList {
                        shopList["isFavourite"] = false
                        shopList.pinInBackground()
                        // shopList.saveInBackground()
                      //  shopList.saveEventually()
                        
                        
                        UserShopLists[indexPathFav!.row].listisfavourite = false
                        
                        
                        self.restore()
                    }
                    self.tableView.reloadData()
                    
                    
                }
                
                // } else if UserShopLists[indexPathFav!.row].listtype == "ToDo"
                
                notfavimage = UIImage(named: "ICFavStar") as UIImage!
                cell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                
                
            } else {
                //add to favs
                
                pause()
                
                //if let foundshoplist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                if let foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                
                    UserLists[foundshoplist].listisfavourite = true
                    UserFavLists.append(UserLists[foundshoplist])
                }
                
                
                
                //  if UserShopLists[indexPathFav!.row].listtype == "Shop" {
                
                let queryfav = PFQuery(className:"shopLists")
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav.fromLocalDatastore()
                queryfav.whereKey("listUUID", equalTo: listfromfav!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav.getFirstObjectInBackgroundWithBlock() {
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                        self.restore()
                    } else if let shopList = shopList {
                        shopList["isFavourite"] = true
                        shopList.pinInBackground()
                        // shopList.saveInBackground()
                        //shopList.saveEventually()
                        
                        
                        
                        UserShopLists[indexPathFav!.row].listisfavourite = true
                        
                        
                        
                        
                        self.restore()
                    }
                    self.tableView.reloadData()
                    //self.listsretrieval()
                    
                }
                
                //  } else if UserShopLists[indexPathFav!.row].listtype == "ToDo"
                
                favimage = UIImage(named: "ICFavStarActive") as UIImage!
                cell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
            }
            ////// END SHOPS ONLY
            
        }
        else if showoption == "todolists" {
            listfromfav = UserToDoLists[indexPathFav!.row].listid
            
            ///// TO DO ONLY
            
            if UserToDoLists[indexPathFav!.row].listisfavourite == true {
                //delete from favs
                
                pause()
                
               // if let foundshoplist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                
                if let foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserLists[foundshoplist].listisfavourite = false
                }
                
                //if let foundlistinfav = find(lazy(UserFavLists).map({ $0.listid }), listfromfav!) {
                 if let foundlistinfav = UserFavLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                UserFavLists.removeAtIndex(foundlistinfav)
                    
                }

                
                
                //  if UserToDoLists[indexPathFav!.row].listtype == "Shop" {
                
                let queryfav = PFQuery(className:"toDoLists")
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav.fromLocalDatastore()
                queryfav.whereKey("listUUID", equalTo: listfromfav!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav.getFirstObjectInBackgroundWithBlock() {
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                        self.restore()
                    } else if let todoList = todoList {
                        todoList["isFavourite"] = false
                        todoList.pinInBackground()
                        // shopList.saveInBackground()
                       // todoList.saveEventually()
                        
                        
                        UserToDoLists[indexPathFav!.row].listisfavourite = false
                        
                        
                        self.restore()
                    }
                    self.tableView.reloadData()
                    //self.listsretrieval()
                    
                }
                
                //  } else if UserToDoLists[indexPathFav!.row].listtype == "ToDo"
                
                notfavimage = UIImage(named: "ICFavStar") as UIImage!
                cell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                
                
            } else {
                //add to favs
                
                pause()
                
               // if let foundtodolist = find(lazy(UserLists).map({ $0.listid }), listfromfav!) {
                
                 if let foundtodolist = UserLists.map({ $0.listid }).lazy.indexOf(listfromfav!) {
                    UserLists[foundtodolist].listisfavourite = true
                    UserFavLists.append(UserLists[foundtodolist])
                }
                
                //else if UserToDoLists[indexPathFav!.row].listtype == "ToDo" {
                
                let queryfav1 = PFQuery(className:"toDoLists")
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav1.fromLocalDatastore()
                queryfav1.whereKey("listUUID", equalTo: listfromfav!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                queryfav1.getFirstObjectInBackgroundWithBlock() {
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                        self.restore()
                    } else if let todoList = todoList {
                        todoList["isFavourite"] = true
                        todoList.pinInBackground()
                        // shopList.saveInBackground()
                        //todoList.saveEventually()
                        
                        
                        UserToDoLists[indexPathFav!.row].listisfavourite = true
                        
                        
                        self.restore()
                    }
                    self.tableView.reloadData()
                    //self.listsretrieval()
                    
                }
                
                
                
                
                favimage = UIImage(named: "ICFavStarActive") as UIImage!
                cell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
            }
            
            
            ///// END TO DO ONLY
            
            
        }
        
        
        
        
    }
    
    
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
        
        return imagePath//"item\(Int(time)).png"
    }
    */
    
    func savingtodoitems(shopListItemsIn1: [String]) {
        
        //for var index = 0; index < ItemsInReceivedList.count; index++ {
        for var index = 0; index < shopListItemsIn1.count; index++ {
            var queryitem = PFQuery(className:"toDoItems")
            // queryitem.whereKey("objectId", equalTo: shopListItemsIn1[index])
            queryitem.whereKey("itemUUID", equalTo: shopListItemsIn1[index])
            queryitem.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    print("Successfully retrieved \(objects!.count) scores.")
                    
                    if let listitems = objects as? [PFObject] {
                        
                        for object in listitems {
                            print(object.objectId)
                            
                            object.pin()//InBackground()
     
                        }
                        
                    }
                    
                } else {
                    // Log details of the failure
                    self.restoresaving()
                    print("Error: \(error!) \(error!.userInfo)")
                    print("BITCH DOESNT WORK")
                }
            }
            
        } //end of for loop
        
        ////
        
    }
    
    
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
                imagePath = ""
                return imagePath//""
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    var imageToLoad = UIImage()
    /*
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let path = (dir as NSString).stringByAppendingPathComponent(imageName)
        
        if(!path.isEmpty){
            let image = UIImage(contentsOfFile: path)
            print(image);
            if(image != nil){
                //return image!;
                self.imageToLoad = image!
                return imageToLoad
            }
        }
        
        return imagestochoose[0].itemimage//UIImage(named: "activity.png")!
    }
    */
    
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


    
    
    func changinglistimages(shopListItemsIn1: [String]) {
        // this name means nothing, func only save all items to local datastore
       // pausesaving()
        //for var index = 0; index < ItemsInReceivedList.count; index++ {
        for var index = 0; index < shopListItemsIn1.count; index++ {
            var queryitem = PFQuery(className:"shopItems")
            // queryitem.whereKey("objectId", equalTo: shopListItemsIn1[index])
            queryitem.whereKey("itemUUID", equalTo: shopListItemsIn1[index])
            queryitem.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    print("Successfully retrieved \(objects!.count) scores.")
                    
                    if let listitems = objects as? [PFObject] {
                        
                        for object in listitems {
                            print(object.objectId)
                            
                            //bitch
                            
                            if var imageFile = object["itemImage"] as? PFFile {
                                // if imageFile != nil {
                                var imageData = imageFile.getData()
                                /*
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    thiscatpicture = image!
                                    
                                } else {
                                    thiscatpicture = imagestochoose[0].itemimage
                                }
                            } else {
                                thiscatpicture = imagestochoose[0].itemimage
                            }
                            */
                            self.saveImageLocally(imageData)
                                
                                object["imageLocalPath"] = self.imagePath
                            }
                            //self.saveImageLocally(imageData)
                                object.pin()  //InBackground()


                        }
                        //self.restoresaving()
                    }
                    
                } else {
                    // Log details of the failure
                    self.restoresaving()
                    print("Error: \(error!) \(error!.userInfo)")
                    print("BITCH DOESNT WORK")
                }
            }
            
        } //end of for loop
        
        ////
        
    }
    
    func newsavereceivedlist(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ReceivedListOld
        
        let indexPathSave = tableView.indexPathForCell(cell)
        
        if showoption == "alllists" {
            
            pausesaving()
            
            listtosave = UserLists[indexPathSave!.row].listid
            
            UserLists[indexPathSave!.row].listissaved = true
            UserLists[indexPathSave!.row].listconfirmreception = true
            
            if UserLists[indexPathSave!.row].listtype == "Shop" {
                
                
            //if let foundlist = find(lazy(UserShopLists).map({ $0.listid }), listtosave!) {
              if let foundlist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtosave!) {
                UserShopLists[foundlist].listissaved = true
                    UserShopLists[foundlist].listconfirmreception = true
                }
                
                 cell.receivedlistnamebutton.enabled = true
                
                //// now change in local datastore
                
                let querysave = PFQuery(className:"shopLists")
                querysave.whereKey("listUUID", equalTo: listtosave!)
                querysave.getFirstObjectInBackgroundWithBlock() {
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let shopList = shopList {
                        
                        self.ItemsInReceivedList = shopList["ItemsInTheShopList"] as! [String]
                        
                        print("List to load for changing \(self.ItemsInReceivedList)")
                        
                        self.changinglistimages(self.ItemsInReceivedList)
                        
                        shopList["isSaved"] = true
                        
                        /////////
                        
                        cell.receivedlistnamebutton.enabled = true
                        
                        shopList["confirmReception"] = true // WTF, I already had isSaved!
                        
                        
                        /////////
                        
                        //shopList.pinInBackground()
                        self.restoresaving()
                        shopList.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                self.restoresaving()
                            } else {
                                print("Failed!")
                            }
                        })
                        
                        
                        
                        shopList.saveEventually()
                        // shopList.saveInBackground()
                        //shopList.saveEventually()
                    }
                    //self.listsretrieval()
                    
                }
                
                tableView.reloadData()
                
                receivedshopscount -= 1
                
                //// end of changing in local datastore
                
            } else if UserLists[indexPathSave!.row].listtype == "ToDo" {
                
            //if let foundlist = find(lazy(UserToDoLists).map({ $0.listid }), listtosave!) {
                if let foundlist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtosave!) {
                    UserToDoLists[foundlist].listissaved = true
                    UserToDoLists[foundlist].listconfirmreception = true
                }
                
                 cell.receivedlistnamebutton.enabled = true
                
                let querysave = PFQuery(className:"toDoLists")
                querysave.whereKey("listUUID", equalTo: listtosave!)
                querysave.getFirstObjectInBackgroundWithBlock() {
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let todoList = todoList {
                        
                        todoList["isSaved"] = true
                        
                        cell.receivedlistnamebutton.enabled = true
                        
                        self.ItemsInReceivedList = todoList["ItemsInTheToDoList"] as! [String]
                        
                        self.savingtodoitems(self.ItemsInReceivedList)
                        
                        todoList["confirmReception"] = true // WTF, I already had isSaved!
                        
                        self.restoresaving()
                        todoList.pinInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                self.restoresaving()
                            } else {
                                print("Failed!")
                            }
                        })
                        
                        
                        
                        todoList.saveEventually()
                        // shopList.saveInBackground()
                        //shopList.saveEventually()
                    }
                    //self.listsretrieval()
                    
                }
                
                tableView.reloadData()
                
                 receivedtodocount -= 1
            }
            
        }
        else if showoption == "shoplists" {
            
            
            pausesaving()
            
            listtosave = UserShopLists[indexPathSave!.row].listid
            
            UserShopLists[indexPathSave!.row].listissaved = true
            UserShopLists[indexPathSave!.row].listconfirmreception = true
            
           // if let foundlist = find(lazy(UserLists).map({ $0.listid }), listtosave!) {
             if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtosave!) {
            UserLists[foundlist].listissaved = true
                UserLists[foundlist].listconfirmreception = true
            }
            
             cell.receivedlistnamebutton.enabled = true
            
            //// now change in local datastore
            
            let querysave = PFQuery(className:"shopLists")
            querysave.whereKey("listUUID", equalTo: listtosave!)
            querysave.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
                    self.ItemsInReceivedList = shopList["ItemsInTheShopList"] as! [String]
                    
                    print("List to load for changing \(self.ItemsInReceivedList)")
                    
                    self.changinglistimages(self.ItemsInReceivedList)
                    
                    shopList["isSaved"] = true
                    
                    /////////
                    
                    cell.receivedlistnamebutton.enabled = true
                    
                    shopList["confirmReception"] = true // WTF, I already had isSaved!
                    
                    
                    /////////
                    
                    //shopList.pinInBackground()
                    
                    shopList.pinInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            self.restoresaving()
                        } else {
                            print("Failed!")
                        }
                    })
                    
                    
                    
                    shopList.saveEventually()
                    // shopList.saveInBackground()
                    //shopList.saveEventually()
                }
                //self.listsretrieval()
                
            }
            
            tableView.reloadData()
            
            receivedshopscount -= 1
            
        }
        else if showoption == "todolists" {
            
            pausesaving()
            
            listtosave = UserToDoLists[indexPathSave!.row].listid

            UserToDoLists[indexPathSave!.row].listissaved = true
            UserToDoLists[indexPathSave!.row].listconfirmreception = true
            
           // if let foundlist = find(lazy(UserLists).map({ $0.listid }), listtosave!) {
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtosave!) {
            UserLists[foundlist].listissaved = true
                UserLists[foundlist].listconfirmreception = true
            }

            cell.receivedlistnamebutton.enabled = true
            
            let querysave = PFQuery(className:"toDoLists")
            querysave.whereKey("listUUID", equalTo: listtosave!)
            querysave.getFirstObjectInBackgroundWithBlock() {
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let todoList = todoList {
                    
                    self.ItemsInReceivedList = todoList["ItemsInTheToDoList"] as! [String]
                    
                    self.savingtodoitems(self.ItemsInReceivedList)
                    
                    todoList["isSaved"] = true
                    
                    cell.receivedlistnamebutton.enabled = true
                    
                    todoList["confirmReception"] = true // WTF, I already had isSaved!
                    
                    
                    todoList.pinInBackgroundWithBlock({ (success, error) -> Void in
                        if success {
                            self.restoresaving()
                        } else {
                            print("Failed!")
                        }
                    })
                    
                    
                    
                    todoList.saveEventually()
                    // shopList.saveInBackground()
                    //shopList.saveEventually()
                }
                //self.listsretrieval()
                
            }

            tableView.reloadData()
            
            receivedtodocount -= 1
            
        }
        
        receivedcount -= 1
        
        //cell.sharereceivedlist.enabled = false
        //cell.sharereceivedlist.hidden = true
        
        cell.addtofavs.hidden = false
        
        cell.acceptlist.hidden = true
        cell.listnote.hidden = false
        
        
        
    }

    /*
    func savereceivedlist(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathSave = tableView.indexPathForCell(cell)
        
        if showoption == "alllists" {
            listtosave = UserLists[indexPathSave!.row].listid
            
        }
        else if showoption == "shoplists" {
            listtosave = UserShopLists[indexPathSave!.row].listid
        }
        else if showoption == "todolists" {
            listtosave = UserToDoLists[indexPathSave!.row].listid
        }
        
        if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtosave!) {
            UserLists[foundlist].listissaved = true
            UserLists[foundlist].listconfirmreception = true
        }
        if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtosave!) {
            UserShopLists[foundshoplist].listissaved = true
            UserShopLists[foundshoplist].listconfirmreception = true
        }
        
        
        var querysave = PFQuery(className:"shopLists")
        querysave.whereKey("listUUID", equalTo: listtosave!)
        querysave.getFirstObjectInBackgroundWithBlock() {
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                self.ItemsInReceivedList = shopList["ItemsInTheShopList"] as! [String]
                
                println("List to load for changing \(self.ItemsInReceivedList)")
                
                self.changinglistimages(self.ItemsInReceivedList)
                
                shopList["isSaved"] = true
                
                /////////
                
                cell.receivedlistnamebutton.enabled = true
                
                shopList["confirmReception"] = true // WTF, I already had isSaved!
                
                
                /////////
                
                shopList.pinInBackground()
                shopList.saveEventually()
                // shopList.saveInBackground()
                //shopList.saveEventually()
            }
            //self.listsretrieval()
            
        }
        
        tableView.reloadData()
        
    }
    
    
    func savereceivedtodolist(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathSave = tableView.indexPathForCell(cell)
        
       // listtosave = ListsIds[indexPathSave!.row]
        
        if showoption == "alllists" {
            listtosave = UserLists[indexPathSave!.row].listid


        }
        else if showoption == "shoplists" {
            listtosave = UserShopLists[indexPathSave!.row].listid
        }
        else if showoption == "todolists" {
            listtosave = UserToDoLists[indexPathSave!.row].listid
        }
        
        if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtosave!) {
            UserLists[foundlist].listissaved = true
            UserLists[foundlist].listconfirmreception = true
        }
        if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtosave!) {
            UserToDoLists[foundtodolist].listissaved = true
            UserToDoLists[foundtodolist].listconfirmreception = true
        }


        
        
        var querysave = PFQuery(className:"toDoLists")
        
        querysave.whereKey("listUUID", equalTo: listtosave!)
        querysave.getFirstObjectInBackgroundWithBlock() {
            (todoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let todoList = todoList {
                
                
                todoList["isSaved"] = true
                
                /////////
                
                cell.receivedlistnamebutton.enabled = true
                
                todoList["confirmReception"] = true // WTF, I already had isSaved!
                
                
                /////////
                
                todoList.pinInBackground()
                todoList.saveEventually()
                
            }
            
            
        }
        
        tableView.reloadData()
    }
*/

    /*
    func deletereceivedlist(sender: UIButton!) {
        
        //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        //let innerview = view.superview!
       // let cell = innerview.superview as! ShopListCellNew
        let indexPathReceivedDelete = tableView.indexPathForCell(cell)
        
        if showoption == "alllists" {
            listtodelete = UserLists[indexPathReceivedDelete!.row].listid
            UserLists.removeAtIndex(indexPathReceivedDelete!.row)
            
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            
        }
        else if showoption == "shoplists" {
            listtodelete = UserShopLists[indexPathReceivedDelete!.row].listid
            UserShopLists.removeAtIndex(indexPathReceivedDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
          ///  if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
             //   UserToDoLists.removeAtIndex(foundtodolist)
            //}
            
        }
        else if showoption == "todolists" {
            listtodelete = UserToDoLists[indexPathReceivedDelete!.row].listid
            UserToDoLists.removeAtIndex(indexPathReceivedDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            //if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
              //  UserShopLists.removeAtIndex(foundshoplist)
           // }
            
        }
        

        
        
        //var arrayofusers = ListsBelongsToUsers[indexPathDelete!.row]
        dispatch_async(dispatch_get_main_queue(), {
            var query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            //query.getObjectInBackgroundWithId(self.listtodelete!) {
            
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let shopList = shopList {
                    //shopList.deleteInBackground()
                    shopList["isDeleted"] = true
                    shopList.saveEventually()
                    
                    
                }
                
            }
        })
        var query2 = PFQuery(className:"shopLists")
        query2.fromLocalDatastore()
        //  query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {
            
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                shopList.unpinInBackground()
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathReceivedDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        
 
    }
    
    
    func deletereceivedtodolist(sender: UIButton!) {
        
        pausedeleting()
        
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! ReceivedListOld
        let indexPathReceivedDelete = tableView.indexPathForCell(cell)
        
       
        
        if showoption == "alllists" {
            listtodelete = UserLists[indexPathReceivedDelete!.row].listid
            UserLists.removeAtIndex(indexPathReceivedDelete!.row)
            
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            
        }
        else if showoption == "shoplists" {
            listtodelete = UserShopLists[indexPathReceivedDelete!.row].listid
            UserShopLists.removeAtIndex(indexPathReceivedDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            
        }
        else if showoption == "todolists" {
            listtodelete = UserToDoLists[indexPathReceivedDelete!.row].listid
            UserToDoLists.removeAtIndex(indexPathReceivedDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }
            
        }
        
        
        
        //var arrayofusers = ListsBelongsToUsers[indexPathDelete!.row]
        dispatch_async(dispatch_get_main_queue(), {
            var query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            //query.getObjectInBackgroundWithId(self.listtodelete!) {
            
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let todoList = todoList {
                    //shopList.deleteInBackground()
                    todoList["isDeleted"] = true
                    todoList.saveEventually()
                    
                    
                }
                
            }
        })
        var query2 = PFQuery(className:"toDoLists")
        query2.fromLocalDatastore()
        //  query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {
            
            (todoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let todoList = todoList {
                todoList.unpinInBackground()
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathReceivedDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        restoredel()
        
    }
    */
    
    func newdeletereceivedlist(sender: UIButton!) {
        
        // pausedeleting()
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        //let cell = innerview.superview as! ShopListCellNew
        let cell = innerview.superview as! ReceivedListOld
        let indexPathDelete = tableView.indexPathForCell(cell)
        print(indexPathDelete)
        
        if showoption == "alllists" {
            //ALLLISTS
            
            listtodelete = UserLists[indexPathDelete!.row].listid
            
            // UserLists.removeAtIndex(indexPathDelete!.row)
            
            if UserLists[indexPathDelete!.row].listtype == "Shop" {
                //Alllists. If shoplist
                
                
               // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                
                if var foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
                }
                //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                //    UserToDoLists.removeAtIndex(foundtodolist)
                // }
                
                
                
                var query2 = PFQuery(className:"shopLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let shopList = shopList {
                        
                        shopList.unpinInBackground()
                        
                        
                    }
                    
                }
                
                // set to deleted in Parse
                var query = PFQuery(className:"shopLists")
                query.fromLocalDatastore()
                // query.getObjectInBackgroundWithId(self.listtodelete!) {
                query.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query.getFirstObjectInBackgroundWithBlock() {
                    
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let shopList = shopList {
                        
                        //shopList.deleteInBackground()
                        shopList["isDeleted"] = true
                        shopList.saveEventually()
                        
                    }
                    
                }

                ////// NOW DELETE ALL ITEMS
                dispatch_async(dispatch_get_main_queue(), {
                    //self.countreceivedlists()
                    // self.checkreceivedlists()
                    
                    
                    var query3 = PFQuery(className:"shopItems")
                    query3.fromLocalDatastore()
                    query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                    query3.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let items = objects as? [PFObject] {
                                for object in items {
                                    
                                    // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                        
                                        object["isDeleted"] = true
                                        
                                        object.unpinInBackground()
                                        
                                      //  object.saveEventually()
                                        
                                    }
                                    
                                }
                                
                                
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }) // end of dispatch

                
            } else if UserLists[indexPathDelete!.row].listtype == "ToDo" {
                // Alllists. If To do
                
                // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                //   UserShopLists.removeAtIndex(foundshoplist)
                //}
               // if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                if var foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                    UserToDoLists.removeAtIndex(foundtodolist)
                }
                
                
                
                var query2 = PFQuery(className:"toDoLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let todoList = todoList {
                        
                        todoList.unpinInBackground()
                        
                        
                    }
                    
                }
                
                //First set to deleted in Parse
                var query = PFQuery(className:"toDoLists")
                query.fromLocalDatastore()
                // query.getObjectInBackgroundWithId(self.listtodelete!) {
                query.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query.getFirstObjectInBackgroundWithBlock() {
                    
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let todoList = todoList {
                        
                        //shopList.deleteInBackground()
                        todoList["isDeleted"] = true
                       //// todoList.saveEventually()
                        
                    }
                    
                }
                ////

                
                ////// NOW DELETE ALL ITEMS
                dispatch_async(dispatch_get_main_queue(), {
                    //self.countreceivedlists()
                    // self.checkreceivedlists()
                    
                    
                    var query3 = PFQuery(className:"toDoItems")
                    query3.fromLocalDatastore()
                    query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                    query3.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let items = objects as? [PFObject] {
                                for object in items {
                                    
                               
                                        
                                        object["isDeleted"] = true
                                        
                                        object.unpinInBackground()
                                        
                                      //  object.saveEventually()
                                        
                                    
                                    
                                }
                                
                                
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }) // end of dispatch

                
                
            }
            
            UserLists.removeAtIndex(indexPathDelete!.row)
            
            
            
        } else if showoption == "shoplists" {
            //SHOPLISTS
            
            listtodelete = UserShopLists[indexPathDelete!.row].listid
            
            UserShopLists.removeAtIndex(indexPathDelete!.row)
            
            //Alllists. If shoplist
            
            
            //if var foundshoplist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
             if var foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserLists.removeAtIndex(foundshoplist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            //    UserToDoLists.removeAtIndex(foundtodolist)
            // }
            
            
            
            var query2 = PFQuery(className:"shopLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
        
                    ////
                    
                    shopList.unpinInBackground()
                    
                    
                }
                
            }
            
            //First set to deleted in Parse
            var query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            // query.getObjectInBackgroundWithId(self.listtodelete!) {
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
                    //shopList.deleteInBackground()
                    shopList["isDeleted"] = true
                  //  shopList.saveEventually()
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"shopItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                
                                if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                   // object.saveEventually()
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch

            
            
        } else if showoption == "todolists" {
            //TODOLISTS
            
            listtodelete = UserToDoLists[indexPathDelete!.row].listid
            
            UserToDoLists.removeAtIndex(indexPathDelete!.row)
            
            //if var foundtodolist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            
            if var foundtodolist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserLists.removeAtIndex(foundtodolist)
            }
            
            
            
            var query2 = PFQuery(className:"toDoLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let todoList = todoList {
                    
                
                    ////
                    
                    todoList.unpinInBackground()
                    
                    
                }
                
            }
            
            //First set to deleted in Parse
            var query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            // query.getObjectInBackgroundWithId(self.listtodelete!) {
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let todoList = todoList {
                    
                    //shopList.deleteInBackground()
                    todoList["isDeleted"] = true
                   //// todoList.saveEventually()
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"toDoItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                             
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                   // object.saveEventually()
                                    
                                
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch

            
            
        } else if showoption == "favs" {
            //SHOPLISTS
            
            listtodelete = UserFavLists[indexPathDelete!.row].listid
            
            UserFavLists.removeAtIndex(indexPathDelete!.row)
            
            //Alllists. If shoplist
            
            
            //if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            if var foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                
            UserLists.removeAtIndex(foundlist)
            }
            
           // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
            if var foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserShopLists.removeAtIndex(foundshoplist)
            }
           // if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            if var foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserToDoLists.removeAtIndex(foundtodolist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            //    UserToDoLists.removeAtIndex(foundtodolist)
            // }
            
            
            
            var query2 = PFQuery(className:"shopLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
                    //First set to deleted in Parse
                    var query = PFQuery(className:"shopLists")
                    query.fromLocalDatastore()
                    // query.getObjectInBackgroundWithId(self.listtodelete!) {
                    query.whereKey("listUUID", equalTo: self.listtodelete!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let shopList = shopList {
                            
                            //shopList.deleteInBackground()
                            shopList["isDeleted"] = true
                           // shopList.saveEventually()
                            
                        }
                        
                    }
                    ////
                    
                    shopList.unpinInBackground()
                    
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"shopItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                
                                if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                  //  object.saveEventually()
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch
            
            
        }

        
        
        self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.reloadData()
        
    }
    
    
    func newdeletelist(sender: UIButton!) {
        
       // pausedeleting()
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ShopListCellNew
       // let cell = view.superview as! ShopListCellNew
        let indexPathDelete = tableView.indexPathForCell(cell)
        print(indexPathDelete)
        
        if showoption == "alllists" {
            //ALLLISTS
            
            listtodelete = UserLists[indexPathDelete!.row].listid
            
           // UserLists.removeAtIndex(indexPathDelete!.row)
            
            if UserLists[indexPathDelete!.row].listtype == "Shop" {
                //Alllists. If shoplist
                
                
               // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                
                if var foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
                }
                //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                //    UserToDoLists.removeAtIndex(foundtodolist)
               // }
                

                
                var query2 = PFQuery(className:"shopLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let shopList = shopList {
                        
                        //First set to deleted in Parse
                        var query = PFQuery(className:"shopLists")
                        query.fromLocalDatastore()
                        // query.getObjectInBackgroundWithId(self.listtodelete!) {
                        query.whereKey("listUUID", equalTo: self.listtodelete!)
                        // queryfav.getObjectInBackgroundWithId(listtofav!) {
                        query.getFirstObjectInBackgroundWithBlock() {
                            
                            (shopList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let shopList = shopList {
                                
                                //shopList.deleteInBackground()
                                shopList["isDeleted"] = true
                              //  shopList.saveEventually()
                                
                            }
                            
                        }
                        ////
                        
                        shopList.unpinInBackground()
                        
                        
                    }
                    
                }

                ////// NOW DELETE ALL ITEMS
                dispatch_async(dispatch_get_main_queue(), {
                    //self.countreceivedlists()
                    // self.checkreceivedlists()
                    
                    
                    var query3 = PFQuery(className:"shopItems")
                    query3.fromLocalDatastore()
                    query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                    query3.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let items = objects as? [PFObject] {
                                for object in items {
                                    
                                    // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                        
                                        object["isDeleted"] = true
                                        
                                        object.unpinInBackground()
                                        
                                      //  object.saveEventually()
                                        
                                    }
                                    
                                }
                                
                                
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }) // end of dispatch

                
                
            } else if UserLists[indexPathDelete!.row].listtype == "ToDo" {
                // Alllists. If To do
                
               // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                 //   UserShopLists.removeAtIndex(foundshoplist)
                //}
              //  if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                
                if var foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
                 }
                
                
                
                var query2 = PFQuery(className:"toDoLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let todoList = todoList {
                        
                        //First set to deleted in Parse
                        var query = PFQuery(className:"toDoLists")
                        query.fromLocalDatastore()
                        // query.getObjectInBackgroundWithId(self.listtodelete!) {
                        query.whereKey("listUUID", equalTo: self.listtodelete!)
                        // queryfav.getObjectInBackgroundWithId(listtofav!) {
                        query.getFirstObjectInBackgroundWithBlock() {
                            
                            (todoList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let todoList = todoList {
                                
                                //shopList.deleteInBackground()
                                todoList["isDeleted"] = true
                               // todoList.saveEventually()
                                
                            }
                            
                        }
                        ////
                        
                        todoList.unpinInBackground()
                        
                        
                    }
                    
                }
                
                ////// NOW DELETE ALL ITEMS
                dispatch_async(dispatch_get_main_queue(), {
                    //self.countreceivedlists()
                    // self.checkreceivedlists()
                    
                    
                    var query3 = PFQuery(className:"toDoItems")
                    query3.fromLocalDatastore()
                    query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                    query3.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let items = objects as? [PFObject] {
                                for object in items {
    
                                        
                                        object["isDeleted"] = true
                                        
                                        object.unpinInBackground()
                                        
                                     //   object.saveEventually()
                                        
                                    
                                    
                                }
                                
                                
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }) // end of dispatch

                
            }
            
            UserLists.removeAtIndex(indexPathDelete!.row)
            
        } else if showoption == "shoplists" {
            //SHOPLISTS
            
            listtodelete = UserShopLists[indexPathDelete!.row].listid
            
            UserShopLists.removeAtIndex(indexPathDelete!.row)
            
                //Alllists. If shoplist
                
                
               // if var foundshoplist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            if var foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserLists.removeAtIndex(foundshoplist)
                }
                //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                //    UserToDoLists.removeAtIndex(foundtodolist)
                // }
                
                
                
                var query2 = PFQuery(className:"shopLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let shopList = shopList {
                        
                        //First set to deleted in Parse
                        var query = PFQuery(className:"shopLists")
                        query.fromLocalDatastore()
                        // query.getObjectInBackgroundWithId(self.listtodelete!) {
                        query.whereKey("listUUID", equalTo: self.listtodelete!)
                        // queryfav.getObjectInBackgroundWithId(listtofav!) {
                        query.getFirstObjectInBackgroundWithBlock() {
                            
                            (shopList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let shopList = shopList {
                                
                                //shopList.deleteInBackground()
                                shopList["isDeleted"] = true
                               // shopList.saveEventually()
                                
                            }
                            
                        }
                        ////
                        
                        shopList.unpinInBackground()
                        
                        
                    }
                    
                }
                
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"shopItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                
                                if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                 //   object.saveEventually()
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch
            
            
        } else if showoption == "todolists" {
            //TODOLISTS
            
            listtodelete = UserToDoLists[indexPathDelete!.row].listid
            
            UserToDoLists.removeAtIndex(indexPathDelete!.row)
            
            //if var foundtodolist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            
            if var foundtodolist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserLists.removeAtIndex(foundtodolist)
            }
            
            
            
            var query2 = PFQuery(className:"toDoLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let todoList = todoList {
                    
                    //First set to deleted in Parse
                    var query = PFQuery(className:"toDoLists")
                    query.fromLocalDatastore()
                    // query.getObjectInBackgroundWithId(self.listtodelete!) {
                    query.whereKey("listUUID", equalTo: self.listtodelete!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let todoList = todoList {
                            
                            //shopList.deleteInBackground()
                            todoList["isDeleted"] = true
                           // todoList.saveEventually()
                            
                        }
                        
                    }
                    ////
                    
                    todoList.unpinInBackground()
                    
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"toDoItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                
                                object["isDeleted"] = true
                                
                                object.unpinInBackground()
                                
                              //  object.saveEventually()
                                
                                
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch


        } else if showoption == "favs" {
            //SHOPLISTS
            
            listtodelete = UserFavLists[indexPathDelete!.row].listid
            
            UserFavLists.removeAtIndex(indexPathDelete!.row)
            
            //Alllists. If shoplist
            
            
            //if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
             if var foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserLists.removeAtIndex(foundlist)
            }
            
          //  if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
            if var foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {

            UserShopLists.removeAtIndex(foundshoplist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            
            if var foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
            UserToDoLists.removeAtIndex(foundtodolist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            //    UserToDoLists.removeAtIndex(foundtodolist)
            // }
            
            
            
            var query2 = PFQuery(className:"shopLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
                    //First set to deleted in Parse
                    var query = PFQuery(className:"shopLists")
                    query.fromLocalDatastore()
                    // query.getObjectInBackgroundWithId(self.listtodelete!) {
                    query.whereKey("listUUID", equalTo: self.listtodelete!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let shopList = shopList {
                            
                            //shopList.deleteInBackground()
                            shopList["isDeleted"] = true
                          //  shopList.saveEventually()
                            
                        }
                        
                    }
                    ////
                    
                    shopList.unpinInBackground()
                    
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"shopItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                
                                if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                //    object.saveEventually()
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch
            
            
        }

        
         self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
         self.tableView.reloadData()
        
    }
    
    
    /////// SWIPE DELETE USUAL
    
    
    func swipedeleteusual(indexPathDelete: NSIndexPath) {
        
        // pausedeleting()
        
        
        print(indexPathDelete)
        
        if showoption == "alllists" {
            //ALLLISTS
            
            listtodelete = UserLists[indexPathDelete.row].listid
            
            // UserLists.removeAtIndex(indexPathDelete!.row)
            
            if UserLists[indexPathDelete.row].listtype == "Shop" {
                //Alllists. If shoplist
                
                
                // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                
                if var foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                    UserShopLists.removeAtIndex(foundshoplist)
                }
                //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                //    UserToDoLists.removeAtIndex(foundtodolist)
                // }
                
                
                
                var query2 = PFQuery(className:"shopLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (shopList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let shopList = shopList {
                        
                        //First set to deleted in Parse
                        var query = PFQuery(className:"shopLists")
                        query.fromLocalDatastore()
                        // query.getObjectInBackgroundWithId(self.listtodelete!) {
                        query.whereKey("listUUID", equalTo: self.listtodelete!)
                        // queryfav.getObjectInBackgroundWithId(listtofav!) {
                        query.getFirstObjectInBackgroundWithBlock() {
                            
                            (shopList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let shopList = shopList {
                                
                                //shopList.deleteInBackground()
                                shopList["isDeleted"] = true
                               // shopList.saveEventually()
                                
                            }
                            
                        }
                        ////
                        
                        shopList.unpinInBackground()
                        
                        
                    }
                    
                }
                
                ////// NOW DELETE ALL ITEMS
                dispatch_async(dispatch_get_main_queue(), {
                    //self.countreceivedlists()
                    // self.checkreceivedlists()
                    
                    
                    var query3 = PFQuery(className:"shopItems")
                    query3.fromLocalDatastore()
                    query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                    query3.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let items = objects as? [PFObject] {
                                for object in items {
                                    
                                    // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                        
                                        object["isDeleted"] = true
                                        
                                        object.unpinInBackground()
                                        
                                      //  object.saveEventually()
                                        
                                    }
                                    
                                }
                                
                                
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }) // end of dispatch
                
                
                
            } else if UserLists[indexPathDelete.row].listtype == "ToDo" {
                // Alllists. If To do
                
                // if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                //   UserShopLists.removeAtIndex(foundshoplist)
                //}
                //  if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                
                if var foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                    UserToDoLists.removeAtIndex(foundtodolist)
                }
                
                
                
                var query2 = PFQuery(className:"toDoLists")
                query2.fromLocalDatastore()
                // query2.getObjectInBackgroundWithId(listtodelete!) {
                query2.whereKey("listUUID", equalTo: self.listtodelete!)
                // queryfav.getObjectInBackgroundWithId(listtofav!) {
                query2.getFirstObjectInBackgroundWithBlock() {
                    
                    (todoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let todoList = todoList {
                        
                        //First set to deleted in Parse
                        var query = PFQuery(className:"toDoLists")
                        query.fromLocalDatastore()
                        // query.getObjectInBackgroundWithId(self.listtodelete!) {
                        query.whereKey("listUUID", equalTo: self.listtodelete!)
                        // queryfav.getObjectInBackgroundWithId(listtofav!) {
                        query.getFirstObjectInBackgroundWithBlock() {
                            
                            (todoList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let todoList = todoList {
                                
                                //shopList.deleteInBackground()
                                todoList["isDeleted"] = true
                             //   todoList.saveEventually()
                                
                            }
                            
                        }
                        ////
                        
                        todoList.unpinInBackground()
                        
                        
                    }
                    
                }
                
                ////// NOW DELETE ALL ITEMS
                dispatch_async(dispatch_get_main_queue(), {
                    //self.countreceivedlists()
                    // self.checkreceivedlists()
                    
                    
                    var query3 = PFQuery(className:"toDoItems")
                    query3.fromLocalDatastore()
                    query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                    query3.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let items = objects as? [PFObject] {
                                for object in items {
                                    
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                 //   object.saveEventually()
                                    
                                    
                                    
                                }
                                
                                
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                    
                }) // end of dispatch
                
                
            }
            
            UserLists.removeAtIndex(indexPathDelete.row)
            
        } else if showoption == "shoplists" {
            //SHOPLISTS
            
            listtodelete = UserShopLists[indexPathDelete.row].listid
            
            UserShopLists.removeAtIndex(indexPathDelete.row)
            
            //Alllists. If shoplist
            
            
            // if var foundshoplist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            if var foundshoplist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserLists.removeAtIndex(foundshoplist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            //    UserToDoLists.removeAtIndex(foundtodolist)
            // }
            
            
            
            var query2 = PFQuery(className:"shopLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
                    //First set to deleted in Parse
                    var query = PFQuery(className:"shopLists")
                    query.fromLocalDatastore()
                    // query.getObjectInBackgroundWithId(self.listtodelete!) {
                    query.whereKey("listUUID", equalTo: self.listtodelete!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let shopList = shopList {
                            
                            //shopList.deleteInBackground()
                            shopList["isDeleted"] = true
                          ////  shopList.saveEventually()
                            
                        }
                        
                    }
                    ////
                    
                    shopList.unpinInBackground()
                    
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"shopItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                
                                if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                  //  object.saveEventually()
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch
            
            
        } else if showoption == "todolists" {
            //TODOLISTS
            
            listtodelete = UserToDoLists[indexPathDelete.row].listid
            
            UserToDoLists.removeAtIndex(indexPathDelete.row)
            
            //if var foundtodolist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            
            if var foundtodolist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserLists.removeAtIndex(foundtodolist)
            }
            
            
            
            var query2 = PFQuery(className:"toDoLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (todoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let todoList = todoList {
                    
                    //First set to deleted in Parse
                    var query = PFQuery(className:"toDoLists")
                    query.fromLocalDatastore()
                    // query.getObjectInBackgroundWithId(self.listtodelete!) {
                    query.whereKey("listUUID", equalTo: self.listtodelete!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (todoList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let todoList = todoList {
                            
                            //shopList.deleteInBackground()
                            todoList["isDeleted"] = true
                           // todoList.saveEventually()
                            
                        }
                        
                    }
                    ////
                    
                    todoList.unpinInBackground()
                    
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"toDoItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                
                                object["isDeleted"] = true
                                
                                object.unpinInBackground()
                                
                              //  object.saveEventually()
                                
                                
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch
            
            
        } else if showoption == "favs" {
            //SHOPLISTS
            
            listtodelete = UserFavLists[indexPathDelete.row].listid
            
            UserFavLists.removeAtIndex(indexPathDelete.row)
            
            //Alllists. If shoplist
            
            
            //if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
            if var foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            
            //  if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
            if var foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                
                UserShopLists.removeAtIndex(foundshoplist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            
            if var foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            //if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
            //    UserToDoLists.removeAtIndex(foundtodolist)
            // }
            
            
            
            var query2 = PFQuery(className:"shopLists")
            query2.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query2.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query2.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    
                    //First set to deleted in Parse
                    var query = PFQuery(className:"shopLists")
                    query.fromLocalDatastore()
                    // query.getObjectInBackgroundWithId(self.listtodelete!) {
                    query.whereKey("listUUID", equalTo: self.listtodelete!)
                    // queryfav.getObjectInBackgroundWithId(listtofav!) {
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let shopList = shopList {
                            
                            //shopList.deleteInBackground()
                            shopList["isDeleted"] = true
                           // shopList.saveEventually()
                            
                        }
                        
                    }
                    ////
                    
                    shopList.unpinInBackground()
                    
                    
                }
                
            }
            
            
            ////// NOW DELETE ALL ITEMS
            dispatch_async(dispatch_get_main_queue(), {
                //self.countreceivedlists()
                // self.checkreceivedlists()
                
                
                var query3 = PFQuery(className:"shopItems")
                query3.fromLocalDatastore()
                query3.whereKey("ItemsList", equalTo: self.listtodelete!)
                query3.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        if let items = objects as? [PFObject] {
                            for object in items {
                                
                                // if ((object["isFav"] as! Bool) == false) && (((object["isHistory"] as! Bool) == false) && ((object["chosenFromHistory"] as! Bool) == true)) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                
                                if ((object["isFav"] as! Bool) == false) && ((object["isHistory"] as! Bool) == false) && ((object["isDeleted"] as! Bool) == false) && (((object["chosenFromFavs"] as! Bool) == true) || ((object["chosenFromHistory"] as! Bool) == true)) {
                                    
                                    object["isDeleted"] = true
                                    
                                    object.unpinInBackground()
                                    
                                  //  object.saveEventually()
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            }) // end of dispatch
            
            
        }
        
        
        self.tableView.deleteRowsAtIndexPaths([indexPathDelete], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.reloadData()
        
    }
    
    
    
    //////////
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    /*
    func deletelist(sender: UIButton!) {
        
        //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        
        pausedeleting()
        
        var button = sender as UIButton
        var view = button.superview!
        var innerview = view.superview!
        var cell = innerview.superview as! ShopListCellNew
        var indexPathDelete = tableView.indexPathForCell(cell)
        println(indexPathDelete)

        //let cell = view.superview as! ShopListCellNew
        
       // let nextvview = view.subview
       
        
        if showoption == "alllists" {
            
            
            println(indexPathDelete)
            
            println(indexPathDelete!.row)
            
            
            listtodelete = UserLists[indexPathDelete!.row].listid
            
            UserLists.removeAtIndex(indexPathDelete!.row)
            
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            
            
            
        }
        else if showoption == "shoplists" {

            listtodelete = UserShopLists[indexPathDelete!.row].listid
            UserShopLists.removeAtIndex(indexPathDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            
         

            
        }
        else if showoption == "todolists" {

            listtodelete = UserToDoLists[indexPathDelete!.row].listid
            UserToDoLists.removeAtIndex(indexPathDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }
            
           

            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), {
            var query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            // query.getObjectInBackgroundWithId(self.listtodelete!) {
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let shopList = shopList {
                    
                    //shopList.deleteInBackground()
                    shopList["isDeleted"] = true
                    shopList.saveEventually()
                    
                }
                
            }
        })
        
        var query2 = PFQuery(className:"shopLists")
        query2.fromLocalDatastore()
        // query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {
            
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let shopList = shopList {
                
                shopList.unpinInBackground()
                
                
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)

      self.tableView.reloadData()
        self.restoredel()
        
        println(UserLists.map({ $0.listtype }))
        println(UserShopLists.map({ $0.listtype }))
        println(UserToDoLists.map({ $0.listtype }))

    }
    

    
  
    func deletetodolist(sender: UIButton!) {
        pausedeleting()
        var button = sender as UIButton
        var view = button.superview!
       // let cell = view.superview as! ShopListCellNew
        var innerview = view.superview!
        var cell = innerview.superview as! ShopListCellNew
        var indexPathToDoDelete = tableView.indexPathForCell(cell)
        
        println(indexPathToDoDelete)
        
        println(indexPathToDoDelete!.row)
        
        if showoption == "alllists" {
            listtodelete = UserLists[indexPathToDoDelete!.row].listid
             UserLists.removeAtIndex(indexPathToDoDelete!.row)
            
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }
            
        }
        else if showoption == "shoplists" {
            listtodelete = UserShopLists[indexPathToDoDelete!.row].listid
             UserShopLists.removeAtIndex(indexPathToDoDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            if var foundtodolist = find(lazy(UserToDoLists).map({ $0.listid }), listtodelete!) {
                UserToDoLists.removeAtIndex(foundtodolist)
            }

        }
        else if showoption == "todolists" {
          listtodelete = UserToDoLists[indexPathToDoDelete!.row].listid
            UserToDoLists.removeAtIndex(indexPathToDoDelete!.row)
            
            if var foundlist = find(lazy(UserLists).map({ $0.listid }), listtodelete!) {
                UserLists.removeAtIndex(foundlist)
            }
            if var foundshoplist = find(lazy(UserShopLists).map({ $0.listid }), listtodelete!) {
                UserShopLists.removeAtIndex(foundshoplist)
            }

        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), {
            var query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            // query.getObjectInBackgroundWithId(self.listtodelete!) {
            query.whereKey("listUUID", equalTo: self.listtodelete!)
            // queryfav.getObjectInBackgroundWithId(listtofav!) {
            query.getFirstObjectInBackgroundWithBlock() {
                
                (toDoList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let toDoList = toDoList {
                    
                    //shopList.deleteInBackground()
                    toDoList["isDeleted"] = true
                    toDoList.saveEventually()
                    
                }
                
            }
        })
        
        var query2 = PFQuery(className:"toDoLists")
        query2.fromLocalDatastore()
        // query2.getObjectInBackgroundWithId(listtodelete!) {
        query2.whereKey("listUUID", equalTo: self.listtodelete!)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query2.getFirstObjectInBackgroundWithBlock() {
            
            (toDoList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let toDoList = toDoList {
                
                toDoList.unpinInBackground()
                
                
            }
            
        }
        
        self.tableView.deleteRowsAtIndexPaths([indexPathToDoDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)

         self.tableView.reloadData()
        self.restoredel()
        
        println(UserLists.map({ $0.listtype }))
        println(UserShopLists.map({ $0.listtype }))
        println(UserToDoLists.map({ $0.listtype }))

    }

*/
    
    func newopenlistbynameselection(indexPathOpen: NSIndexPath) {
        
       
        /// SO FAR I DON'T REALLY USE listtoopen VARIABLE!
        
        if showoption == "alllists" {
            
            if UserLists[indexPathOpen.row].listisreceived == true {
                
                if UserLists[indexPathOpen.row].listconfirmreception == true {
                    
                    listtoopen = UserLists[indexPathOpen.row].listid
                    
                    if UserLists[indexPathOpen.row].listtype == "Shop" {
                        
                        self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                        
                    } else if UserLists[indexPathOpen.row].listtype == "ToDo" {
                        
                        self.performSegueWithIdentifier("ToDoOpenListSegue", sender: indexPathOpen)
                        
                    }

                    
                } else {
                    self.displayInfoAlert(NSLocalizedString("saveplease", comment: ""), message:NSLocalizedString("saveplease2", comment: ""))
                }
                
                
            } else {
            
            listtoopen = UserLists[indexPathOpen.row].listid
            
            if UserLists[indexPathOpen.row].listtype == "Shop" {
                
                self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                
            } else if UserLists[indexPathOpen.row].listtype == "ToDo" {
                
                self.performSegueWithIdentifier("ToDoOpenListSegue", sender: indexPathOpen)
                
            }
            
        }
        } else if showoption == "shoplists" {
            
            if UserShopLists[indexPathOpen.row].listisreceived == true {
                
                if UserShopLists[indexPathOpen.row].listconfirmreception == true {
                    listtoopen = UserShopLists[indexPathOpen.row].listid
                    
                    self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                } else {
                   self.displayInfoAlert(NSLocalizedString("saveplease", comment: ""), message:NSLocalizedString("saveplease2", comment: ""))
                }

                
            } else {
            
            listtoopen = UserShopLists[indexPathOpen.row].listid
            
            self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                
            }
            
        } else if showoption == "todolists" {
            
            if UserToDoLists[indexPathOpen.row].listisreceived == true {
                
                if UserToDoLists[indexPathOpen.row].listconfirmreception == true {
                    listtoopen = UserToDoLists[indexPathOpen.row].listid
                    
                    self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                } else {
                    self.displayInfoAlert(NSLocalizedString("saveplease", comment: ""), message:NSLocalizedString("saveplease2", comment: ""))
                }
                
                
            } else {

            
            listtoopen = UserToDoLists[indexPathOpen.row].listid
            
            self.performSegueWithIdentifier("ToDoOpenListSegue", sender: indexPathOpen)
                
            }
            
        } else if showoption == "favs" {
            
            if UserFavLists[indexPathOpen.row].listtype == "ToDo" {
            
            if UserFavLists[indexPathOpen.row].listisreceived == true {
                
                if UserFavLists[indexPathOpen.row].listconfirmreception == true {
                    listtoopen = UserFavLists[indexPathOpen.row].listid
                    
                    self.performSegueWithIdentifier("ToDoOpenListSegue", sender: indexPathOpen)
                } else {
                    self.displayInfoAlert(NSLocalizedString("saveplease", comment: ""), message:NSLocalizedString("saveplease2", comment: ""))
                }
                
                
            } else {
            
            listtoopen = UserFavLists[indexPathOpen.row].listid
            
            self.performSegueWithIdentifier("ToDoOpenListSegue", sender: indexPathOpen)
                
            }
            
            } else {
                
                if UserFavLists[indexPathOpen.row].listisreceived == true {
                    
                    if UserFavLists[indexPathOpen.row].listconfirmreception == true {
                        listtoopen = UserFavLists[indexPathOpen.row].listid
                        
                        self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                    } else {
                        self.displayInfoAlert(NSLocalizedString("saveplease", comment: ""), message:NSLocalizedString("saveplease2", comment: ""))
                    }
                    
                    
                } else {
                    
                    listtoopen = UserFavLists[indexPathOpen.row].listid
                    
                    self.performSegueWithIdentifier("OpenListSegue", sender: indexPathOpen)
                    
                }

            }
        }
        
        
    }
    
    func newopenlistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        //let cell = view.superview as! ShopListCellNew
        let innerview = view.superview!
        let cell = innerview.superview as! ShopListCellNew
        
        let indexPathOpen = tableView.indexPathForCell(cell)
        
        /// SO FAR I DON'T REALLY USE listtoopen VARIABLE!
        
        if showoption == "alllists" {
            
            listtoopen = UserLists[indexPathOpen!.row].listid
            
            if UserLists[indexPathOpen!.row].listtype == "Shop" {
            
                 self.performSegueWithIdentifier("OpenListSegue", sender: cell)
                
            } else if UserLists[indexPathOpen!.row].listtype == "ToDo" {
                
                self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
                
            }
            
        } else if showoption == "shoplists" {
            
             listtoopen = UserShopLists[indexPathOpen!.row].listid
            
             self.performSegueWithIdentifier("OpenListSegue", sender: cell)
            
        } else if showoption == "todolists" {
            
             listtoopen = UserToDoLists[indexPathOpen!.row].listid
            
             self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
            
        } else if showoption == "favs" {
            
            listtoopen = UserFavLists[indexPathOpen!.row].listid
            
            self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
        }

        
    }
    
    //newdeletereceivedlist
    //newsavereceivedlist
    //newopenreceivedlistbyname
    func newopenreceivedlistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        //let cell = view.superview as! ShopListCellNew
        let innerview = view.superview!
        let cell = innerview.superview as! ReceivedListOld
        
        let indexPathOpen = tableView.indexPathForCell(cell)
        
        /// SO FAR I DON'T REALLY USE listtoopen VARIABLE!
        
        if showoption == "alllists" {
            
            listtoopen = UserLists[indexPathOpen!.row].listid
            
            print(UserLists[indexPathOpen!.row].listtype)
            
            if UserLists[indexPathOpen!.row].listtype == "Shop" {
                
                self.performSegueWithIdentifier("OpenListSegue", sender: cell)
               
            } else if UserLists[indexPathOpen!.row].listtype == "ToDo" {
                
                self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
            
            }
            
            
            
        } else if showoption == "shoplists" {
            
            listtoopen = UserShopLists[indexPathOpen!.row].listid
            
            self.performSegueWithIdentifier("OpenListSegue", sender: cell)
            
        } else if showoption == "todolists" {
            
            listtoopen = UserToDoLists[indexPathOpen!.row].listid
            
            self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
            
        } else if showoption == "favs" {
            
            listtoopen = UserFavLists[indexPathOpen!.row].listid
            
            self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
        }
        
    }
    
    /*
    func openlistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        //let cell = view.superview as! ShopListCellNew
        let innerview = view.superview!
        let cell = innerview.superview as! ShopListCellNew
        
        var indexPathOpen = tableView.indexPathForCell(cell)
        
        self.performSegueWithIdentifier("OpenListSegue", sender: cell)
    }
    
    
    func opentodolistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
       // let cell = view.superview as! ShopListCellNew
        let innerview = view.superview!
        let cell = innerview.superview as! ShopListCellNew
        
        var indexPathOpen = tableView.indexPathForCell(cell)
        
        self.performSegueWithIdentifier("ToDoOpenListSegue", sender: cell)
    }
*/
    
    func openreceivedtodolistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let receivedcell = view.superview as! ReceivedListOld
        
        let indexPathReceivedOpen = tableView.indexPathForCell(receivedcell)
        
        self.performSegueWithIdentifier("ToDoOpenListSegue", sender: receivedcell)
    }
    
    
    
    func openreceivedlistbyname(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let receivedcell = view.superview as! ShopListCellNew
        
        let indexPathReceivedOpen = tableView.indexPathForCell(receivedcell)
        
        self.performSegueWithIdentifier("OpenListSegue", sender: receivedcell)
    }

    
    
    //////// TABLE CONFIGURATION
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if showoption == "alllists" {
            return UserLists.count
        }
        else if showoption == "shoplists" {
            return UserShopLists.count
        }
        else if showoption == "todolists" {
            return UserToDoLists.count
        } else if showoption == "favs" {
            return UserFavLists.count
        } else {

        return UserLists.count
        }
    }
    
    func sharelist(sender: UIButton!) {
        
        
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ShopListCellNew
        let indexPathShare = tableView.indexPathForCell(cell)
        
        if showoption == "alllists" {
            listtoshare = UserLists[indexPathShare!.row].listid
            listtosharetype = UserLists[indexPathShare!.row].listtype
        }
        else if showoption == "shoplists" {
            listtoshare = UserShopLists[indexPathShare!.row].listid
            listtosharetype = UserShopLists[indexPathShare!.row].listtype
        }
        else if showoption == "todolists" {
            listtoshare = UserToDoLists[indexPathShare!.row].listid
            listtosharetype = UserToDoLists[indexPathShare!.row].listtype
        }
        else if showoption == "favs" {
            listtoshare = UserFavLists[indexPathShare!.row].listid
            listtosharetype = UserFavLists[indexPathShare!.row].listtype
        }

        
        
        performSegueWithIdentifier("shareListSegue", sender: self)

        
    }
    
    
    func sharereceivedlist(sender: UIButton!) {
        
        
        
        let button = sender as UIButton
        let view = button.superview!
        let innerview = view.superview!
        let cell = innerview.superview as! ReceivedListOld
        let indexPathShare = tableView.indexPathForCell(cell)
        
        if showoption == "alllists" {
            listtoshare = UserLists[indexPathShare!.row].listid
            listtosharetype = UserLists[indexPathShare!.row].listtype
        }
        else if showoption == "shoplists" {
            listtoshare = UserShopLists[indexPathShare!.row].listid
            listtosharetype = UserShopLists[indexPathShare!.row].listtype
        }
        else if showoption == "todolists" {
            listtoshare = UserToDoLists[indexPathShare!.row].listid
            listtosharetype = UserToDoLists[indexPathShare!.row].listtype
        }
        else if showoption == "favs" {
            listtoshare = UserFavLists[indexPathShare!.row].listid
            listtosharetype = UserFavLists[indexPathShare!.row].listtype
        }
        
        
        performSegueWithIdentifier("shareListSegue", sender: self)
        
        
    }

    
    /*
    func closenotes(sender: UIButton!) {
        
        let button = sender as UIButton
        let view1 = button.superview!
        let view2 = view1.superview!
        
        view2.removeFromSuperview()
        
    }
    
    func showreceivednotes(sender: UIButton!) {
        
        let button = sender as UIButton
        let view1 = button.superview!
        let innerview = view1.superview!
        
        let cell = innerview.superview as! ReceivedListOld
        let indexPath = tableView.indexPathForCell(cell)
        
        var notetext = String()
        
        if showoption == "alllists" {
            notetext = UserLists[indexPath!.row].listnote
        } else if showoption == "shoplists" {
            notetext = UserShopLists[indexPath!.row].listnote
        } else if showoption == "todolists" {
            notetext = UserToDoLists[indexPath!.row].listnote
        } else if showoption == "favs" {
            notetext = UserFavLists[indexPath!.row].listnote
        }

        
        
        let dimmer : UIView = UIView()
        dimmer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dimmer.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 0.5)
        self.view.addSubview(dimmer)
        
        let noteview : UIView = UIView()
        //noteview.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, 200, 200)
        //noteview.frame = CGRectMake(cell.frame.origin.x + 20, cell.frame.origin.y + button.frame.origin.y + 10, self.view.frame.size.width*0.8, 200)
      //  noteview.frame = CGRectMake(cell.frame.origin.x + 20, cell.frame.origin.y + 120, self.view.frame.size.width*0.8, 120)
        noteview.frame = CGRectMake(self.view.frame.size.width*0.1, self.view.frame.origin.y + self.view.frame.size.height*0.5 - 100, self.view.frame.size.width*0.8, 200)
        
        noteview.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 1)//UIColor.whiteColor()
        
        noteview.layer.cornerRadius = 10
        noteview.layer.borderWidth = 1
        noteview.layer.borderColor = UIColorFromRGB(0xCFCFCF).CGColor
        dimmer.addSubview(noteview)
        
        
        
        let field: UITextView = UITextView()
        field.frame = CGRectMake(20, 35, noteview.frame.size.width*0.8, noteview.frame.size.height*0.7)
        //field.backgroundColor=UIColor.grayColor()
        field.textAlignment = NSTextAlignment.Left //.Center
        field.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 1)
        field.font = UIFont(name: "Avenir-Book", size: 16)
        field.text = notetext
        field.hidden = false
        noteview.addSubview(field)
        
        let btn: UIButton = UIButton()
        btn.frame=CGRectMake((noteview.frame.size.width - 120), 10, 110, 20)
        
        
        btn.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
        btn.setTitle(NSLocalizedString("close", comment: ""), forState: UIControlState.Normal)
        btn.titleLabel!.font =  UIFont(name: "Avenir-Book", size: 18)
        btn.setImage(closeimage, forState: UIControlState.Normal)
        btn.addTarget(self, action: "closenotes:", forControlEvents: UIControlEvents.TouchUpInside)
        noteview.addSubview(btn)
        noteview.bringSubviewToFront(btn)
        
    }
    */
    
    /// NEW SHARE PART 
    
    
    @IBOutlet var blurredview: UIView!
    
    
    @IBOutlet var newsendbuttonoutlet: UIButton!
    
    
    @IBAction func newsendbutton(sender: AnyObject) {
        
         performSegueWithIdentifier("shareListSegue", sender: self)
    }
    
    @IBOutlet var newoptionsoutlet: UIButton!
    
    
    @IBAction func newoptions(sender: AnyObject) {
        
        if listtosharetype == "Shop" {
        self.performSegueWithIdentifier("Alllistsoptions", sender: self)
        } else {
        self.performSegueWithIdentifier("todooptionssegue", sender: self)
        }
    }
    
    
    @IBOutlet var newnotelabel: UILabel!
    
    
    @IBOutlet var newnotetextview: UITextView!
    
    
    @IBOutlet var newdonebutton: UIButton!
    
    
    @IBAction func newdone(sender: AnyObject) {
        
        if listtosharetype == "Shop" {
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: listtoshare!)
        query.getFirstObjectInBackgroundWithBlock() {
            (list: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                
                self.dimmer.removeFromSuperview()
                
                
                self.mytopconstr.constant = -370
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }) { (value: Bool) -> Void in
                        self.newnotetextview.text = ""
                        self.listtoshare = ""
                        self.listtosharetype = ""
                        self.idforoptions = ""
                        self.blurredview.hidden = true
                }
                
                
                self.tableView.reloadData()
            } else if let list = list {
                
                list["ShopListName"] = self.newlistname.text
                list["ShopListNote"] = self.newnotetextview.text
                list.pinInBackground()
                // list.saveEventually()
                
                
                if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.listtoshare!) {
                    UserLists[foundlist].listname = self.newlistname.text
                    UserLists[foundlist].listnote = self.newnotetextview.text
                    
                }
                
                if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(self.listtoshare!) {
                    UserShopLists[foundshoplist].listname = self.newlistname.text
                    UserShopLists[foundshoplist].listnote = self.newnotetextview.text
                    
                }
                
                if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.listtoshare!) {
                    UserFavLists[foundfavlist].listname = self.newlistname.text
                    UserFavLists[foundfavlist].listnote = self.newnotetextview.text
                    
                }
                
                self.dimmer.removeFromSuperview()
                
                
                self.mytopconstr.constant = -370
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }) { (value: Bool) -> Void in
                        self.newnotetextview.text = ""
                        self.listtoshare = ""
                        self.listtosharetype = ""
                        self.idforoptions = ""
                        self.blurredview.hidden = true
                }
                
                
                self.tableView.reloadData()
                
            }
        }
        
    } else {
            
            let query = PFQuery(className:"toDoLists")
            query.fromLocalDatastore()
            query.whereKey("listUUID", equalTo: listtoshare!)
            query.getFirstObjectInBackgroundWithBlock() {
                (list: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                    
                    self.dimmer.removeFromSuperview()
                    
                    
                    self.mytopconstr.constant = -370
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                        }) { (value: Bool) -> Void in
                            self.newnotetextview.text = ""
                            self.listtoshare = ""
                            self.listtosharetype = ""
                            self.idforoptions = ""
                            self.blurredview.hidden = true
                    }
                    
                    
                    self.tableView.reloadData()
                    
                } else if let list = list {
                    
                    list["ToDoListName"] = self.newlistname.text
                    list["ToDoListNote"] = self.newnotetextview.text
                    list.pinInBackground()
                    // list.saveEventually()
                    
                    
                    if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.listtoshare!) {
                        UserLists[foundlist].listname = self.newlistname.text
                        UserLists[foundlist].listnote = self.newnotetextview.text
                        
                    }
                    
                    if let foundtodolist = UserShopLists.map({ $0.listid }).lazy.indexOf(self.listtoshare!) {
                        UserToDoLists[foundtodolist].listname = self.newlistname.text
                        UserToDoLists[foundtodolist].listnote = self.newnotetextview.text
                        
                    }
                    
                    if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.listtoshare!) {
                        UserFavLists[foundfavlist].listname = self.newlistname.text
                        UserFavLists[foundfavlist].listnote = self.newnotetextview.text
                        
                    }
                    
                    self.dimmer.removeFromSuperview()
                    
                    
                    self.mytopconstr.constant = -370
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                        }) { (value: Bool) -> Void in
                            self.newnotetextview.text = ""
                            self.listtoshare = ""
                            self.listtosharetype = ""
                            self.idforoptions = ""
                            self.blurredview.hidden = true
                    }
                    
                    
                    self.tableView.reloadData()
                    
                }
            }
    
    }
    
        // saveinfo
        /*
        dimmer.removeFromSuperview()
        
        
        mytopconstr.constant = -370
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (value: Bool) -> Void in
                self.newnotetextview.text = ""
                self.listtoshare = ""
                self.listtosharetype = ""
                self.idforoptions = ""
                self.blurredview.hidden = true
        }

        
        tableView.reloadData()
        */
    }
    
    
    @IBOutlet var newclosebuttonoutlet: UIButton!
    
    
    @IBAction func newclosebutton(sender: AnyObject) {
        
        dimmer.removeFromSuperview()
        
        
        mytopconstr.constant = -370
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (value: Bool) -> Void in
                self.newnotetextview.text = ""
                self.listtoshare = ""
                self.listtosharetype = ""
                self.idforoptions = ""
                self.blurredview.hidden = true
        }

        

    }
    
    @IBOutlet var newsharelabel: UILabel!
    
    @IBOutlet var newoptionslabel: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
    }
    
    
    func handlebvTap(sender: UITapGestureRecognizer? = nil) {
        
        dimmer.removeFromSuperview()
        
        
        mytopconstr.constant = -370
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
             self.view.layoutIfNeeded()
            }) { (value: Bool) -> Void in
                self.newnotetextview.text = ""
                self.listtoshare = ""
                self.listtosharetype = ""
                self.idforoptions = ""
                self.blurredview.hidden = true
        }

        
    }
    
     let dimmer : UIView = UIView()
    
    
    @IBOutlet var mytopconstr: NSLayoutConstraint!
    
    func showreceivednotes(sender: UIButton!) {
        
        let button = sender as UIButton
        let view1 = button.superview!
        let innerview = view1.superview!
        
        let cell = innerview.superview as! ReceivedListOld
        let indexPath = tableView.indexPathForCell(cell)
        
        var notetext = String()
        
        var listname = String()
        
        
        if showoption == "alllists" {
            listname = UserLists[indexPath!.row].listname
            notetext = UserLists[indexPath!.row].listnote
            listtoshare = UserLists[indexPath!.row].listid
            listtosharetype = UserLists[indexPath!.row].listtype
            idforoptions = UserLists[indexPath!.row].listid
            
        } else if showoption == "shoplists" {
            listname = UserShopLists[indexPath!.row].listname
            notetext = UserShopLists[indexPath!.row].listnote
            listtoshare = UserShopLists[indexPath!.row].listid
            listtosharetype = UserShopLists[indexPath!.row].listtype
            idforoptions = UserShopLists[indexPath!.row].listid
        } else if showoption == "todolists" {
            listname = UserToDoLists[indexPath!.row].listname
            notetext = UserToDoLists[indexPath!.row].listnote
            listtoshare = UserToDoLists[indexPath!.row].listid
            listtosharetype = UserToDoLists[indexPath!.row].listtype
            idforoptions = UserToDoLists[indexPath!.row].listid
        } else if showoption == "favs" {
            listname = UserFavLists[indexPath!.row].listname
            notetext = UserFavLists[indexPath!.row].listnote
            listtoshare = UserFavLists[indexPath!.row].listid
            listtosharetype = UserFavLists[indexPath!.row].listtype
            idforoptions = UserFavLists[indexPath!.row].listid
        }
        
        //  let dimmer : UIView = UIView()
        dimmer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dimmer.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 0.5)
        
        
        let blurredtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        blurredtap.delegate = self
        dimmer.userInteractionEnabled = true
        dimmer.addGestureRecognizer(blurredtap)
        
        self.view.addSubview(dimmer)
        // blurredview.is
        
        blurredview.hidden = false
        mytopconstr.constant = 137
        
        self.newnotetextview.text = notetext
        self.newlistname.text = listname
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            //self.blurredview.center.y = self.view.center.y
            self.view.layoutIfNeeded()
            }) { (value: Bool) -> Void in
                
        }
        
        
        
        
        
        self.view.bringSubviewToFront(blurredview)

        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        shiftview(true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        shiftview(false)
    }
    
   
    
    
    func shiftview(up: Bool) {
        
        if up == true {
            
            mytopconstr.constant = 20
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
            // self.view.frame.origin.y -= 200
            
        } else if up == false {
            
            mytopconstr.constant = 137
            
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
        }
    }
    
    
    func shownotes(sender: UIButton!) {
        
        let button = sender as UIButton
        let view1 = button.superview!
        let innerview = view1.superview!

        let cell = innerview.superview as! ShopListCellNew
        let indexPath = tableView.indexPathForCell(cell)
       
        var notetext = String()
        
        var listname = String()
       

        if showoption == "alllists" {
            listname = UserLists[indexPath!.row].listname
        notetext = UserLists[indexPath!.row].listnote
            listtoshare = UserLists[indexPath!.row].listid
            listtosharetype = UserLists[indexPath!.row].listtype
             idforoptions = UserLists[indexPath!.row].listid

        } else if showoption == "shoplists" {
            listname = UserShopLists[indexPath!.row].listname
        notetext = UserShopLists[indexPath!.row].listnote
            listtoshare = UserShopLists[indexPath!.row].listid
            listtosharetype = UserShopLists[indexPath!.row].listtype
            idforoptions = UserShopLists[indexPath!.row].listid
        } else if showoption == "todolists" {
            listname = UserToDoLists[indexPath!.row].listname
        notetext = UserToDoLists[indexPath!.row].listnote
            listtoshare = UserToDoLists[indexPath!.row].listid
            listtosharetype = UserToDoLists[indexPath!.row].listtype
            idforoptions = UserToDoLists[indexPath!.row].listid
        } else if showoption == "favs" {
            listname = UserFavLists[indexPath!.row].listname
        notetext = UserFavLists[indexPath!.row].listnote
            listtoshare = UserFavLists[indexPath!.row].listid
            listtosharetype = UserFavLists[indexPath!.row].listtype
            idforoptions = UserFavLists[indexPath!.row].listid
        }
        
      //  let dimmer : UIView = UIView()
        dimmer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dimmer.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 0.5)
        
        
        let blurredtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        blurredtap.delegate = self
        dimmer.userInteractionEnabled = true
        dimmer.addGestureRecognizer(blurredtap)

        self.view.addSubview(dimmer)
       // blurredview.is
        
        blurredview.hidden = false
         mytopconstr.constant = 137
        
        self.newnotetextview.text = notetext
        self.newlistname.text = listname
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
             //self.blurredview.center.y = self.view.center.y
            self.view.layoutIfNeeded()
            }) { (value: Bool) -> Void in
               
        }
        
        
        
       
        
       self.view.bringSubviewToFront(blurredview)
        
          }
    
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    /*
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
     newopenlistbynameselection(indexPath)
        
        

    }
   /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.reuseIdentifier == "receivedlist" {
                return 136.0
            }
        }
        return 116.0
    }
    */
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // DELETE
        let deleteAction = UITableViewRowAction(style: .Normal, title: "         ") { (action , indexPath ) -> Void in
            
            self.editing = false
           // self.swipedeleteusual(indexPath)
            print("delete")
            
        }
        
        if let adelete = UIImage(named: "4DeleteButton") {
            deleteAction.backgroundColor = UIColor.imageWithBackgroundColor(adelete, bgColor: UIColor.redColor())
        
        }
        
        // SHARE
        let shareAction = UITableViewRowAction(style: .Normal, title: "         ") { (action , indexPath) -> Void in
            self.editing = false
            
            //self.optionsaction(indexPath)
            
        }
        
        if let ashare = UIImage(named: "4ShareButton") {
            shareAction.backgroundColor = UIColor.imageWithBackgroundColor(ashare, bgColor: UIColorFromRGB(0x7FC2C6))
        }
        
        // OPTIONS
        let optionsAction = UITableViewRowAction(style: .Normal, title: "          ") { (action , indexPath) -> Void in
            self.editing = false
            
            //self.optionsaction(indexPath)
            print("Settings")
            
        }

        if let aoptions = UIImage(named: "TestShare2") {
             optionsAction.backgroundColor = UIColor.imageWithBackgroundColor(aoptions, bgColor: UIColor.clearColor())
        }
        
        let todooptionsAction = UITableViewRowAction(style: .Normal, title: "         ") { (action , indexPath) -> Void in
            self.editing = false

            //self.todooptionsaction(indexPath)
            
        }
        todooptionsAction.backgroundColor = UIColorFromRGB(0x31797D)
        
        // EDIT
        let editingAction = UITableViewRowAction(style: .Normal, title: "          ") { (action , indexPath) -> Void in
            self.editing = false
            
            //self.optionsaction(indexPath)
            print("edit")
            
        }
        
        if let aedit = UIImage(named: "TestShare3") {
            editingAction.backgroundColor = UIColor.imageWithBackgroundColor(aedit, bgColor: UIColor.clearColor())
        }
        


        

        var thislisttype = String()
        if showoption == "alllists" {
            thislisttype = UserLists[indexPath.row].listtype
        } else if showoption == "shoplists" {
            thislisttype = UserShopLists[indexPath.row].listtype
        } else if showoption == "todolists" {
            thislisttype = UserToDoLists[indexPath.row].listtype
        } else if showoption == "favs" {
            thislisttype = UserFavLists[indexPath.row].listtype
        }
        
        if thislisttype == "Shop" {
        
        return [deleteAction, shareAction, editingAction, optionsAction]
        } else if thislisttype == "ToDo" {
        return [optionsAction, editingAction, shareAction, deleteAction]
        } else {
            return [deleteAction]
        }
        
    }

    
    
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            //cString = cString.substringFromIndex(advance(cString.startIndex, 1))
             cString = cString.substringFromIndex(cString.startIndex.advancedBy(1)) //Swift 2
            //str.removeAtIndex(str.endIndex.advancedBy(-1))
        }
        
        //if (count(cString) != 6) {
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
            if showoption == "alllists" || showoption == "" {
                
               
            
                if UserLists[indexPath.row].listisreceived == true {
                    
                    let receivedcell  = tableView.dequeueReusableCellWithIdentifier("receivedlist", forIndexPath: indexPath) as! ReceivedListOld
                    
                    receivedcell.listnote.addTarget(self, action: "showreceivednotes:", forControlEvents: .TouchUpInside)
                    
                    let thiscolor : String = UserLists[indexPath.row].listcolorcode
                    receivedcell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    
                    
                    
                   // receivedcell.receivedlistname.text = UserLists[indexPath.row].listname
                   // receivedcell.receivedlistnote.text = UserLists[indexPath.row].listname
                    
                    receivedcell.receivedlistnamebutton.text = UserLists[indexPath.row].listname
                    receivedcell.receivedlistnamebutton.tag = indexPath.row
                    
                    
                  //  receivedcell.receivedlistnamebutton.addTarget(self, action: "newopenreceivedlistbyname:", forControlEvents: .TouchUpInside)
                   
                    
                    if UserLists[indexPath.row].listtype == "Shop" {
                        receivedcell.iconimage.image = shopicon
                    } else {
                        receivedcell.iconimage.image = todoicon
                    }
                    
                    /*
                    if UserLists[indexPath.row].listtype == "Shop"
                    {
                        receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedlistbyname:", forControlEvents: .TouchUpInside)
                    } else {
                        receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedtodolistbyname:", forControlEvents: .TouchUpInside)
                    }
                    */
                    /*
                    if UserLists[indexPath.row].listissaved == false {
                        receivedcell.receivedlistnamebutton.enabled = false
                    } else {
                        receivedcell.receivedlistnamebutton.enabled = true
                        
                    }
                    */
                    var email = String()
                    if UserLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        //receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
                        email = UserLists[indexPath.row].listreceivedfrom[2]
                    } else {
                       // receivedcell.senderemail.text = "Anonymous"
                        email = NSLocalizedString("Anonymous", comment: "")
                    }

                    
                    receivedcell.sendername.text = "\(UserLists[indexPath.row].listreceivedfrom[1]) (\(email))" //name
                    
                   
                    
                    if UserLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        receivedcell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        receivedcell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                   
                    
                    receivedcell.addtofavs.addTarget(self, action: "adddeletereceivedfav:", forControlEvents: .TouchUpInside)
                    
                   
                
                    
                    
                    receivedcell.acceptlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                    if UserLists[indexPath.row].listconfirmreception == true {
                        
                        receivedcell.listnote.hidden = false
                        receivedcell.addtofavs.hidden  = false
                        receivedcell.acceptlist.hidden = true
                      
                        
                    } else {
                        receivedcell.listnote.hidden = true
                        receivedcell.addtofavs.hidden  = true
                        receivedcell.acceptlist.hidden = false

                    }
                    
                    /*
                    receivedcell.sharereceivedlist.tag = indexPath.row
                    if UserLists[indexPath.row].listtype == "Shop" {
                        
                        receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedlist:", forControlEvents: .TouchUpInside)
                    } else if UserLists[indexPath.row].listtype == "ToDo" {
                        receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedtodolist:", forControlEvents: .TouchUpInside)
                    }
                    */
                    let dateFormatter1 = NSDateFormatter()
                    dateFormatter1.dateFormat = "dd MMM yyyy"
                    let date1 = dateFormatter1.stringFromDate(UserLists[indexPath.row].listcreationdate)
                    receivedcell.receivedlistdate.text = date1
                    
                    let allcount : String = String(UserLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    receivedcell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                   // receivedcell.itemscount.text = "Items: \(allcount)/\(checkedcount)"
                    //receivedcell.itemscount.text = String(UserLists[indexPath.row].listitemscount)
                    //receivedcell.checkeditemscount.text = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    return receivedcell
                    
                } else {
                    //usual list
                    
                    
                    let cellIdentifier1 = "userlist"
                    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCellNew
                    
                    cell.shownote.addTarget(self, action: "shownotes:", forControlEvents: .TouchUpInside)
                    
                    let thiscolor : String = UserLists[indexPath.row].listcolorcode
                    
                    cell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    cell.storyline.backgroundColor = colorWithHexString(thiscolor)
                    
                    cell.newlisttype.tintColor = colorWithHexString(thiscolor)
                    
                  //  let dashcolor: String = UserLists[indexPath.row].listcolorcode
                    
                   // cell.container.addDashedBorder(colorWithHexString(dashcolor).CGColor)
                    
                    
                   // cell.ShopListNote.text = UserLists[indexPath.row].listnote
                    
                    cell.ShopListNameButton.text = UserLists[indexPath.row].listname
                    
                    if UserLists[indexPath.row].listtype == "Shop" {
                        cell.ListTypeImage.image = shopicon
                    } else {
                        cell.ListTypeImage.image = todoicon
                    }
                  
                    
                   // cell.ShopListNameButton.tag = indexPath.row
                    /*
                    if UserLists[indexPath.row].listtype == "Shop" {
                        
                        cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
                    } else if UserLists[indexPath.row].listtype == "ToDo" {
                        cell.ShopListNameButton.addTarget(self, action: "opentodolistbyname:", forControlEvents: .TouchUpInside)
                    }
                    */
                    
                  //   cell.ShopListNameButton.addTarget(self, action: "newopenlistbyname:", forControlEvents: .TouchUpInside)
                    
                    
                    
                    /*
                    cell.DeleteOutlet.tag = indexPath.row
                    if UserLists[indexPath.row].listtype == "Shop" {
                        cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
                    } else if UserLists[indexPath.row].listtype == "ToDo" {
                        cell.DeleteOutlet.addTarget(self, action: "deletetodolist:", forControlEvents: .TouchUpInside)
                    }
*/
                   // cell.ShareButtonOutlet.tag = indexPath.row
                   
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let date = dateFormatter.stringFromDate(UserLists[indexPath.row].listcreationdate)
                    cell.creationDate.text = date
                    
                    
                    if UserLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                  
                    
                    cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                    
                    let allcount : String = String(UserLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                   // cell.itemscount.text = "Items: \(allcount)/\(checkedcount)"
                    cell.itemscount.text = "\(allcount)/\(checkedcount)"
                    
                   // cell.itemscount.text = String(UserLists[indexPath.row].listitemscount)
                   // cell.checkeditemscount.text = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    return cell
                    
                }
                
            } else if showoption == "shoplists" {
                
            
                
                 if UserShopLists[indexPath.row].listisreceived == true {
                    
                     let receivedcell  = tableView.dequeueReusableCellWithIdentifier("receivedlist", forIndexPath: indexPath) as! ReceivedListOld
                    
                   // receivedcell.bounds.size.height = 136.0
                   // receivedcell.receivedlistname.text = UserShopLists[indexPath.row].listname
                   // receivedcell.receivedlistnote.text = UserShopLists[indexPath.row].listname
                    
                    receivedcell.receivedlistnamebutton.text = UserShopLists[indexPath.row].listname                   // receivedcell.receivedlistnamebutton.tag = indexPath.row
                    
                    let thiscolor : String = UserShopLists[indexPath.row].listcolorcode
                    receivedcell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                  //  receivedcell.receivedlistnamebutton.addTarget(self, action: "newopenreceivedlistbyname:", forControlEvents: .TouchUpInside)
                    
                    receivedcell.listnote.addTarget(self, action: "showreceivednotes:", forControlEvents: .TouchUpInside)
                    
                        receivedcell.iconimage.image = shopicon
                 
                    /*
                    if UserShopLists[indexPath.row].listissaved == false {
                        receivedcell.receivedlistnamebutton.enabled = false
                    } else {
                        receivedcell.receivedlistnamebutton.enabled = true
                        
                    }
                    */
                    
                    receivedcell.acceptlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                    if UserShopLists[indexPath.row].listconfirmreception == true {
                        
                        receivedcell.listnote.hidden = false
                        receivedcell.addtofavs.hidden  = false
                        receivedcell.acceptlist.hidden = true
                        
                        
                    } else {
                        receivedcell.listnote.hidden = true
                        receivedcell.addtofavs.hidden  = true
                        receivedcell.acceptlist.hidden = false
                        
                    }
                    
                    if UserShopLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        receivedcell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        receivedcell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    receivedcell.addtofavs.addTarget(self, action: "adddeletereceivedfav:", forControlEvents: .TouchUpInside)
                    
                    var email = String()
                    if UserShopLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        //receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
                        email = UserShopLists[indexPath.row].listreceivedfrom[2]
                    } else {
                        // receivedcell.senderemail.text = "Anonymous"
                        email = NSLocalizedString("Anonymous", comment: "")
                    }
                    
                    
                    receivedcell.sendername.text = "\(UserShopLists[indexPath.row].listreceivedfrom[1]) (\(email))" //name
                    
                    
                    
                    //receivedcell.deletereceivedlist.tag = indexPath.row
                    
                   
                    
                    
                    //receivedcell.sharereceivedlist.tag = indexPath.row
                  //
                   // receivedcell.sharereceivedlist.addTarget(self, action: "newsavereceivedlist:", //forControlEvents: .TouchUpInside)
                    
                    let dateFormatter1 = NSDateFormatter()
                    dateFormatter1.dateFormat = "dd MMM yyyy"
                    let date1 = dateFormatter1.stringFromDate(UserShopLists[indexPath.row].listcreationdate)
                    receivedcell.receivedlistdate.text = date1
                    
                    let allcount : String = String(UserShopLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserShopLists[indexPath.row].listcheckeditemscount)
                    
                    receivedcell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                    //receivedcell.itemscount.text = String(UserShopLists[indexPath.row].listitemscount)
                    //receivedcell.checkeditemscount.text = String(UserShopLists[indexPath.row].listcheckeditemscount)
                    
                    return receivedcell
                    
                 } else {
                    
                    
                    let cellIdentifier1 = "userlist"
                    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCellNew
                    
                   // cell.ShopListNote.text = UserShopLists[indexPath.row].listnote
                    
                    cell.ShopListNameButton.text = UserShopLists[indexPath.row].listname
                    let thiscolor : String = UserShopLists[indexPath.row].listcolorcode
                    cell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    cell.shownote.addTarget(self, action: "shownotes:", forControlEvents: .TouchUpInside)
                   
                        cell.ListTypeImage.image = shopicon
                   
                  
                    
                  //  cell.ShopListNameButton.tag = indexPath.row
                    
                    
                   // cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
                    
                  //    cell.ShopListNameButton.addTarget(self, action: "newopenlistbyname:", forControlEvents: .TouchUpInside)
                    
                  //  cell.DeleteOutlet.tag = indexPath.row
                    
                   // cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
                   
                    
                    
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let date = dateFormatter.stringFromDate(UserShopLists[indexPath.row].listcreationdate)
                    cell.creationDate.text = date
                    
                    
                    if UserShopLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                    
                    let allcount : String = String(UserShopLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserShopLists[indexPath.row].listcheckeditemscount)
                    
                    cell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                    //cell.itemscount.text = String(UserShopLists[indexPath.row].listitemscount)
                    //cell.checkeditemscount.text = String(UserShopLists[indexPath.row].listcheckeditemscount)
                    
                    
                    return cell
                }
                
            } else if showoption == "todolists" {
               

                
                if UserToDoLists[indexPath.row].listisreceived == true {
                    
                    
                    let receivedcell  = tableView.dequeueReusableCellWithIdentifier("receivedlist", forIndexPath: indexPath) as! ReceivedListOld
                   
                   // receivedcell.receivedlistname.text = UserToDoLists[indexPath.row].listname
                   // receivedcell.receivedlistnote.text = UserToDoLists[indexPath.row].listname
                    
                    receivedcell.receivedlistnamebutton.text = UserToDoLists[indexPath.row].listname                    //receivedcell.receivedlistnamebutton.tag = indexPath.row
                    
                    let thiscolor : String = UserToDoLists[indexPath.row].listcolorcode
                    receivedcell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    receivedcell.listnote.addTarget(self, action: "showreceivednotes:", forControlEvents: .TouchUpInside)
                    
                   // receivedcell.receivedlistnamebutton.addTarget(self, action: "newopenreceivedlistbyname:", forControlEvents: .TouchUpInside)
                    
                    
                receivedcell.acceptlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                 
                    if UserToDoLists[indexPath.row].listconfirmreception == true {
                        
                        receivedcell.listnote.hidden = false
                        receivedcell.addtofavs.hidden  = false
                        receivedcell.acceptlist.hidden = true
                        
                        
                    } else {
                        receivedcell.listnote.hidden = true
                        receivedcell.addtofavs.hidden  = true
                        receivedcell.acceptlist.hidden = false
                        
                    }
                    
                  
                        receivedcell.iconimage.image = todoicon
                   
                    /*
                    if UserToDoLists[indexPath.row].listissaved == false {
                        receivedcell.receivedlistnamebutton.enabled = false
                    } else {
                        receivedcell.receivedlistnamebutton.enabled = true
                        
                    }
                    */
                    
                    if UserToDoLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        receivedcell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        receivedcell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    
                    receivedcell.addtofavs.addTarget(self, action: "adddeletereceivedfav:", forControlEvents: .TouchUpInside)
                    
                    
                    var email = String()
                    if UserToDoLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        //receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
                        email = UserToDoLists[indexPath.row].listreceivedfrom[2]
                    } else {
                        // receivedcell.senderemail.text = "Anonymous"
                        email = NSLocalizedString("Anonymous", comment: "")
                    }
                    
                    
                    receivedcell.sendername.text = "\(UserToDoLists[indexPath.row].listreceivedfrom[1]) (\(email))" //name
                    
                    //
                    /*
                    receivedcell.sendername.text = UserToDoLists[indexPath.row].listreceivedfrom[1] //name
                    if UserToDoLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        receivedcell.senderemail.text = UserToDoLists[indexPath.row].listreceivedfrom[2] //email
                    } else {
                        receivedcell.senderemail.text = "Anonymous"
                    }
                    */
                   // receivedcell.deletereceivedlist.tag = indexPath.row
                    
                   
                 
                    
                    
                  //  receivedcell.sharereceivedlist.tag = indexPath.row
                    
                   // receivedcell.sharereceivedlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                    let dateFormatter1 = NSDateFormatter()
                    dateFormatter1.dateFormat = "dd MMM yyyy"
                    let date1 = dateFormatter1.stringFromDate(UserToDoLists[indexPath.row].listcreationdate)
                    receivedcell.receivedlistdate.text = date1
                    
                    let allcount : String = String(UserToDoLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserToDoLists[indexPath.row].listcheckeditemscount)
                    
                    receivedcell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                   // receivedcell.itemscount.text = String(UserToDoLists[indexPath.row].listitemscount)
                   // receivedcell.checkeditemscount.text = String(UserToDoLists[indexPath.row].listcheckeditemscount)
                    
                    return receivedcell
                    
                } else {
                    
                    let cellIdentifier1 = "userlist"
                    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCellNew
                    
                   // cell.ShopListNote.text = UserToDoLists[indexPath.row].listnote
                    
                    cell.ShopListNameButton.text = UserToDoLists[indexPath.row].listname
                    let thiscolor : String = UserToDoLists[indexPath.row].listcolorcode
                    cell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    cell.shownote.addTarget(self, action: "shownotes:", forControlEvents: .TouchUpInside)
               
                        cell.ListTypeImage.image = todoicon
               
                    
                 //   cell.ShopListNameButton.tag = indexPath.row
                    
                    
                   // cell.ShopListNameButton.addTarget(self, action: "opentodolistbyname:", forControlEvents: .TouchUpInside)
                    
                   //   cell.ShopListNameButton.addTarget(self, action: "newopenlistbyname:", forControlEvents: .TouchUpInside)
                    
                   // cell.DeleteOutlet.tag = indexPath.row
                    
                   // cell.DeleteOutlet.addTarget(self, action: "deletetodolist:", forControlEvents: .TouchUpInside)
                    
                   
                    
                 
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let date = dateFormatter.stringFromDate(UserToDoLists[indexPath.row].listcreationdate)
                    cell.creationDate.text = date
                    
                    
                    if UserToDoLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                    
                    let allcount : String = String(UserToDoLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserToDoLists[indexPath.row].listcheckeditemscount)
                    
                    cell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                    //cell.itemscount.text = String(UserToDoLists[indexPath.row].listitemscount)
                    //cell.checkeditemscount.text = String(UserToDoLists[indexPath.row].listcheckeditemscount)

                    return cell
                    
                }
                
                
            }  else if showoption == "favs" {
                
                
                
                if UserFavLists[indexPath.row].listisreceived == true {
                    
                    let receivedcell  = tableView.dequeueReusableCellWithIdentifier("receivedlist", forIndexPath: indexPath) as! ReceivedListOld
                    
                    
                    if UserFavLists[indexPath.row].listtype == "Shop" {
                        receivedcell.iconimage.image = shopicon
                    } else {
                        receivedcell.iconimage.image = todoicon
                    }
                    
                    // receivedcell.bounds.size.height = 136.0
                    // receivedcell.receivedlistname.text = UserShopLists[indexPath.row].listname
                    // receivedcell.receivedlistnote.text = UserShopLists[indexPath.row].listname
                    
                    receivedcell.receivedlistnamebutton.text = UserFavLists[indexPath.row].listname                    // receivedcell.receivedlistnamebutton.tag = indexPath.row
                    
                    let thiscolor : String = UserFavLists[indexPath.row].listcolorcode
                    receivedcell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                  //  receivedcell.receivedlistnamebutton.addTarget(self, action: "newopenreceivedlistbyname:", forControlEvents: .TouchUpInside)
                    
                    receivedcell.listnote.addTarget(self, action: "showreceivednotes:", forControlEvents: .TouchUpInside)
                    
                    receivedcell.acceptlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                    if UserFavLists[indexPath.row].listconfirmreception == true {
                        
                        receivedcell.listnote.hidden = false
                        receivedcell.addtofavs.hidden  = false
                        receivedcell.acceptlist.hidden = true
                        
                        
                    } else {
                        receivedcell.listnote.hidden = true
                        receivedcell.addtofavs.hidden  = true
                        receivedcell.acceptlist.hidden = false
                        
                    }
                    
                    receivedcell.iconimage.image = shopicon
                    
                    /*
                    if UserShopLists[indexPath.row].listissaved == false {
                    receivedcell.receivedlistnamebutton.enabled = false
                    } else {
                    receivedcell.receivedlistnamebutton.enabled = true
                    
                    }
                    */
                    
                    
                    if UserFavLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        receivedcell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        receivedcell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    
                    receivedcell.addtofavs.addTarget(self, action: "adddeletereceivedfav:", forControlEvents: .TouchUpInside)
                    
                    var email = String()
                    if UserFavLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        //receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
                        email = UserFavLists[indexPath.row].listreceivedfrom[2]
                    } else {
                        // receivedcell.senderemail.text = "Anonymous"
                        email = NSLocalizedString("Anonymous", comment: "")
                    }
                    
                    
                    receivedcell.sendername.text = "\(UserFavLists[indexPath.row].listreceivedfrom[1]) (\(email))" //name
                    
                    
                    
                    //receivedcell.deletereceivedlist.tag = indexPath.row
                    
                    
                    
                    
                    //receivedcell.sharereceivedlist.tag = indexPath.row
                    //
                    // receivedcell.sharereceivedlist.addTarget(self, action: "newsavereceivedlist:", //forControlEvents: .TouchUpInside)
                    
                    let dateFormatter1 = NSDateFormatter()
                    dateFormatter1.dateFormat = "dd MMM yyyy"
                    let date1 = dateFormatter1.stringFromDate(UserFavLists[indexPath.row].listcreationdate)
                    receivedcell.receivedlistdate.text = date1
                    
                    let allcount : String = String(UserFavLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserFavLists[indexPath.row].listcheckeditemscount)
                    
                    receivedcell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                    //receivedcell.itemscount.text = String(UserShopLists[indexPath.row].listitemscount)
                    //receivedcell.checkeditemscount.text = String(UserShopLists[indexPath.row].listcheckeditemscount)
                    
                    return receivedcell
                    
                } else {
                    
                    
                    let cellIdentifier1 = "userlist"
                    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCellNew
                    
                    // cell.ShopListNote.text = UserShopLists[indexPath.row].listnote
                    
                    let thiscolor : String = UserFavLists[indexPath.row].listcolorcode
                    cell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    cell.ShopListNameButton.text = UserFavLists[indexPath.row].listname
                    cell.shownote.addTarget(self, action: "shownotes:", forControlEvents: .TouchUpInside)
                    
                    //cell.ListTypeImage.image = shopicon
                    
                    if UserFavLists[indexPath.row].listtype == "Shop" {
                        cell.ListTypeImage.image = shopicon
                    } else {
                        cell.ListTypeImage.image = todoicon
                    }
                    
                    
                    //  cell.ShopListNameButton.tag = indexPath.row
                    
                    
                    // cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
                    
                   // cell.ShopListNameButton.addTarget(self, action: "newopenlistbyname:", forControlEvents: .TouchUpInside)
                    
                    //  cell.DeleteOutlet.tag = indexPath.row
                    
                    // cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
                   
                   
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let date = dateFormatter.stringFromDate(UserFavLists[indexPath.row].listcreationdate)
                    cell.creationDate.text = date
                    
                    
                    if UserFavLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                    
                    let allcount : String = String(UserFavLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserFavLists[indexPath.row].listcheckeditemscount)
                    
                    cell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                    //cell.itemscount.text = String(UserShopLists[indexPath.row].listitemscount)
                    //cell.checkeditemscount.text = String(UserShopLists[indexPath.row].listcheckeditemscount)
                    
                    
                    return cell
                }
                
            } else {
                
                
                
                
              
                
                if UserLists[indexPath.row].listisreceived == true {
                    
                     let receivedcell  = tableView.dequeueReusableCellWithIdentifier("receivedlist", forIndexPath: indexPath) as! ReceivedListOld
                   
                    //receivedcell.receivedlistname.text = UserLists[indexPath.row].listname
                   // receivedcell.receivedlistnote.text = UserLists[indexPath.row].listname
                    
                    receivedcell.receivedlistnamebutton.text = UserLists[indexPath.row].listname                   // receivedcell.receivedlistnamebutton.tag = indexPath.row
                    
                    let thiscolor : String = UserLists[indexPath.row].listcolorcode
                    receivedcell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    receivedcell.listnote.addTarget(self, action: "showreceivednotes:", forControlEvents: .TouchUpInside)
                    
                //    receivedcell.receivedlistnamebutton.addTarget(self, action: "newopenreceivedlistbyname:", forControlEvents: .TouchUpInside)
                    
                    
                    receivedcell.acceptlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                    if UserLists[indexPath.row].listconfirmreception == true {
                        
                        receivedcell.listnote.hidden = false
                        receivedcell.addtofavs.hidden  = false
                        receivedcell.acceptlist.hidden = true
                        
                        
                    } else {
                        receivedcell.listnote.hidden = true
                        receivedcell.addtofavs.hidden  = true
                        receivedcell.acceptlist.hidden = false
                        
                    }
                    
                    
                    if UserLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        receivedcell.addtofavs.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        receivedcell.addtofavs.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    
                    receivedcell.addtofavs.addTarget(self, action: "adddeletereceivedfav:", forControlEvents: .TouchUpInside)
                    
                    /*
                    if UserLists[indexPath.row].listtype == "Shop" {
                        receivedcell.iconimage.image = shopicon
                    } else {
                        receivedcell.iconimage.image = todoicon
                    }
                    */
                    
                    /*
                    if UserLists[indexPath.row].listtype == "Shop"
                    {
                        receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedlistbyname:", forControlEvents: .TouchUpInside)
                    } else {
                        receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedtodolistbyname:", forControlEvents: .TouchUpInside)
                    }
                    */
                    if UserLists[indexPath.row].listissaved == false {
                        receivedcell.receivedlistnamebutton.enabled = false
                    } else {
                        receivedcell.receivedlistnamebutton.enabled = true
                        
                    }
                    
                    
                    var email = String()
                    if UserLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        //receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
                        email = UserLists[indexPath.row].listreceivedfrom[2]
                    } else {
                        // receivedcell.senderemail.text = "Anonymous"
                        email = NSLocalizedString("Anonymous", comment: "")
                    }
                    
                    
                    receivedcell.sendername.text = "\(UserLists[indexPath.row].listreceivedfrom[1]) (\(email))" //name
                    
                    /*
                    receivedcell.sendername.text = UserLists[indexPath.row].listreceivedfrom[1] //name
                    if UserLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                        receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
                    } else {
                        receivedcell.senderemail.text = "Anonymous"
                    }
                    */
                  
                    
                    
                    /*
                    receivedcell.deletereceivedlist.tag = indexPath.row
                    if UserLists[indexPath.row].listtype == "Shop" {
                        receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedlist:", forControlEvents: .TouchUpInside)
                    } else if UserLists[indexPath.row].listtype == "ToDo" {
                        receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedtodolist:", forControlEvents: .TouchUpInside)
                    }
                    */
                    
                   
                    
                  //  receivedcell.sharereceivedlist.addTarget(self, action: "newsavereceivedlist:", forControlEvents: .TouchUpInside)
                    
                    /*
                    receivedcell.sharereceivedlist.tag = indexPath.row
                    if UserLists[indexPath.row].listtype == "Shop" {
                        
                        receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedlist:", forControlEvents: .TouchUpInside)
                    } else if UserLists[indexPath.row].listtype == "ToDo" {
                        receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedtodolist:", forControlEvents: .TouchUpInside)
                    }
                    */
                    let dateFormatter1 = NSDateFormatter()
                    dateFormatter1.dateFormat = "dd MMM yyyy"
                    let date1 = dateFormatter1.stringFromDate(UserLists[indexPath.row].listcreationdate)
                    receivedcell.receivedlistdate.text = date1
                    
                    let allcount : String = String(UserLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    receivedcell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                   // receivedcell.itemscount.text = String(UserLists[indexPath.row].listitemscount)
                   // receivedcell.checkeditemscount.text = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    return receivedcell
                    
                } else {
                    //usual list
                    
                    let cellIdentifier1 = "userlist"
                    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCellNew
                    
                   // cell.ShopListNote.text = UserLists[indexPath.row].listnote
                    
                    cell.ShopListNameButton.text = UserLists[indexPath.row].listname
                  //    cell.ShopListNameButton.addTarget(self, action: "newopenlistbyname:", forControlEvents: .TouchUpInside)
                    
                    let thiscolor : String = UserLists[indexPath.row].listcolorcode
                    cell.colorcodeviewoutlet.backgroundColor = colorWithHexString(thiscolor)
                    
                    cell.shownote.addTarget(self, action: "shownotes:", forControlEvents: .TouchUpInside)
                    
                    
                    if UserLists[indexPath.row].listtype == "Shop" {
                        cell.ListTypeImage.image = shopicon
                    } else {
                        cell.ListTypeImage.image = todoicon
                    }
                 
                    /*
                    cell.ShopListNameButton.tag = indexPath.row
                    
                    if UserLists[indexPath.row].listtype == "Shop" {
                        
                        cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
                    } else if UserLists[indexPath.row].listtype == "ToDo" {
                        cell.ShopListNameButton.addTarget(self, action: "opentodolistbyname:", forControlEvents: .TouchUpInside)
                    }
                    */
                  
                    /*
                    cell.DeleteOutlet.tag = indexPath.row
                    if UserLists[indexPath.row].listtype == "Shop" {
                        cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
                    } else {
                        cell.DeleteOutlet.addTarget(self, action: "deletetodolist:", forControlEvents: .TouchUpInside)
                    }
                    */
                    
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let date = dateFormatter.stringFromDate(UserLists[indexPath.row].listcreationdate)
                    cell.creationDate.text = date
                    
                    
                    if UserLists[indexPath.row].listisfavourite == true {
                        favimage = UIImage(named: "ICFavStarActive") as UIImage!
                        cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                    } else {
                        notfavimage = UIImage(named: "ICFavStar") as UIImage!
                        cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                        // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                    
                    
                    cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                    
                    let allcount : String = String(UserLists[indexPath.row].listitemscount)
                    let checkedcount : String = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    cell.itemscount.text = "\(allcount)/\(checkedcount)"//"\(NSLocalizedString("items", comment: "")) \(allcount)/\(checkedcount)"
                    
                  //  cell.itemscount.text = String(UserLists[indexPath.row].listitemscount)
                   // cell.checkeditemscount.text = String(UserLists[indexPath.row].listcheckeditemscount)
                    
                    return cell
                    
                }
                
        
        
        }
    }
    
        
        //////////////////////////////////////
        
        
        
        /* OLD CODE
                if showoption == "alllists" {
                
            receivedcell.receivedlistname.text = UserLists[indexPath.row].listname
            receivedcell.receivedlistnote.text = UserLists[indexPath.row].listname
            
            receivedcell.receivedlistnamebutton.setTitle(UserLists[indexPath.row].listname, forState: .Normal)
            receivedcell.receivedlistnamebutton.tag = indexPath.row
            
            if UserLists[indexPath.row].listtype == "Shop"
            {
                receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedlistbyname:", forControlEvents: .TouchUpInside)
            } else {
                receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedtodolistbyname:", forControlEvents: .TouchUpInside)
            }
            
            if UserLists[indexPath.row].listissaved == false {
                receivedcell.receivedlistnamebutton.enabled = false
            } else {
                receivedcell.receivedlistnamebutton.enabled = true
                
            }
            
            
            receivedcell.sendername.text = UserLists[indexPath.row].listreceivedfrom[1] //name
            if UserLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                receivedcell.senderemail.text = UserLists[indexPath.row].listreceivedfrom[2] //email
            } else {
                receivedcell.senderemail.text = "Anonymous"
            }
            
            receivedcell.deletereceivedlist.tag = indexPath.row
            if UserLists[indexPath.row].listtype == "Shop" {
                receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedlist:", forControlEvents: .TouchUpInside)
            } else if UserLists[indexPath.row].listtype == "ToDo" {
                receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedtodolist:", forControlEvents: .TouchUpInside)
            }
            
            
            receivedcell.sharereceivedlist.tag = indexPath.row
            if UserLists[indexPath.row].listtype == "Shop" {
                
                receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedlist:", forControlEvents: .TouchUpInside)
            } else if UserLists[indexPath.row].listtype == "ToDo" {
                receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedtodolist:", forControlEvents: .TouchUpInside)
            }
            
            let dateFormatter1 = NSDateFormatter()
            dateFormatter1.dateFormat = "dd.MM.yyyy"
            let date1 = dateFormatter1.stringFromDate(UserLists[indexPath.row].listcreationdate)
            receivedcell.receivedlistdate.text = date1
            
            receivedcell.itemscount.text = String(UserLists[indexPath.row].listitemscount)
            receivedcell.checkeditemscount.text = String(UserLists[indexPath.row].listcheckeditemscount)
            
            } ////// END OF ALL LISTS CASE
            
            
             else  if showoption == "shoplists" {
                
                
                receivedcell.receivedlistname.text = UserShopLists[indexPath.row].listname
                receivedcell.receivedlistnote.text = UserShopLists[indexPath.row].listname
                
                receivedcell.receivedlistnamebutton.setTitle(UserShopLists[indexPath.row].listname, forState: .Normal)
                receivedcell.receivedlistnamebutton.tag = indexPath.row

                receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedlistbyname:", forControlEvents: .TouchUpInside)
            
                
                if UserShopLists[indexPath.row].listissaved == false {
                    receivedcell.receivedlistnamebutton.enabled = false
                } else {
                    receivedcell.receivedlistnamebutton.enabled = true
                    
                }
                
                
                receivedcell.sendername.text = UserShopLists[indexPath.row].listreceivedfrom[1] //name
                if UserShopLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                    receivedcell.senderemail.text = UserShopLists[indexPath.row].listreceivedfrom[2] //email
                } else {
                    receivedcell.senderemail.text = "Anonymous"
                }
                
                receivedcell.deletereceivedlist.tag = indexPath.row
            
                receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedlist:", forControlEvents: .TouchUpInside)
             
                
                
                receivedcell.sharereceivedlist.tag = indexPath.row
                
                receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedlist:", forControlEvents: .TouchUpInside)
            
                let dateFormatter1 = NSDateFormatter()
                dateFormatter1.dateFormat = "dd.MM.yyyy"
                let date1 = dateFormatter1.stringFromDate(UserShopLists[indexPath.row].listcreationdate)
                receivedcell.receivedlistdate.text = date1
                
                receivedcell.itemscount.text = String(UserShopLists[indexPath.row].listitemscount)
                receivedcell.checkeditemscount.text = String(UserShopLists[indexPath.row].listcheckeditemscount)
                
            } //// END OF ONLY SHOPS CASE
            
            else  if showoption == "todolists" {
                
                
                receivedcell.receivedlistname.text = UserToDoLists[indexPath.row].listname
                receivedcell.receivedlistnote.text = UserToDoLists[indexPath.row].listname
                
                receivedcell.receivedlistnamebutton.setTitle(UserToDoLists[indexPath.row].listname, forState: .Normal)
                receivedcell.receivedlistnamebutton.tag = indexPath.row
                
                receivedcell.receivedlistnamebutton.addTarget(self, action: "openreceivedtodolistbyname:", forControlEvents: .TouchUpInside)
                
                
                if UserToDoLists[indexPath.row].listissaved == false {
                    receivedcell.receivedlistnamebutton.enabled = false
                } else {
                    receivedcell.receivedlistnamebutton.enabled = true
                    
                }
                
                
                receivedcell.sendername.text = UserToDoLists[indexPath.row].listreceivedfrom[1] //name
                if UserToDoLists[indexPath.row].listreceivedfrom[2] != "default@default.com" {
                    receivedcell.senderemail.text = UserToDoLists[indexPath.row].listreceivedfrom[2] //email
                } else {
                    receivedcell.senderemail.text = "Anonymous"
                }
                
                receivedcell.deletereceivedlist.tag = indexPath.row
                
                receivedcell.deletereceivedlist.addTarget(self, action: "deletereceivedtodolist:", forControlEvents: .TouchUpInside)
                
                
                
                receivedcell.sharereceivedlist.tag = indexPath.row
                
                receivedcell.sharereceivedlist.addTarget(self, action: "savereceivedtodolist:", forControlEvents: .TouchUpInside)
                
                let dateFormatter1 = NSDateFormatter()
                dateFormatter1.dateFormat = "dd.MM.yyyy"
                let date1 = dateFormatter1.stringFromDate(UserToDoLists[indexPath.row].listcreationdate)
                receivedcell.receivedlistdate.text = date1
                
                receivedcell.itemscount.text = String(UserToDoLists[indexPath.row].listitemscount)
                receivedcell.checkeditemscount.text = String(UserToDoLists[indexPath.row].listcheckeditemscount)
                
            } //// END OF ONLY TO DO LISTS CASE
            
            //////
            
            return receivedcell
            
            
        
            /*
            let cellIdentifier1 = "userlist"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as!  ShopListCellNew
            */
            
            // Configure the cell...
            
            //cell.ShopListName.text = UserLists[indexPath.row].listname
                
            if showoption == "alllists" { /////ALL LISTS CASE
            
            cell.ShopListNote.text = UserLists[indexPath.row].listnote
            
            cell.ShopListNameButton.setTitle(UserLists[indexPath.row].listname, forState: .Normal)
            
            
            cell.ShopListNameButton.tag = indexPath.row
            
            if UserLists[indexPath.row].listtype == "Shop" {
                
                cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
            } else if UserLists[indexPath.row].listtype == "ToDo" {
                cell.ShopListNameButton.addTarget(self, action: "opentodolistbyname:", forControlEvents: .TouchUpInside)
            }
            
            cell.DeleteOutlet.tag = indexPath.row
            if UserLists[indexPath.row].listtype == "Shop" {
                cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
            } else {
                cell.DeleteOutlet.addTarget(self, action: "deletetodolist:", forControlEvents: .TouchUpInside)
            }
            cell.ShareButtonOutlet.tag = indexPath.row
            cell.ShareButtonOutlet.addTarget(self, action: "sharelist:", forControlEvents: .TouchUpInside)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = dateFormatter.stringFromDate(UserLists[indexPath.row].listcreationdate)
            cell.creationDate.text = date
            
            
            if UserLists[indexPath.row].listisfavourite == true {
                favimage = UIImage(named: "FavStar.png") as UIImage!
                cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
            } else {
                notfavimage = UIImage(named: "GrayStar.png") as UIImage!
                cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
            }
            
            
            cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
            
            cell.itemscount.text = String(UserLists[indexPath.row].listitemscount)
            cell.checkeditemscount.text = String(UserLists[indexPath.row].listcheckeditemscount)
            
        } //// END OF ALL LISTS CASE
            else  if showoption == "shoplists" { /// ONLY SHOPS LISTS CASE
                
                
                cell.ShopListNote.text = UserShopLists[indexPath.row].listnote
                
                cell.ShopListNameButton.setTitle(UserShopLists[indexPath.row].listname, forState: .Normal)
                
                
                cell.ShopListNameButton.tag = indexPath.row
                
                    
                cell.ShopListNameButton.addTarget(self, action: "openlistbyname:", forControlEvents: .TouchUpInside)
                    
                cell.DeleteOutlet.tag = indexPath.row
                
                cell.DeleteOutlet.addTarget(self, action: "deletelist:", forControlEvents: .TouchUpInside)
             
                cell.ShareButtonOutlet.tag = indexPath.row
                cell.ShareButtonOutlet.addTarget(self, action: "sharelist:", forControlEvents: .TouchUpInside)
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let date = dateFormatter.stringFromDate(UserShopLists[indexPath.row].listcreationdate)
                cell.creationDate.text = date
                
                
                if UserShopLists[indexPath.row].listisfavourite == true {
                    favimage = UIImage(named: "FavStar.png") as UIImage!
                    cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                    // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                } else {
                    notfavimage = UIImage(named: "GrayStar.png") as UIImage!
                    cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                    // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                }
                
                
                cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                
                cell.itemscount.text = String(UserShopLists[indexPath.row].listitemscount)
                cell.checkeditemscount.text = String(UserShopLists[indexPath.row].listcheckeditemscount)
                
            }
            else  if showoption == "todolists" { /// ONLY TODOS LISTS CASE
                
                cell.ShopListNote.text = UserToDoLists[indexPath.row].listnote
                
                cell.ShopListNameButton.setTitle(UserToDoLists[indexPath.row].listname, forState: .Normal)
                
                
                cell.ShopListNameButton.tag = indexPath.row
                
                
                cell.ShopListNameButton.addTarget(self, action: "opentodolistbyname:", forControlEvents: .TouchUpInside)
                
                cell.DeleteOutlet.tag = indexPath.row
                
                cell.DeleteOutlet.addTarget(self, action: "deletetodolist:", forControlEvents: .TouchUpInside)
                
                cell.ShareButtonOutlet.tag = indexPath.row
                cell.ShareButtonOutlet.addTarget(self, action: "sharelist:", forControlEvents: .TouchUpInside)
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let date = dateFormatter.stringFromDate(UserToDoLists[indexPath.row].listcreationdate)
                cell.creationDate.text = date
                
                
                if UserToDoLists[indexPath.row].listisfavourite == true {
                    favimage = UIImage(named: "FavStar.png") as UIImage!
                    cell.addToFavOutlet.setImage(favimage, forState: UIControlState.Normal)
                    // cell.addToFavOutlet.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                } else {
                    notfavimage = UIImage(named: "GrayStar.png") as UIImage!
                    cell.addToFavOutlet.setImage(notfavimage, forState: UIControlState.Normal)
                    // cell.addToFavOutlet.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                }
                
                
                cell.addToFavOutlet.addTarget(self, action: "adddeletefav:", forControlEvents: .TouchUpInside)
                
                cell.itemscount.text = String(UserToDoLists[indexPath.row].listitemscount)
                cell.checkeditemscount.text = String(UserToDoLists[indexPath.row].listcheckeditemscount)
                
            }
        
            
            return cell
            
        */ /// OLD CODE
    
    

    
    
    //////// END TABLE CONFIGURATION
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
