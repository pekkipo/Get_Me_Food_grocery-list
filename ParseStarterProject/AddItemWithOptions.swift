//
//  AddItemWithOptions.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 28/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import QuartzCore

var HistoryitemsDataDict = [Dictionary<String, AnyObject>]()

class AddItemWithOptions: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshAddWithOptions, UITextFieldDelegate {

    
    var shoplistdelegate : RefreshListDelegate?
    
    func optionsgetscaninfo() {
        //add new item with name from scanned data
        //Or Easier! Just put this name to textfield
    }
    
    @IBAction func DoneEditingItems(sender: AnyObject) {
        
        shoplistdelegate?.refreshtable()
        
        performSegueWithIdentifier("backtocreationafteroptions", sender: self)
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        
        shoplistdelegate?.refreshtable()
        
        performSegueWithIdentifier("backtocreationafteroptions", sender: self)
    }
    
    @IBAction func unwindToAddOptions(sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func refreshaddoptions() {
        
        tableViewItems.reloadData()
        
        
    }
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var itemid = String()
    
    var itemsIds = [String]()
    
    var currentlist = String()
    
    var dictionary = Dictionary<String, AnyObject>()
    
    //var itemsDataDict = [Dictionary<String, AnyObject>]()
    
    //var itemsDataDictFromHistory = [Dictionary<String, AnyObject>]()
    
    var itemtoedit = String()
    
    var itemtodelete = String()
    
    var imagePath = String()
    
    var imageToLoad = UIImage()
    
    @IBOutlet weak var itemName: CustomTextField!//UITextField!
    
    
    @IBOutlet weak var noitemslabel: UILabel!
    
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
    
    /*
    func getid() -> String {
        
        
    
    }
    */
    
    
    @IBAction func unwindToAddWithOptions(sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
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
        
        return UIImage(named: "restau.png")!
    }
    */
    
    
    @IBAction func addItem(sender: AnyObject) {
        
        var image = imagestochoose[0].itemimage//UIImage(named: "defaultitemimage.png")
       // let imageData = UIImagePNGRepresentation(image)
        //let imageFile = PFFile(name:"itemImage.png", data:imageData)
        
        pause()
        //creation of an itemlist
        var shopItem = PFObject(className:"shopItems")
        
        var itemuuid = NSUUID().UUIDString
        
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = itemName.text
        shopItem["itemImage"] = NSNull()//imageFile
        shopItem["itemNote"] = ""
        shopItem["itemQuantity"] = ""
        shopItem["itemPriceS"] = ""//0.0
        shopItem["TotalSumS"] = ""//0.0
        
        shopItem["ItemsList"] = currentlist
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        shopItem["itemUnit"] = ""
        shopItem["perUnit"] = ""
        shopItem["chosenFromHistory"] = false
        shopItem["isChecked"] = false
        
        
        shopItem["Category"] = catalogcategories[0].catId
        shopItem["isCatalog"] = false
        shopItem["originalInCatalog"] = ""
        
       // self.saveImageLocally(imageData)
        shopItem["imageLocalPath"] = ""//self.imagePath
        
        shopItem["defaultpicture"] = true
        shopItem["OriginalInDefaults"] = imagestochoose[0].imagename
        
        shopItem["isFav"] = false
        
        shopItem["chosenFromFavs"] = false
        
        var date = NSDate()
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
        
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
         shopItem["isHistory"] = true //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        //shopItem["Category"] =
        
        //dispatch_async(dispatch_get_main_queue(), {
        //shopItem.pinInBackground()
            shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    
                    print("saved item")
                    print("IMPORTANT BITCH IS  \(itemuuid)")
                    
                        // self.itemid = shopItem.objectId!
                       // self.itemid = shopItem.objectId!
                        self.itemid = itemuuid

                        var itemname = self.itemName.text!
                        var itemnote = ""
                        var itemquantity = ""
                        var itemprice = ""//0.0
                        var itemoneunitprice = ""//0.0
                        //var itemimage = imageFile
                        var itemischecked = false
                        var itemimagepath = self.imagePath
                        var itemunit = ""
                        var itemperunit = ""
                        //self.loadImageFromLocalStore(itemimagepath)
                       // var itemimage2 = self.imageToLoad
                        var itemimage2 = imagestochoose[0].itemimage
                        var itemisdefaultpict = true
                        var itemoriginalindefaults = imagestochoose[0].imagename
                    
                        var itemcategory = catalogcategories[0].catId
                        var itemiscatalog = false
                        var originalincatalog = ""                        
                    
                        var itemcategoryname = catalogcategories[0].catname
                    
                        var itemisfav = false
                    
                        self.dictionary = ["ItemId":self.itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname,"ItemOneUnitPrice":itemoneunitprice,"ItemIsFav":itemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":itemisdefaultpict,"ItemOriginalInDefaults":itemoriginalindefaults]
                    
                   
                    
                        itemsDataDict.append(self.dictionary)
                        HistoryitemsDataDict.append(self.dictionary)
                    
                        shoppingcheckedtocopy.append(false)
                        //}
                        
                        print("Items are \(itemsDataDict)")
                        
                        
                        self.tableViewItems.reloadData()
                        self.restore()
                    
                        self.noitemslabel.hidden = true
                    
                } else {
                    print("Item wasn't saved")
                }
            })
        
