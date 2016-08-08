//
//  SortPopup.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 14/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

protocol sortlistsDelegate
{
    func sortandrefreshlists()
    func refreshlists()
    func backfromsort()
    func changeshowoptions(option: String)
}

class SortPopup: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    var delegate: sortlistsDelegate?
    
    func UIColorFromRGB(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)
        )
    }
    
    // TABLE STUFF
    
    var tablelabels0 = [
        NSLocalizedString("showalllists", comment: ""),
        NSLocalizedString("showonlyshops", comment: ""),
        NSLocalizedString("showonlytodos", comment: ""),
        NSLocalizedString("showonlyfavs", comment: "")
    ]
    
    var tablelabels1 = [
        NSLocalizedString("popasc", comment: ""),
        NSLocalizedString("popdesc", comment: ""),
        NSLocalizedString("popalpha", comment: "")
        ]
    /*
    var tablelabels2 = [
    NSLocalizedString("popcheck", comment: ""),
    NSLocalizedString("calculatesumlists", comment: ""),
    NSLocalizedString("statistics", comment: ""),
    ]
    */
    
    var tablelabels2 = [
        NSLocalizedString("popcheck", comment: "")
        ]
    
    
    var tablelabels3 = [
        NSLocalizedString("close", comment: "")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
       
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // var customcell: CategoryCell!
        var cell: sortpopupcell!
        
      
            //if search is active
            cell = tableView.dequeueReusableCellWithIdentifier("popupcell", forIndexPath: indexPath) as! sortpopupcell
        

            cell.caption.textColor = UIColorFromRGB(0x31797D, alp: 1.0)

        
        if indexPath.section == 3 {
            cell.caption.textColor = UIColorFromRGB(0xF23D55, alp: 1.0)
        }
        
        if indexPath.section == 0 {
            cell.caption.text = tablelabels0[indexPath.row]
        } else if indexPath.section == 1 {
            cell.caption.text = tablelabels1[indexPath.row]
        } else if indexPath.section == 2 {
            cell.caption.text = tablelabels2[indexPath.row]
        } else if indexPath.section == 3 {
            cell.caption.text = tablelabels3[indexPath.row]
        }
        
        //cell.caption.text = tablelabels[indexPath.row]
            
            
            return cell
      
        
        
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
    
    func checkreceivedlists(indexPath: NSIndexPath) {
        
        // activate indicator
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! sortpopupcell
        
        cell.actindicator.hidden = false
        cell.actindicator.startAnimation()
        
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
                        self.delegate?.sortandrefreshlists()
                        cell.actindicator.stopAnimation()
                        cell.actindicator.hidden = true
                        self.fadecheck(indexPath, err: false)
                    })
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                cell.actindicator.stopAnimation()
                cell.actindicator.hidden = true
                self.fadecheck(indexPath, err: true)
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
                        self.delegate?.sortandrefreshlists()
                        cell.actindicator.stopAnimation()
                        cell.actindicator.hidden = true
                        self.fadecheck(indexPath, err: false)
                    })
                    
                    
                    
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                cell.actindicator.stopAnimation()
                cell.actindicator.hidden = true
                self.fadecheck(indexPath, err: true)
            }
        }
        
    }
    
    func fadecheck(indexPath: NSIndexPath, err: Bool) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! sortpopupcell
        if !err {
        cell.checkmark.alpha = 1
        cell.checkmark.fadeOut()
        } else {
            cell.errormark.alpha = 1
            cell.errormark.fadeOut()
        }
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        //alertview.addCancelAction(closeCallback)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        /*
        if indexPath.row == 0 {
            delegate?.refreshlists()
        } else if indexPath.row == 1 {
            sortbydateasc()
        } else if indexPath.row == 2 {
            sortbydate()
        } else if indexPath.row == 3 {
            sortalphabetically()
        } else if indexPath.row == 4 {
            close()
        }
        */
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                delegate?.changeshowoptions("alllists")
                fadecheck(indexPath, err: false)
            } else if indexPath.row == 1 {
                delegate?.changeshowoptions("shoplists")
                fadecheck(indexPath, err: false)
            } else if indexPath.row == 2 {
                delegate?.changeshowoptions("todolists")
                fadecheck(indexPath, err: false)
            } else if indexPath.row == 3 {
                delegate?.changeshowoptions("favs")
                fadecheck(indexPath, err: false)
            }
            
             self.dismissViewControllerAnimated(true, completion: nil)
            
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                sortbydateasc()
                fadecheck(indexPath, err: false)
            } else if indexPath.row == 1 {
                sortbydate()
                fadecheck(indexPath, err: false)
            } else if indexPath.row == 2 {
                sortalphabetically()
                fadecheck(indexPath, err: false)
            }
            
             self.dismissViewControllerAnimated(true, completion: nil)
            
        } else if indexPath.section == 2 {
            
            if indexPath.row == 0 {
                //delegate?.refreshlists()
                if CheckConnection.isConnectedToNetwork() {
                checkreceivedlists(indexPath)
                } else {
                fadecheck(indexPath, err: true)
                    displayFailAlert(NSLocalizedString("NoConnection", comment: ""), message: NSLocalizedString("cannotcheck", comment: ""))
                }
            }
            
        } else if indexPath.section == 3 {
            close()
        }
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*
        if section == 0 {
            return NSLocalizedString("sortoptions", comment: "")
        } else if section == 1 {
            return NSLocalizedString("listsoptions", comment: "")
        } else {
        return ""
        }*/
        return ""
            }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      //return tablelabels.count
        if section == 0 {
            return tablelabels0.count
        } else if section == 1 {
            return tablelabels1.count
        } else if section == 2 {
            return tablelabels2.count
        } else if section == 3 {
            return tablelabels3.count
        } else {
            return 1
        }
    }
    
    ///
    
    func close() {
        
        delegate?.backfromsort()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    func sortbydate() {
        
        UserLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserShopLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserToDoLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        UserFavLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedDescending })
        
        delegate?.sortandrefreshlists()
        
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func sortbydateasc() {
        
        UserLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending })
        UserShopLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending  })
        UserToDoLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending  })
        UserFavLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending  })
        
        delegate?.sortandrefreshlists()
        
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func sortalphabetically() {
        
        UserLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        UserShopLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        UserToDoLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        UserFavLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        
        delegate?.sortandrefreshlists()
        
       // self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBOutlet var backview: UIView!
    
    func handlebvTap(sender: UITapGestureRecognizer? = nil) {
        
        close()
      // self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }

    
    @IBAction func unwindToSort(sender: UIStoryboardSegue){
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       backview.backgroundColor = UIColorFromRGB(0x2A2F36, alp: 0.3)
        
        let viewtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        viewtap.delegate = self
        backview.userInteractionEnabled = true
        backview.addGestureRecognizer(viewtap)
        
       // tableView.layer.cornerRadius = 8
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showstatistics" {
            
            let navVC = segue.destinationViewController as! UINavigationController
            
            let  toViewController = navVC.viewControllers.first as! GraphsVC
            
            
            toViewController.senderVC = "Other"
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
