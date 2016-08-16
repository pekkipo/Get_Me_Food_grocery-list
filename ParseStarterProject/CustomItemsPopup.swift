//
//  CustomItemsPopup.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 17/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Parse

protocol CustomItemsDelegate
{
    func refreshitemstable()
}

class CustomItemsPopup: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ImagesPopupDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
   // var delegate: CustomItemsDelegate?
    
    
    @IBOutlet var navitem: UINavigationItem!
    
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("addingitem", comment: ""))
    
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
    
    func displayAlert(title: String, message: String) {
        
        
        let customIcon = UIImage(named: "SuccessAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }
    
    
    func cancelCallback() {
        
        print("canceled")
         // tableView.reloadData()
        
    }

    
    var currentcategory: Category?
    
    var currentcategoryitems = [CatalogItem]()
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var newitemimage: UIImageView!
    
    @IBAction func newitemchooseimage(sender: AnyObject) {
        /*
        var chosenimage = UIImagePickerController()
        chosenimage.delegate = self//self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = false
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
*/
        
        performSegueWithIdentifier("showimagesfrommanageitems", sender: self)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        
        /*  let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! CategoryCell
        cell.newcategoryimage.image = chosenimage
        */
        self.newitemimage.image = chosenimage
        
        
        //chosenPicture = chosenimage
        
        
    }
    
    var defaultpict = Bool()
    var originalindefaults = String()
    
    func choosecollectionimage(pict: UIImage, defaultpicture: Bool, picturename: String?) {
        
        self.newitemimage.image = pict
        defaultpict = defaultpicture
        if picturename != nil {
            originalindefaults = picturename!
        } else {
            originalindefaults = ""
        }
    }

    
    @IBOutlet var newitemname: CustomTextField!//UITextField!
    /*
    var imagePath = String()
    
    func saveImageLocally(imageData:NSData!) -> String {
        var imageuuid = NSUUID().UUIDString
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
        
        let pathToSaveImage = dir.stringByAppendingPathComponent("catitemimage\(imageuuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "catitemimage\(imageuuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }

    */
    
    var imagePath = String()
    
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

    
    @IBAction func newitemadd(sender: AnyObject) {
        
       // self.pause()
        
        var newitemuuid = NSUUID().UUIDString
        var newitemid = "CustomCatalog\(newitemuuid)"
        
      
        //let imageData = UIImagePNGRepresentation(chosenPicture)
       // let imageFile = PFFile(name:"itemImage.png", data:imageData)
        

    
        
        var newitem = CatalogItem(itemId: newitemid, itemname: newitemname.text!, itemimage: newitemimage.image!, itemcategory: currentcategory!, itemischecked:false, itemaddedid: "")
        
        customcatalogitems.append(newitem)
        catalogitems.append(newitem)
        currentcategoryitems.append(newitem)
        
        
       // self.displayAlert("Success!", message: "Item added")
        
       // tableView.reloadData()
       
        
        ///NOW Store this to Parse
      //  dispatch_async(dispatch_get_main_queue(), {
            
            var customcatalogitem = PFObject(className:"shopListCatalogItems")
            customcatalogitem["itemid"] = newitemid
            customcatalogitem["itemname"] = self.newitemname.text
            customcatalogitem["itemsbelongstouser"] = PFUser.currentUser()!.objectId!
            customcatalogitem["isDeleted"] = false
            customcatalogitem["itemcategoryid"] = self.currentcategory!.catId
            
            customcatalogitem["defaultpicture"] = self.defaultpict
            customcatalogitem["OriginalInDefaults"] = self.originalindefaults
            var date = NSDate()
            customcatalogitem["CreationDate"] = date
        
            customcatalogitem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        //.dateByAddingTimeInterval()
        
       //. dateByAddingTimeInterval:-7*24*60*60
            
           // let imageData = UIImagePNGRepresentation(self.newitemimage.image!)
           // println(imageData)
        
        
             // let imageFile = PFFile(name:"catalogimage", data:imageData!)
        
            //saveImageLocally(newcategory.catimage)
            //self.saveImageLocally(imageData)
            
           if self.defaultpict == true {
                customcatalogitem["imagepath"] = ""
                customcatalogitem["itemimage"] = NSNull()
                
            } else {
            let imageData = UIImagePNGRepresentation(self.newitemimage.image!)
            saveImageLocally(imageData)
                customcatalogitem["itemimage"] = NSNull()//imageFile
            
                customcatalogitem["imagepath"] = self.imagePath
            }
            
            
           // customcatalogitem["imagepath"] = ""//self.imagePath
            
            customcatalogitem.pinInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    print("saved item")

                } else {
                    print("category wasn't saved")
                }
            })
           // customcatalogitem.saveInBackground()
            
     
        
       
        


        
       // })
        
        self.restore()
        
       // self.displayAlert(NSLocalizedString("DoneExc", comment: ""), message: "Item added")
        dispatch_async(dispatch_get_main_queue(), {
            
            // Restore default
            self.newitemname.text = ""
            self.newitemimage.image = imagestochoose[0].itemimage
            
          //   self.textline.backgroundColor = self.UIColorFromRGB(0xE0E0E0)
            
        self.tableView.reloadData()
        })
        
        /*

        catalogcategories.append(newcategory)
        customcategories.append(newcategory)
        
        
        ///NOW Store this to Parse
        dispatch_async(dispatch_get_main_queue(), {
        
        var customcategory = PFObject(className:"shopListsCategory")
        customcategory["categoryUUID"] = newcategory.catId
        customcategory["catname"] = newcategory.catname
        customcategory["isCustom"] = true
        customcategory["CatbelongsToUser"] = PFUser.currentUser()!.objectId!
        customcategory["isDeleted"] = false
        customcategory["ShouldShowInCatalog"] = false
        //image part start
        // let imageData = UIImagePNGRepresentation(newcategory.catimage)
        //let imageFile = PFFile(name:"categoryImage.png", data:imageData)
        //customcategory["catimage"] = imageFile
        //image part end
        
        //newcategory.catimage.
        
        let imageData = UIImagePNGRepresentation(newcategory.catimage)
        println(imageData)
        
        //saveImageLocally(newcategory.catimage)
        self.saveImageLocally(imageData)
        
        customcategory["imagePath"] = self.imagePath
        
        customcategory.pinInBackgroundWithBlock({ (success, error) -> Void in

        */
        
        tableViewScrollToBottom(true)
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
    }
    
    
    @IBOutlet var addedindicator: UIView!
    
   func deletecustomitem(sender: UIButton!) {
        
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! CustomItemsCell
        let indexPathChange = tableView.indexPathForCell(cell)
        
        
        let itemtodelete =  currentcategoryitems[indexPathChange!.row].itemId
        
        currentcategoryitems.removeAtIndex(indexPathChange!.row)
        
        //if let foundcat = find(lazy(customcatalogitems).map({ $0.itemId }), itemtodelete) {
    if let foundcat = customcatalogitems.map({ $0.itemId }).indexOf(itemtodelete) {
        customcatalogitems.removeAtIndex(foundcat)
        
        }
    
    if let foundcat2 = catalogitems.map({ $0.itemId }).indexOf(itemtodelete) {
        catalogitems.removeAtIndex(foundcat2)
        
    }
    
    
    
        let query = PFQuery(className:"shopListCatalogItems")
        query.fromLocalDatastore()
        query.whereKey("itemid", equalTo: itemtodelete)
        
        query.getFirstObjectInBackgroundWithBlock() {
            
            (item: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let item = item {
                
                
                item["isDeleted"] = true
                
                item.saveEventually()
                
                item.unpinInBackground()
                
                
                
            }
            
        }
        
        
        self.tableView.deleteRowsAtIndexPaths([indexPathChange!], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.reloadData()
        
        
    }
    
    func swipedeletecustomitem(indexPathChange: NSIndexPath) {
        
     
        
        let itemtodelete =  currentcategoryitems[indexPathChange.row].itemId
        
        currentcategoryitems.removeAtIndex(indexPathChange.row)
        
        //if let foundcat = find(lazy(customcatalogitems).map({ $0.itemId }), itemtodelete) {
        if let foundcat = customcatalogitems.map({ $0.itemId }).indexOf(itemtodelete) {
            customcatalogitems.removeAtIndex(foundcat)
            
        }
        
        if let foundcat2 = catalogitems.map({ $0.itemId }).indexOf(itemtodelete) {
            catalogitems.removeAtIndex(foundcat2)
            
        }
        
        
        
        let query = PFQuery(className:"shopListCatalogItems")
        query.fromLocalDatastore()
        query.whereKey("itemid", equalTo: itemtodelete)
        
        query.getFirstObjectInBackgroundWithBlock() {
            
            (item: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let item = item {
                
                
                item["isDeleted"] = true
                
               // item.saveEventually()
                
                item.unpinInBackground()
                
                
                
            }
            
        }
        
        
        self.tableView.deleteRowsAtIndexPaths([indexPathChange], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.reloadData()
        
        
    }

    
    func finditems() {
        
        for item in customcatalogitems {
            if item.itemcategory == currentcategory {
                currentcategoryitems.append(item)
                

            } else {
                print("This item doesn't belong")
            }
        }

    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showimagesfrommanageitems" {
            
            let popoverViewController = segue.destinationViewController as! ImagesCollectionVC//UIViewController
            
            
            
            popoverViewController.delegate = self
            
        }
    }

    
    //showimagesfrommanageitems
    
    /// Text field stuff
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //textline.backgroundColor = UIColorFromRGB(0x31797D)
        
        return
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if newitemname.text! == "" {
            //textline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
        } else {
          //  textline.backgroundColor = UIColorFromRGB(0x31797D)
        }
        
        textField.resignFirstResponder()
        return true
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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        finditems()
        
        newitemname.leftTextMargin = 1
        
        newitemname.textInputView.tintColor = UIColorFromRGB(0x31797D)
        
        tableView.tableFooterView = UIView()
        
        newitemname.delegate = self
        
        navitem.title = currentcategory?.catname
        
        addedindicator.alpha = 0
        addedindicator.layer.cornerRadius = 8
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return currentcategoryitems.count//oDoItems.count
    }
    
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
        
        let row = indexPath.row
        
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
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: NSLocalizedString("delete", comment: "")) { (action , indexPath ) -> Void in
            
            
            
            self.editing = false
            
            self.swipedeletecustomitem(indexPath)
        }
        
        deleteAction.backgroundColor = UIColorFromRGB(0xF23D55)
        
        
        
        return [deleteAction]//, shareAction]
    }
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "customitem"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomItemsCell
        
        
        cell.itemimage.image = currentcategoryitems[indexPath.row].itemimage
        cell.itemname.text = currentcategoryitems[indexPath.row].itemname
              
        
        
        //cell.itemdelete.addTarget(self, action: "deletecustomitem:", forControlEvents: .TouchUpInside)
        
        
        
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