        /*
        shopItem.saveInBackgroundWithBlock {
        //shopItem.saveEventually() {
            //  shopItem.pinInBackground() {
            //eventually means that it is saved offline first
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("ITEM WAS ALSO SAVED TO SERVER")
            } else {
                // There was a problem, check error.description
                print("Item wasn't saved to server")
            }
        }
        */
    //})
        
        //for var i = 0;i<itemsDataDict.count;++i {
       // var itemid = item
        //var itemId : String = itemid
        
        /*
        var itemname = itemName.text
        var itemnote = ""
        var itemquantity = ""
        var itemprice = 0.0
        //var itemimage = imageFile
        var itemischecked = false
        var itemimagepath = imagePath
        var itemunit = ""
        dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked]
        
        itemsDataDict.append(dictionary)
        //}
        
        println("Items are \(itemsDataDict)")
        
        
       tableViewItems.reloadData()
        */
        
        if HistoryitemsDataDict.count == 0 {
            self.noitemslabel.hidden = false
        } else {
            self.noitemslabel.hidden = true
        }
    
    }
    
    
    func deleteitem(sender: UIButton!) {
        
        //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! dynamicItemsCell
        let indexPathDelete = tableViewItems.indexPathForCell(cell)
        
        //immediate deletion from the table - works perfectly!
        print(indexPathDelete!.row)
        itemtodelete = ((HistoryitemsDataDict[indexPathDelete!.row] as NSDictionary).objectForKey("ItemId")) as! String
        
        dictionary.removeValueForKey("ItemId")
        dictionary.removeValueForKey("ItemName")
        dictionary.removeValueForKey("ItemNote")
        // dictionary.removeValueForKey("ItemImage")
        dictionary.removeValueForKey("ItemImage2")
        dictionary.removeValueForKey("ItemImagePath")
        dictionary.removeValueForKey("ItemQuantity")
        dictionary.removeValueForKey("ItemTotalPrice")
        dictionary.removeValueForKey("ItemUnit")
        dictionary.removeValueForKey("ItemChecked")
        dictionary.removeValueForKey("ItemCategory")
        dictionary.removeValueForKey("ItemIsCatalog")
        dictionary.removeValueForKey("ItemOriginal")
        dictionary.removeValueForKey("ItemCategoryName")
        dictionary.removeValueForKey("ItemOneUnitPrice")
        dictionary.removeValueForKey("ItemIsFav")
        dictionary.removeValueForKey("ItemPerUnit")
        
        
        
        itemsDataDict.removeAtIndex(indexPathDelete!.row)
        HistoryitemsDataDict.removeAtIndex(indexPathDelete!.row)
        
        if HistoryitemsDataDict.count == 0 {
            self.noitemslabel.hidden = false
        }
        
       // dispatch_async(dispatch_get_main_queue(), {
            let querynew = PFQuery(className:"shopItems")
            //querynew.getObjectInBackgroundWithId(self.itemtodelete) {
            querynew.whereKey("itemUUID", equalTo: self.itemtodelete)
            querynew.getFirstObjectInBackgroundWithBlock() {

                (itemList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let itemList = itemList {
                    
                    itemList.deleteInBackground()
                    
                }
                
            }
        //})
        
        let querynew1 = PFQuery(className:"shopItems")
        querynew1.fromLocalDatastore()
       // querynew1.getObjectInBackgroundWithId(itemtodelete) {
        querynew1.whereKey("itemUUID", equalTo: self.itemtodelete)
        //querynew.getObjectInBackgroundWithId(self.itemtodelete) {
        querynew1.getFirstObjectInBackgroundWithBlock() {
            (itemList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let itemList = itemList {

                itemList.unpinInBackground()
                
            }

        }
        
        self.tableViewItems.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)

    }
    
    /*
    func deleteitemhere(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! dynamicItemsCell
        let indexPathItem = tableViewItems.indexPathForCell(cell)
        
        itemtoedit = ((HistoryitemsDataDict[indexPathItem!.row] as NSDictionary).objectForKey("ItemId")) as! String
        
        
        println("TO EDIT IS \(itemtoedit)")
        
        performSegueWithIdentifier("EditItemFromOptions", sender: cell)
        
    }
    */
    
    func edititemhere(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! dynamicItemsCell
        let indexPathItem = tableViewItems.indexPathForCell(cell)
        
        itemtoedit = ((HistoryitemsDataDict[indexPathItem!.row] as NSDictionary).objectForKey("ItemId")) as! String
        
        
        print("TO EDIT IS \(itemtoedit)")
        
        performSegueWithIdentifier("EditItemFromOptions", sender: cell)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "toProductHistory" {
            
           // let navVC = segue.destinationViewController as! UINavigationController
            
           // let productHistoryVC = navVC.viewControllers.first as! ProductHistoryTableViewController
            
            let productHistoryVC : ProductHistoryTableViewController = segue.destinationViewController as! ProductHistoryTableViewController
            
            productHistoryVC.thiscurrentlist = currentlist
            //here I pass the current lists id to product history tableViewController
            
            productHistoryVC.shoplistdelegate = shoplistdelegate
            
        }
        
        if segue.identifier == "EditItemFromOptions" {
            
             // let editVCitem : AddItemViewController = segue.destinationViewController as! AddItemViewController
            // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
            
           // if let indexPath = self.tableViewItems.indexPathForSelectedRow() {
            
          //  let blurEffect: UIBlurEffect = UIBlurEffect(style: .Light)
            
           // let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
          //  blurView.translatesAutoresizingMaskIntoConstraints = false//setTranslatesAutoresizingMaskIntoConstraints(false)
            
            
            let editVCitem = segue.destinationViewController as! AddItemViewController//UIViewController
          //  editVCitem.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.85)//UIColorFromRGB(0x1695A3).colorWithAlphaComponent(0.85)
            //toViewController.view.addSubview(vibrancyView)
          //  editVCitem.view.addSubview(blurView)
            
           // self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            
            editVCitem.sendercontroller = "EditWithOptions"
            
            editVCitem.withoptionsdelegete = self
            
            /*
            editVC.shopdelegate = self
            
            editVC.existingitem = true
            editVC.currentitem = itemtoedit
            
            editVC.getcurrentlist = currentList
            
            editVC.sendercontroller = "ShopListCreation"
*/
            
            
             if let indexPath = tableViewItems.indexPathForCell(sender as! UITableViewCell) {
                editVCitem.existingitem = true
                editVCitem.currentitem = itemtoedit
                
                editVCitem.getcurrentlist = currentlist
            }

            
        }
        
        if segue.identifier == "showcatalog" {
            
           // let catalogNav = segue.destinationViewController as! UINavigationController
            
            //let catalogVC = catalogNav.viewControllers.first as! CatalogTableViewController
            
             let catalogVC  : CatalogTableViewController = segue.destinationViewController as! CatalogTableViewController
            
            
            catalogVC.currentcataloglist = currentlist
            //here I pass the current lists id to product history tableViewController
            
            catalogVC.shoplistdelegate = shoplistdelegate
            catalogVC.shoplistoptinsdelegate = self
            
        }
        
        //showfavourites
        if segue.identifier == "showfavourites" {
            
            //let favNav = segue.destinationViewController as! UINavigationController
            
           // let favVC = favNav.viewControllers.first as! FavouriteItems
            
              let favVC  : FavouriteItems = segue.destinationViewController as! FavouriteItems
            
            favVC.thiscurrentlist = currentlist
            //here I pass the current lists id to product history tableViewController
            
            favVC.shoplistdelegate = shoplistdelegate
            
        }
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        tableViewItems.reloadData()
        
        if HistoryitemsDataDict.count == 0 {
            self.noitemslabel.hidden = false
        } else {
            self.noitemslabel.hidden = true
        }

    }
    
    
    @IBOutlet weak var tableViewItems: UITableView!
    
    
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

        // Do any additional setup after loading the view.
        
       // itemName.layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
        
        itemName.delegate = self
        
        itemName.leftTextMargin = 5
        
        tableViewItems.delegate = self
        
        tableViewItems.dataSource = self
        
        let nib = UINib(nibName: "dynamicItemsCell", bundle:nil)
        self.tableViewItems.registerNib(nib, forCellReuseIdentifier: "dynamiccell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 4
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (section == 3) {
            if HistoryitemsDataDict != [] {
                return HistoryitemsDataDict.count
            } else {
                return 0
            }
 
        }
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        if (section == 3)
        {
            return NSLocalizedString("thefollowingitems", comment: "")
        }
      return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 3) {
            return 30.0
        } else {
            return 0
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
  
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
       
        
        header.contentView.backgroundColor = UIColorFromRGB(0xEFEFEF)//UIColor(red: 238/255, green: 168/255, blue: 15/255, alpha: 0.8)
        header.textLabel!.textColor = UIColorFromRGB(0x31797D)//UIColor.whiteColor()
        header.alpha = 1
        
        var topline = UIView(frame: CGRectMake(0, 0, header.contentView.frame.size.width, 1))
        topline.backgroundColor = UIColorFromRGB(0x31797D)
        
        header.contentView.addSubview(topline)
        
        var bottomline = UIView(frame: CGRectMake(0, 30, header.contentView.frame.size.width, 1))
        bottomline.backgroundColor = UIColorFromRGB(0x31797D)
        
        header.contentView.addSubview(bottomline)
        
    }
    



    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        var itemcell: dynamicItemsCell!
        
        
        
        if (indexPath.section == 0) {
            cell = tableView.dequeueReusableCellWithIdentifier("historyitem", forIndexPath: indexPath) 
            
            //cell.cardSetName?.text = self.cardSetObject["name"] as String
            
        }else if (indexPath.section == 1) {
            cell = tableView.dequeueReusableCellWithIdentifier("catalogitem", forIndexPath: indexPath) // just return the cell without any changes to show whats designed in storyboard
            
        } else if (indexPath.section == 2) {
            cell = tableView.dequeueReusableCellWithIdentifier("favouriteitem", forIndexPath: indexPath) // just return the cell without any changes to show whats designed in storyboard
            
      
    
            } else if (indexPath.section == 3) {
            itemcell = tableView.dequeueReusableCellWithIdentifier("dynamiccell", forIndexPath: indexPath) as! dynamicItemsCell
            
          //  itemcell.edititem.addTarget(self, action: "edititemhere:", forControlEvents: .TouchUpInside)
            
            itemcell.deleteitem.addTarget(self, action: "deleteitem:", forControlEvents: .TouchUpInside)
            
            //itemcell.itemname.text = "Item is \(itemsIds[indexPath.row])"
            
            if HistoryitemsDataDict != [] {
            //itemcell.itemname.text = ((HistoryitemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemName")) as? String
                itemcell.itemnamebutton.setTitle(((HistoryitemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemName")) as? String, forState: .Normal)
                 itemcell.itemnamebutton.addTarget(self, action: "edititemhere:", forControlEvents: .TouchUpInside)
                
            
            // itemcell.itemimage.image = ((HistoryitemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemImage")) as? UIImage
                itemcell.itemimage.image = ((HistoryitemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemImage2")) as? UIImage
            } else {
                //itemcell.itemname.text = "No items added so far"
            }
            
            
            
                    }
        
        if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        
        return cell
        } else {
            return itemcell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        if indexPath.section == 2 {
           
        }
*/
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //println(self.shoppingListItemsIds[row])
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
