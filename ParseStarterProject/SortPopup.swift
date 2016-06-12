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
    
    var tablelabels1 = [
        NSLocalizedString("popasc", comment: ""),
        NSLocalizedString("popdesc", comment: ""),
        NSLocalizedString("popalpha", comment: ""),
        ]
    
    var tablelabels2 = [
    NSLocalizedString("popcheck", comment: ""),
    NSLocalizedString("calculatesumlists", comment: ""),
    NSLocalizedString("statistics", comment: ""),
    ]
    
    var tablelabels3 = [
        NSLocalizedString("close", comment: ""),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
       
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // var customcell: CategoryCell!
        var cell: sortpopupcell!
        
      
            //if search is active
            cell = tableView.dequeueReusableCellWithIdentifier("popupcell", forIndexPath: indexPath) as! sortpopupcell
        

            cell.caption.textColor = UIColorFromRGB(0x31797D, alp: 1.0)

        
        if indexPath.section == 2 {
            cell.caption.textColor = UIColorFromRGB(0xF23D55, alp: 1.0)
        }
        
        if indexPath.section == 0 {
            cell.caption.text = tablelabels1[indexPath.row]
        } else if indexPath.section == 1 {
            cell.caption.text = tablelabels2[indexPath.row]
        } else if indexPath.section == 2 {
            cell.caption.text = tablelabels3[indexPath.row]
        }
        
        //cell.caption.text = tablelabels[indexPath.row]
            
            
            return cell
      
        
        
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
                sortbydateasc()
            } else if indexPath.row == 1 {
                sortbydate()
            } else if indexPath.row == 2 {
                sortalphabetically()
            }
            
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                delegate?.refreshlists()
            } else if indexPath.row == 1 {
                print("Sums")
            } else if indexPath.row == 2 {
                print("Statistics")
            }
            
        } else if indexPath.section == 2 {
            close()
        }
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return NSLocalizedString("sortoptions", comment: "")
        } else if section == 1 {
            return NSLocalizedString("listsoptions", comment: "")
        } else {
        return ""
        }
            }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      //return tablelabels.count
        if section == 0 || section == 1 {
        return 3
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
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func sortbydateasc() {
        
        UserLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending })
        UserShopLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending  })
        UserToDoLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending  })
        UserFavLists.sortInPlace({ $0.listcreationdate.compare($1.listcreationdate) == NSComparisonResult.OrderedAscending  })
        
        delegate?.sortandrefreshlists()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func sortalphabetically() {
        
        UserLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        UserShopLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        UserToDoLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        UserFavLists.sortInPlace({ $0.listname.compare($1.listname) == NSComparisonResult.OrderedAscending })
        
        delegate?.sortandrefreshlists()
        
        self.dismissViewControllerAnimated(true, completion: nil)

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


    override func viewDidLoad() {
        super.viewDidLoad()
        
       backview.backgroundColor = UIColorFromRGB(0x2A2F36, alp: 0.3)
        
        let viewtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        viewtap.delegate = self
        backview.userInteractionEnabled = true
        backview.addGestureRecognizer(viewtap)
        
        tableView.layer.cornerRadius = 8
        
        
        
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

}
