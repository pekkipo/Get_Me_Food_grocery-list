//
//  ReportPopup.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 16/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import MessageUI

//var blacklistarray = [AnyObject]()
var blacklistarray = [String]()

class ReportPopup: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    var userid = String()
    var useremail = String()
    
    func UIColorFromRGB(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }
    
    let progressHUD = ProgressHUD(text: "Wait, please")
    
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
        alertview.addAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addAction(cancelCallback)
    }
    
    func cancelCallback() {
        print("CANCELED")
    }
    
    func closeCallback() {
        

        
    }

    
    
    @IBOutlet var blockoutlet: UIButton!
    
    @IBOutlet var reportoutlet: UIButton!
    
    
    @IBOutlet var closeoutlet: UIButton!
    
   // var blacklistarray = [AnyObject]()
    
    @IBAction func blockuser(sender: AnyObject) {
        
        if CheckConnection.isConnectedToNetwork() {
            
            self.pause()
            
            /*
            var querycontacts:PFQuery = PFUser.query()!
            querycontacts.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
            querycontacts.fromLocalDatastore()
            querycontacts.limit = 1
            var thisusercontacts = querycontacts.findObjects()
            if (thisusercontacts != nil) {
                for thisusercontact in thisusercontacts! {
                    
                    if let blacklist = thisusercontact["blacklist"] as? [AnyObject] { //used to be username
                        
                        print(thisusercontact["blacklist"])
                        
                        blacklistarray.appendContentsOf(thisusercontact["blacklist"] as! [AnyObject])
                        
                    }
                    
                    
                }
            } else {
                print("Error")
            }        ///
            */
            
            let contactquery:PFQuery = PFUser.query()!
            contactquery.fromLocalDatastore()
            contactquery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
            contactquery.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    //usercontacts.removeAll(keepCapacity: true)
                    
                    if let users = objects as? [PFObject] {
                        
                        
                        for object in users {
                            // println(object.objectId)
                            
                           
                          
                                
                                print(blacklistarray)
                                
                                blacklistarray.append(self.userid)
                                
                                 print(blacklistarray)
                                
                                object["blacklist"] = blacklistarray
                                
                                object.pinInBackground()
                                object.save()
                                self.restore()

                            
                      
                        }
                        
                        
                        
                    } else {
                        // Log details of the failure
                        self.restore()
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                } else {
                    
                    self.restore()
                    print("Error: \(error!) \(error!.userInfo)")
                }
                
                //self.tableView.reloadData()
            
            
            self.restore()
            
            
            }

        } else {
            self.restore()
            self.displayFailAlert(NSLocalizedString("Oops", comment: "Oops"), message: NSLocalizedString("NoConnection", comment: "NoConnection"))
        }
        
    }
    
    
    ////// EMAIL STUFF
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: NSLocalizedString("CantSend", comment: "NoConnection"), message: NSLocalizedString("NoEmailInfo", comment: ""), delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendemail() { //BIGSENDER
        
        
       

        
        let receivermail : String = "pekkipodev@gmail.com"
        

            
            if( MFMailComposeViewController.canSendMail() ) {
                print("Can send email.")
                
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                
                //Set the subject and message of the email
                mailComposer.setToRecipients([receivermail])
                mailComposer.setSubject("\(NSLocalizedString("reportEmail", comment: "")) \(self.userid)")
                
                
                var body: String = "<html><body><h1>Report</h1>" //<br/>"
               
                var usertext = NSLocalizedString("userDistText", comment: "")
                var addnote = NSLocalizedString("addNotes", comment: "")
                
                body = body + "<div><p>\(usertext)</p></div><div><p>\(addnote)</p></div>"
                
                
                body = body + "</body></html>"
                mailComposer.setMessageBody(body, isHTML: true)
                
                
                
                
                self.presentViewController(mailComposer, animated: true, completion: nil)
                
            } else {
                self.showSendMailErrorAlert()
            }
            
           }

    
    @IBAction func reportuser(sender: AnyObject) {
        
        sendemail()
    }
    
    
    
    @IBAction func closeview(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.back
        
        self.view.backgroundColor = UIColorFromRGB(0x2A2F36, alp: 0.5)
        
        blockoutlet.backgroundColor = UIColorFromRGB(0xFFFFFF, alp: 0.9)
        blockoutlet.layer.borderWidth = 1
        blockoutlet.layer.borderColor = UIColorFromRGB(0xF23D55, alp: 1).CGColor
        
        reportoutlet.backgroundColor = UIColorFromRGB(0xFFFFFF, alp: 0.9)
        reportoutlet.layer.borderWidth = 1
        reportoutlet.layer.borderColor = UIColorFromRGB(0x2A2F36, alp: 1).CGColor
        
        closeoutlet.backgroundColor = UIColorFromRGB(0xFFFFFF, alp: 0.9)
        closeoutlet.layer.borderWidth = 1
        closeoutlet.layer.borderColor = UIColorFromRGB(0x31797D, alp: 1).CGColor

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
