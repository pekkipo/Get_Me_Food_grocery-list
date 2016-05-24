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
    
    var tablelabels = [NSLocalizedString("popcheck", comment: ""),
        NSLocalizedString("popasc", comment: ""),
        NSLocalizedString("popdesc", comment: ""),
        NSLocalizedString("popalpha", comment: ""),
        NSLocalizedString("close", comment: ""),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
       
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // var customcell: CategoryCell!
        var cell: sortpopupcell!
        
      
            //if search is active
            cell = tableView.dequeueReusableCellWithIdentifier("popupcell", forIndexPath: indexPath) as! sortpopupcell
        
        if indexPath.row == 4 {
         //   cell.backgroundColor = UIColorFromRGB(0xF23D55, alp: 1.0)
            cell.caption.textColor = UIColorFromRGB(0xF23D55, alp: 1.0)
        } else {
         //   cell.backgroundColor = UIColorFromRGB(0xFAFAFA, alp: 1.0)
            cell.caption.textColor = UIColorFromRGB(0x31797D, alp: 1.0)
        }
            
        cell.caption.text = tablelabels[indexPath.row]
            
            
            return cell
      
        
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      return tablelabels.count
    }
    
    ///
    
    func close() {
        
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
        
       self.dismissViewControllerAnimated(true, completion: nil)
        
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
