//
//  ManageCategoriesVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 17/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

protocol ManageCatsDelegate
{
    
    func handlecustomcat(added: Bool)
    //func handlecustomcat(acttype: String, indexes: [Int])
    //acttype - "add" or "delete"
    
    //delete all items and add them again in AddItemVC
}

class ManageCategoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ImagesPopupDelegate,UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    var chosencategory : Category?
    
    var additemdelegate: ManageCatsDelegate?

    
    @IBOutlet var newcatimage: UIImageView!
    
    @IBOutlet var newcatname: CustomTextField!//UITextField!
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    
    
    @IBAction func newcatimagechoose(sender: AnyObject) {
  
        performSegueWithIdentifier("showimagesfrommanagecats", sender: self)
    }
    
    func choosecollectionimage(pict: UIImage, defaultpicture: Bool, picturename: String?) {
        
         self.newcatimage.image = pict
        defaultpict = defaultpicture
        if picturename != nil {
            originalindefaults = picturename!
        } else {
            originalindefaults = ""
        }

    }
    
    
    var defaultpict = Bool()
    var originalindefaults = String()
    
    @IBAction func addnewcat(sender: AnyObject) {
        
        
        var newcatuuid = NSUUID().UUIDString
        var newcatid = "custom\(newcatuuid)"
        
        var newcategory = Category(catId: newcatid, catname: newcatname.text!, catimage: newcatimage.image!, isCustom: true, isAllowed: true)
        

        newcategory.addCategory(newcategory, isdefaultpict: defaultpict, defaultpictname: originalindefaults)
        

        
       // JSSAlertView().show(self, title: "Added!")
        tableViewScrollToBottom(true)
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
        // Restore default
        newcatname.text = ""
        newcatimage.image = catalogcategories[0].catimage
        
        textline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        
        tableView.reloadData()
        
        waschanged = true
        
    }
    
    var waschanged : Bool = false
    // this is to find out if anything was changed
    
    override func viewWillDisappear(animated: Bool) {
        if waschanged == true {
        if additemdelegate != nil {
            additemdelegate?.handlecustomcat(true)
        }
        }
    }
    
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    
    
    @IBOutlet var addedindicator: UIView!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        

        self.newcatimage.image = chosenimage
        
        // DON'T USE THAT ANYMORE
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
 
        
        if segue.identifier == "showcatitems" {
            
            //  let Nav = segue.destinationViewController as! UINavigationController
             // let VC = Nav.viewControllers.first as! CustomItemsPopup
            
             let VC = segue.destinationViewController as! CustomItemsPopup
            
            VC.currentcategory = chosencategory//
                       
            
        }
        if segue.identifier == "showimagesfrommanagecats" {
            
            let popoverViewController = segue.destinationViewController as! ImagesCollectionVC//UIViewController
            
            
            
            popoverViewController.delegate = self
            
        }

        //showimagesfrommanagecats

    }
    
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("deleting", comment: ""))
    
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
        
        
        let customIcon = UIImage(named: "SuccessAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }

    
    func cancelCallback() {
        
        print("canceled")
        
    }


    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewWillAppear(animated: Bool) {
    
    
    
    }
    
    /// Text field stuff
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //here
        textline.backgroundColor = UIColorFromRGB(0x31797D)
        newcatname.textInputView.tintColor = UIColorFromRGB(0x31797D)
        
        return
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //here
        if newcatname.text! == "" {
            textline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
        } else {
            textline.backgroundColor = UIColorFromRGB(0x31797D)
        }
        
        textField.resignFirstResponder()
        return true
    }
    //myTextField.delegate = self
    ///
    /*
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    */
    
    @IBOutlet var textline: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newcatname.delegate = self
        
        newcatname.text = ""

        newcatname.leftTextMargin = 1
        
       
        
        //newcatname.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        //newcatname.layer.borderWidth = 1
        //newcatname.layer.cornerRadius = 4
        
        
        addedindicator.alpha = 0
        addedindicator.layer.cornerRadius = 8
        addedindicator.backgroundColor = UIColorFromRGB(0x2a2f36)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeallowed(sender: UISwitch!) {
        
        
        let switcher = sender as UISwitch
        let view = switcher.superview!
        let cell = view.superview as! EditCategoriesCell
        let indexPathChange = tableView.indexPathForCell(cell)
        
        
        let cattochange = customcategories[indexPathChange!.row].catId
        
       // var allowed = Bool()
        
        let allowed : Bool = customcategories[indexPathChange!.row].isAllowed!
        
      //  if sender.on == true {
      //      allowed = true
      //  } else {
      //      allowed = false
      //  }

        print("Allowed = \(allowed)")
        
      //  println("TestAllowed = \(testallowed)")
        
        if allowed == false {//cell.categoryshowcatalog.on {
       
        customcategories[indexPathChange!.row].isAllowed = true
        
        //if let foundcat = find(lazy(catalogcategories).map({ $0.catId }), cattochange) {
            if let foundcat = catalogcategories.map({ $0.catId }).indexOf(cattochange) {
           // catalogcategories.removeAtIndex(foundcat)
            catalogcategories[foundcat].isAllowed = true
            
        }

        let query = PFQuery(className:"shopListsCategory")
        query.fromLocalDatastore()
        // query2.getObjectInBackgroundWithId(listtodelete!) {
        query.whereKey("categoryUUID", equalTo: cattochange)

        query.getFirstObjectInBackgroundWithBlock() {
            
            (category: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let category = category {
                
                
              //  category["isDeleted"] = true
                
                category["ShouldShowInCatalog"] = true
                
                category.pinInBackground()
               // category.saveEventually()
                
               // category.unpinInBackground()
                
                
            }
            
        }
        
        sender.on = true
            
        } else if allowed == true {//else if cell.categoryshowcatalog.on == true {
            
            customcategories[indexPathChange!.row].isAllowed = false
            
            //if let foundcat = find(lazy(catalogcategories).map({ $0.catId }), cattochange) {
            if let foundcat = catalogcategories.map({ $0.catId }).indexOf(cattochange) {
                //catalogcategories.removeAtIndex(foundcat)
                catalogcategories[foundcat].isAllowed = false
                
            }
            
            let query = PFQuery(className:"shopListsCategory")
            query.fromLocalDatastore()
            // query2.getObjectInBackgroundWithId(listtodelete!) {
            query.whereKey("categoryUUID", equalTo: cattochange)
            
            query.getFirstObjectInBackgroundWithBlock() {
                
                (category: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let category = category {
                    
                    
                    //category["isDeleted"] = true
                    
                    category["ShouldShowInCatalog"] = false
                    
                    
                    category.pinInBackground()
                    
                   // category.saveEventually()
                    
                    
                }
                
            }
            
            sender.on = false
            
        }
        
        tableView.reloadData()
    }
    
    func swipedeletecustomcategory(deleterow: NSIndexPath) {
        
        self.pause()
        
    
        
        var cattodelete = customcategories[deleterow.row].catId
        
        
        customcategories.removeAtIndex(deleterow.row)
        
        //if var foundcat = find(lazy(catalogcategories).map({ $0.catId }), cattodelete) {
        if var foundcat = catalogcategories.map({ $0.catId }).indexOf(cattodelete) {
            catalogcategories.removeAtIndex(foundcat)
            
        }
        
        var query = PFQuery(className:"shopListsCategory")
        query.fromLocalDatastore()
        query.whereKey("categoryUUID", equalTo: cattodelete)
        
        query.getFirstObjectInBackgroundWithBlock() {
            
            (category: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let category = category {
                
                
                category["isDeleted"] = true
                
                // category.saveEventually()
                
                category.unpinInBackground()
                
                
                
            }
            
        }
        
        
        self.tableView.deleteRowsAtIndexPaths([deleterow], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.reloadData()
        
        waschanged = true
        
        
        //now I have to find all items with this category as Category field and change it to DefaultOthers
        var query1 = PFQuery(className:"shopItems")
        query1.fromLocalDatastore()
        query1.whereKey("Category", equalTo: cattodelete)
        query1.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                
                if let listitems = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in listitems {
                        
                        object["Category"] = "DefaultOthers"
                        
                        object.pinInBackground()
                        
                      //  object.saveEventually()
                        
                        
                    }
                    
                    
                    self.restore()
                    self.displaySuccessAlert(NSLocalizedString("catrem1", comment: ""), message: NSLocalizedString("catrem2", comment: ""))
                }
                
                
                
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    
    func deletecustomcategory(sender: UIButton!) {
        
        self.pause()
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! EditCategoriesCell
        let indexPathChange = tableView.indexPathForCell(cell)
        
        
        var cattodelete = customcategories[indexPathChange!.row].catId
    
            
            customcategories.removeAtIndex(indexPathChange!.row)
            
           // if var foundcat = find(lazy(catalogcategories).map({ $0.catId }), cattodelete) {
        if var foundcat = catalogcategories.map({ $0.catId }).indexOf(cattodelete) {
                 catalogcategories.removeAtIndex(foundcat)
             
            }
            
            var query = PFQuery(className:"shopListsCategory")
            query.fromLocalDatastore()
            query.whereKey("categoryUUID", equalTo: cattodelete)
            
            query.getFirstObjectInBackgroundWithBlock() {
                
                (category: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let category = category {
                    
                    
                    category["isDeleted"] = true
                    
                  //   category.saveEventually()
                    
                    category.unpinInBackground()
                   
                    
                    
                }
                
            }
            
        
        self.tableView.deleteRowsAtIndexPaths([indexPathChange!], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.reloadData()
        
        
        //now I have to find all items with this category as Category field and change it to DefaultOthers
        var query1 = PFQuery(className:"shopItems")
        query1.fromLocalDatastore()
        query1.whereKey("Category", equalTo: cattodelete)
        query1.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")

                
                if let listitems = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in listitems {
                        
                        object["Category"] = "DefaultOthers"
                        
                        object.pinInBackground()
                        
                        //object.saveEventually()
                      
                        
                    }
                    
                    self.restore()
                    self.displaySuccessAlert(NSLocalizedString("catrem1", comment: ""), message: NSLocalizedString("catrem2", comment: ""))
                }
                
              
                
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
 
    }
    
    func showitems(sender: UIButton) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! EditCategoriesCell
        let indexPathChange = tableView.indexPathForCell(cell)
        
        
        chosencategory = customcategories[indexPathChange!.row]
        
        performSegueWithIdentifier("showcatitems", sender: self)
        
    }
    
    
    ///// TABLE STUFF
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return customcategories.count//oDoItems.count
    }
    
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            
    }
    

    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Normal, title: NSLocalizedString("delete", comment: "")) { (action , indexPath ) -> Void in
            
            
            // var thissection = indexPath.section
            
            self.editing = false
           
                self.swipedeletecustomcategory(indexPath)
            
        }
        
        deleteAction.backgroundColor = UIColorFromRGB(0xF23D55)
       
        
        return [deleteAction]//, shareAction]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        chosencategory = customcategories[indexPath.row]
        
        performSegueWithIdentifier("showcatitems", sender: self)
        
        //let row = indexPath.row
        
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
    
    /*
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { (action , indexPath ) -> Void in
            
            
            
            self.editing = false
            
            //self.swipedeleteitem(indexPath)
        }
        
        deleteAction.backgroundColor = UIColorFromRGB(0x1695A3)
        
        
        
        return [deleteAction]//, shareAction]
    }
    */
    /*
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 30
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return NSLocalizedString("yourcats", comment: "")
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
    */
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "editcatcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EditCategoriesCell
        
        
        cell.categoryimage.image = customcategories[indexPath.row].catimage
        cell.categoryname.text = customcategories[indexPath.row].catname
        
        if customcategories[indexPath.row].isAllowed == true {
            
            cell.categoryshowcatalog.on = true
            
        } else {
            cell.categoryshowcatalog.on = false

        }


            cell.categoryshowcatalog.addTarget(self, action: "changeallowed:", forControlEvents: .ValueChanged)
        
           // cell.categorydelete.addTarget(self, action: "deletecustomcategory:", forControlEvents: .TouchUpInside)
        
            cell.showcatitems.addTarget(self, action: "showitems:", forControlEvents: .TouchUpInside)

        
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
