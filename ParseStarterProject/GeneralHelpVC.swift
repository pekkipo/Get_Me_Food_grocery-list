//
//  GeneralHelpVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 08/02/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class GeneralHelpVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    
    
    @IBOutlet var tableView: UITableView!
    
    
    var graphichelp : [String] =
    [
        NSLocalizedString("graphichelp", comment: "")
        
    ]

    
    var itemshelpitems : [String] =
    [
        NSLocalizedString("howcreateshopitem", comment: ""),
        NSLocalizedString("howedititem", comment: ""),
        NSLocalizedString("howcreatetodoitem", comment: ""),
        NSLocalizedString("howedittodoitem", comment: ""),
        NSLocalizedString("howquicklyadd", comment: ""),
        NSLocalizedString("howaddmultiple", comment: ""),
        NSLocalizedString("howaddtofavs", comment: ""),
        NSLocalizedString("howreorder", comment: ""),
        NSLocalizedString("howchangeunits", comment: ""),
        NSLocalizedString("howaddpictures", comment: ""),
        NSLocalizedString("howdeleteitems", comment: ""),
        NSLocalizedString("howcopy", comment: "")
    ]
    
    var apphelpitems : [String] =
    [
        NSLocalizedString("howcreatecats", comment: ""),
        NSLocalizedString("howaddcontact", comment: ""),
        NSLocalizedString("howsendlists", comment: ""),
        NSLocalizedString("howsendbyemail", comment: ""),
        NSLocalizedString("howrenameandnote", comment: ""),
        NSLocalizedString("howturnoncats", comment: ""),
        NSLocalizedString("howchangecurrency", comment: ""),
        NSLocalizedString("howsynchronize", comment: ""),
        NSLocalizedString("howchangeaccountdata", comment: "")
        
    ]
    
    

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            
            
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                
                helptext = "howcreateshopitemT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 1 {
                
                helptext = "howedititemT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 2 {
                
                helptext = "howcreatetodoitemT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 3 {
                
                helptext = "howedittodoitemT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 4 {
                
                helptext =  "howquicklyaddT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 5 {
                
                helptext = "howaddmultipleT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 6 {
                
                helptext = "howaddtofavsT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 7 {
                
                helptext = "howreorderT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 8 {
                
                helptext = "howchangeunitsT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 9 {
                
                helptext = "howaddpicturesT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 10 {
                
                helptext = "howdeleteitemsT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 11 {
                
                helptext =  "howcopyT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            }
            
            
        } else if indexPath.section == 2 {
            
            
            if indexPath.row == 0 {
                
                helptext = "howcreatecatsT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 1 {
                
                helptext = "howaddcontactT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 2 {
                
                helptext = "howsendlistsT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 3 {
                
                helptext = "howsendbyemailT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 4 {
                
                helptext = "howrenameandnoteT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 5 {
                
                helptext = "howturnoncatsT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 6 {
                
                helptext = "howchangecurrencyT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 7 {
                
                helptext = "howsynchronizeT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 8 {
                
                helptext = "howchangeaccountdataT"
                
                performSegueWithIdentifier("expand", sender: self)
                
            }
            
        }

        
        
        /*
        if indexPath.section == 0 {
            
            
            
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                
                helptext = NSLocalizedString("howcreateshopitemT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 1 {
                
                helptext = NSLocalizedString("howedititemT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 2 {
                
                helptext = NSLocalizedString("howcreatetodoitemT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 3 {
                
                helptext = NSLocalizedString("howedittodoitemT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 4 {
                
                helptext =  NSLocalizedString("howquicklyaddT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 5 {
                
                helptext = NSLocalizedString("howaddmultipleT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 6 {
                
                helptext = NSLocalizedString("howaddtofavsT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 7 {
                
                helptext = NSLocalizedString("howreorderT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 8 {
                
                helptext = NSLocalizedString("howchangeunitsT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 9 {
                
                helptext = NSLocalizedString("howaddpicturesT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 10 {
                
                helptext = NSLocalizedString("howdeleteitemsT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 11 {
                
                helptext =  NSLocalizedString("howcopyT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            }
            
            
        } else if indexPath.section == 2 {
            
            
            if indexPath.row == 0 {
                
                helptext = NSLocalizedString("howcreatecatsT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 1 {
                
                helptext = NSLocalizedString("howaddcontactT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 2 {
                
                helptext = NSLocalizedString("howsendlistsT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 3 {
                
                helptext = NSLocalizedString("howsendbyemailT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 4 {
                
                helptext =  NSLocalizedString("howrenameandnoteT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 5 {
                
                helptext = NSLocalizedString("howturnoncatsT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 6 {
                
                helptext = NSLocalizedString("howchangecurrencyT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 7 {
                
                helptext = NSLocalizedString("synchronizeT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            } else if indexPath.row == 8 {
                
                helptext = NSLocalizedString("howchangeaccountdataT", comment: "")
                
                performSegueWithIdentifier("expand", sender: self)
                
            }
            
        }
*/
        
        
        //let row = indexPath.row
        
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 3
            
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return graphichelp.count
        } else if section == 1 {
            return itemshelpitems.count
        } else if section == 2 {
            return apphelpitems.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var graphiccell: genhelpcell!
        var itemhelpcell: genhelpcell!
        var apphelpcell: genhelpcell!
        
        if indexPath.section == 0 {
            
            graphiccell = tableView.dequeueReusableCellWithIdentifier("graphichelp", forIndexPath: indexPath) as! genhelpcell
            
            graphiccell.caption.text = graphichelp[indexPath.row]

            
        } else if indexPath.section == 1 {
            
            itemhelpcell = tableView.dequeueReusableCellWithIdentifier("itemshelp", forIndexPath: indexPath) as! genhelpcell
            
            itemhelpcell.caption.text = itemshelpitems[indexPath.row]
            
            
        } else if indexPath.section == 2 {
            
            apphelpcell = tableView.dequeueReusableCellWithIdentifier("apphelp", forIndexPath: indexPath) as! genhelpcell
            
            apphelpcell.caption.text = apphelpitems[indexPath.row]
            
            
        }
        
          if (indexPath.section == 0) {
            return graphiccell
          } else  if (indexPath.section == 1) {
             return itemhelpcell
        } else if (indexPath.section == 2) {
             return apphelpcell
        } else {
            return apphelpcell
        }
      
        
        
    }


    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
    
        if section == 0 {
        return NSLocalizedString("aboutgraphic", comment: "")
        } else if section == 1 {
            return NSLocalizedString("aboutitems", comment: "")
        } else if section == 2 {
            return NSLocalizedString("aboutapp", comment: "")
        } else {
            return ""
        }
    }
    
    
    var helptext : String = ""
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "expand" {
            
             //var destVC = segue.destinationViewController as! ExpandHelp
            
            var newVC = segue.destinationViewController as! HelpNew
            
        
            
            newVC.thistext = helptext
        
            
        }
    }
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    @IBOutlet var menuitem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuitem.target = self.revealViewController()
        menuitem.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

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
