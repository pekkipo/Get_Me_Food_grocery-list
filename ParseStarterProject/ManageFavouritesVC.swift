//
//  ManageFavouritesVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 19/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Parse

class ManageFavouritesVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var itemsIds = [String]()
    
    var itemsNames = [String]()
    
    
    var imageToLoad = UIImage()
    var imagesToLoad = [UIImage]()
    
    var imagePath = String()
    var imagePaths = [String]()
    
    var itemsiscatalog = [Bool]()
    var itemsoriginal = [String]()

    var itemsisfav = [Bool]()
    
    var itemisdefaultpict = [Bool]()
    var itemoriginalindefaults = [String]()



    /*
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
        
        return UIImage(named: "activity.png")!
    }
    */
    
    
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
    /*
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //try for ios9.2
        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(imageName)
        
        // if(!path.isEmpty){
        if path != "" {
            
            let data = NSData(contentsOfURL:path)
            
            let image = UIImage(data:data!)
            
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
        
        return imageToLoad
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

    
    func itemsretrieval() {
        // var userquery = PF
        var query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.whereKey("belongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isFav", equalTo: true)
        query.whereKey("chosenFromFavs", equalTo: false)
        query.whereKey("chosenFromHistory", equalTo: false)
        query.orderByDescending("CreationDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                
                self.itemsIds.removeAll(keepCapacity: true)
                self.imagePaths.removeAll(keepCapacity: true)
                self.imagesToLoad.removeAll(keepCapacity: true)
                self.itemsiscatalog.removeAll(keepCapacity: true)
                self.itemsoriginal.removeAll(keepCapacity: true)
                self.itemsisfav.removeAll(keepCapacity: true)
                self.itemisdefaultpict.removeAll(keepCapacity: true)
                self.itemoriginalindefaults.removeAll(keepCapacity: true)
                
                if let lists = objects as? [PFObject] {
                    for object in lists {
                        //
                        
                        self.itemsIds.append(object["itemUUID"] as! String)
                        
                        
                        self.itemsNames.append(object["itemName"] as! String)
                       // self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                        
                        
                        self.imagePaths.append(object["imageLocalPath"] as! String)
                        
                        self.itemsiscatalog.append(object["isCatalog"] as! Bool)
                        
                        if object["isCatalog"] as! Bool == false {
                            
                            //self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                            //self.imagesToLoad.append(self.imageToLoad)
                            
                            if object["defaultpicture"] as! Bool == false {
                                
                                self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                self.imagesToLoad.append(self.imageToLoad)
                                
                                /*
                                var imageFile = object["itemImage"] as! PFFile
                                
                                
                                var imageData = imageFile.getData()
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    self.imagesToLoad.append(image!)
                                    
                                } else {
                                    self.imagesToLoad.append(imagestochoose[0].itemimage)
                                }
                                */
                            } else {
                                
                                var imagename = object["OriginalInDefaults"] as! String
                                
                                if (UIImage(named: "\(imagename)") != nil) {
                                    self.imagesToLoad.append(UIImage(named: "\(imagename)")!)
                                } else {
                                    self.imagesToLoad.append(imagestochoose[0].itemimage)
                                }
                                
                            }
                            
                            
                        } else {
                            //if catalog item
                            //if var founditem = find(lazy(catalogitems).map({ $0.itemId }), (object["originalInCatalog"] as! String)) {
                            if var founditem = catalogitems.map({ $0.itemId }).indexOf((object["originalInCatalog"] as! String)) {
                                var catalogitem = catalogitems[founditem]
                                
                                self.imagesToLoad.append(catalogitem.itemimage)
                            }
                        }
                        
                        
                        
                        self.itemsoriginal.append(object["originalInCatalog"] as! String)

                        
                        self.itemsisfav.append(object["isFav"] as! Bool)
                        
                        
                        self.tableView.reloadData()
                    }
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    var itemtounfav = String()
    
    
    func swipedeletefav(indexPathUnFav: NSIndexPath) {
        
        
        
        itemtounfav = itemsIds[indexPathUnFav.row]
        
        itemsIds.removeAtIndex(indexPathUnFav.row)
        itemsNames.removeAtIndex(indexPathUnFav.row)
        imagesToLoad.removeAtIndex(indexPathUnFav.row)
        imagePaths.removeAtIndex(indexPathUnFav.row)
        itemsiscatalog.removeAtIndex(indexPathUnFav.row)
        itemsoriginal.removeAtIndex(indexPathUnFav.row)
        itemsisfav.removeAtIndex(indexPathUnFav.row)
        
        let query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.whereKey("itemUUID", equalTo: itemtounfav)
        query.getFirstObjectInBackgroundWithBlock() {
            
            (item: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let item = item {
                
                item["isFav"] = false
                
                //delete from arrays also!
                
                item.pinInBackground()
                
              //  item.saveEventually()
        
                
            }
            
        }
        
        tableView.deleteRowsAtIndexPaths([indexPathUnFav], withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.reloadData()
        
        
    }
    
    
    func deletefav(sender: UIButton) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! EditFavItemsCell
        let indexPathUnFav = tableView.indexPathForCell(cell)

         itemtounfav = itemsIds[indexPathUnFav!.row]
        
            itemsIds.removeAtIndex(indexPathUnFav!.row)
            itemsNames.removeAtIndex(indexPathUnFav!.row)
            imagesToLoad.removeAtIndex(indexPathUnFav!.row)
            imagePaths.removeAtIndex(indexPathUnFav!.row)
            itemsiscatalog.removeAtIndex(indexPathUnFav!.row)
            itemsoriginal.removeAtIndex(indexPathUnFav!.row)
            itemsisfav.removeAtIndex(indexPathUnFav!.row)
        
        let query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        query.whereKey("itemUUID", equalTo: itemtounfav)
        query.getFirstObjectInBackgroundWithBlock() {
            
            (item: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let item = item {
        
                item["isFav"] = false
                
                //delete from arrays also!
                
                item.pinInBackground()
                
                // item.saveEventually()
                /*
                dispatch_async(dispatch_get_main_queue()) {
                self.tableView.deleteRowsAtIndexPaths([indexPathUnFav!], withRowAnimation: UITableViewRowAnimation.Automatic)
                self.tableView.reloadData()
                }
                */
                
               // self.tableView.deleteRowsAtIndexPaths([indexPathUnFav!], withRowAnimation: UITableViewRowAnimation.Automatic)
               // self.tableView.reloadData()
                
                
            }
            
        }
        
        tableView.deleteRowsAtIndexPaths([indexPathUnFav!], withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.reloadData()
        
    }

    
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         itemsretrieval()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    ///// TABLE STUFF
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return itemsIds.count//oDoItems.count
    }
    
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
        
        let row = indexPath.row
        
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Normal, title: NSLocalizedString("deletebig", comment: "")) { (action , indexPath ) -> Void in
            
            
            // var thissection = indexPath.section
            
            self.editing = false
            
            self.swipedeletefav(indexPath)
            
        }
        
        deleteAction.backgroundColor = UIColorFromRGB(0xF23D55)
        
        
        return [deleteAction]//, shareAction]
    }

    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "favitemcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EditFavItemsCell
        
        
        cell.favitemimage.image = imagesToLoad[indexPath.row]
        cell.favitemname.text = itemsNames[indexPath.row]


        
     //   cell.deletefav.addTarget(self, action: "deletefav:", forControlEvents: .TouchUpInside)

        
        return cell
    }

    
    

}
