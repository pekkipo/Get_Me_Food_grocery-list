//
//  ContactsPopup.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 07/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

protocol ContactsPopupDelegate
{
    func choosecontact(chosenuser:Contact)
}

class ContactsPopup: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    var delegate : ContactsPopupDelegate?
    
    @IBOutlet var tableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var nocontactsview: UIView!
    
    @IBOutlet var noclabel: UILabel!
    
    @IBOutlet var addclabel: UILabel!
    
    
    @IBOutlet var setlabel: UILabel!
    
     override func viewWillAppear(animated: Bool) {
        
        if usercontacts.count == 0 {
            nocontactsview.hidden = false
        } else {
            nocontactsview.hidden = true
        }
        
    }
    
    ///table
    
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let ItemCellIdentifier = "contactscell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ContPopupCell
        
        cell.contlabel.text = usercontacts[indexPath.row].contactname
        cell.contemail.text = usercontacts[indexPath.row].contactemail
        cell.contimage.image = usercontacts[indexPath.row].contactimage
        
       
       return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegate?.choosecontact(usercontacts[indexPath.row])
            self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        
     
            return 64
  
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
    
            return usercontacts.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
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
