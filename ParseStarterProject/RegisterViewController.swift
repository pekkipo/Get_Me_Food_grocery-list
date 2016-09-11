//
//  RegisterViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 14/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse




class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    var maindelegate : refreshmainviewDelegate?
    
    
    @IBOutlet weak var username: CustomTextField!//UITextField!
    
    @IBOutlet weak var userpassword: CustomTextField!//UITextField!
    
    
    @IBOutlet weak var useremail: CustomTextField!//UITextField!
    
    
    @IBOutlet weak var useravatar: UIImageView!
    
    
    var chosenPicture = UIImage()
    
    @IBAction func addimage(sender: AnyObject) {
        
        let chosenimage = UIImagePickerController()
        chosenimage.delegate = self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = true
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
    }
    
    var errorMessage = NSLocalizedString("trylater", comment: "")

    /*
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
*/
    /*
    func displaySuccessAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            
            println(self.maindelegate)
            
            self.maindelegate?.loaduserdata()
            
            self.maindelegate?.refreshmainview()
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
             self.performSegueWithIdentifier("loginafterreg", sender: self)

            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
*/

    
    let progressHUD = ProgressHUD(text: NSLocalizedString("wait", comment: ""))
    
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
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addAction(closeCallback)
        alertview.addCancelAction(cancelCallback)
    }
    
    func displayErrorAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "BACK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addAction(closeCallback)
        alertview.addCancelAction(cancelCallback)
    }

    
    func closeCallback() {
        
        print("OK")
        
    }
    
    func cancelCallback() {
        
        print("canceled")
        
    }

    func UIColorFromRGB(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//(1.0)
        )
    }
    
    //IMAGE PART
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        
        
        useravatar.image = chosenimage
        
        //chosenPicture = chosenimage
        
        
    }
    
    
    func loginafterregistration(loginname:String, pass: String, newuser:PFUser) {
        
        // PFUser.logOut() //new stuff
        
        PFUser.logInWithUsernameInBackground(loginname, password: pass, block: { (newuser, error) -> Void in
            
           // self.activityIndicator.stopAnimating()
            //UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            self.pause()
            
            if newuser != nil {
                
                // Logged In!
                 loggedIn = true
                //self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                
               //  print(self.maindelegate)
                
                
                var installation: PFInstallation = PFInstallation.currentInstallation()
                installation.addUniqueObject("ReloadNew", forKey: "channels")
                installation["user"] = PFUser.currentUser()
                installation.saveInBackground()
                
                
              
                
                let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                
                let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                
                //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                
                
                mainmenu.loaduserdata()
                
                mainmenu.refreshafterlogin()
                
             
                
                
                //self.displayAlert("Success!", message: "You've logged in!")
                
                self.restore()
                
               self.performSegueWithIdentifier("RegisteredSegue", sender: self)
               
                
                
            } else {
                
                if let errorString = error!.userInfo["error"] as? String {
                    
                   self.errorMessage = errorString
                    
                }
                
                self.displayFailAlert(NSLocalizedString("failedlogin", comment: ""), message: "\(NSLocalizedString("oneerror", comment: "")) \(self.errorMessage)")
                
            }
            
        })
    
    }
    
    
    
    @IBOutlet var registeroutlet: UIButton!
    
    
    @IBOutlet var pictureoutlet: UIButton!
    
    var scaledavatar = UIImage()
    
    func imageResize (imageObj:UIImage)-> UIImage{
        
        // Automatically use scale factor of main screen
        
        let avsize = CGSizeMake(100, 100)
        UIGraphicsBeginImageContextWithOptions(avsize, false, 1.0) // was false
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: avsize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        scaledavatar = scaledImage
        return scaledavatar
    }
    
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
                return ""
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    

    
    @IBAction func registerbutton(sender: AnyObject) {
        
        PFUser.logOut()
        
        PFFacebookUtils.facebookLoginManager().logOut() // not sure, but it must work
        
        GIDSignIn.sharedInstance().signOut()
        
        
        
        /// un assign device for pushes
        
        PFInstallation.currentInstallation().removeObjectForKey("user") //addUniqueObject("Reload", forKey: "channels")
        PFInstallation.currentInstallation()["channels"] = [""]
        PFInstallation.currentInstallation().saveInBackground()
        
        PFInstallation.currentInstallation().removeObjectForKey("user")
        
        if username.text == "" || userpassword.text == "" {
            
            self.displayErrorAlert(NSLocalizedString("errorinform", comment: ""), message: NSLocalizedString("enternameandpass", comment: ""))
            
        } else {
            /*
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            */
            //errorMessage = "Please try again later"
            self.pause()
            
       
            
            imageResize(self.useravatar.image!)
            let imageData = UIImagePNGRepresentation(scaledavatar)
            //let imageData = UIImagePNGRepresentation(chosenPicture)
            
            saveImageLocally(imageData)
           
            //imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
            
            
            let imageFile = PFFile(name:"user_avatar.png", data:imageData!)

            
            //signing up with parse
            var user = PFUser()
            user.username = useremail.text
            user.password = userpassword.text
            user.email = useremail.text
            user["name"] = username.text
            user["Avatar"] = imageFile
            user["avatarimagepath"] = imagePath
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                
               // self.activityIndicator.stopAnimating()
                //UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.restore()
                
                if error == nil {
                    
                    // Signup successful
                    
                   // self.performSegueWithIdentifier("login", sender: self)
                    
                    //loggedIn = true
                    // NEED TO LOGIN ALSO IMMEDIATELY
                    self.loginafterregistration(self.useremail.text!, pass: self.userpassword.text!, newuser: user)
                    
                    
                    
                    
                } else {
                    self.restore()
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        self.errorMessage = errorString
                        
                    }
                    
                    self.displayFailAlert(NSLocalizedString("failedsignup", comment: ""), message: "\(NSLocalizedString("oneerror", comment: "")) \(self.errorMessage)")
                    
                }
                
            })

        }
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "loginafterreg" {
            
            let menuVC = segue.destinationViewController as! MainMenuViewController
            
          //  let contactsVC = contactsNav.viewControllers.first as! ShareFromContactsViewController
            
            
            menuVC.listtoshare = self.listToShare!
            
            
        }
        
        
    }
  */
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        useravatar.tintColor = UIColor.whiteColor()
        
        username.delegate = self
        useremail.delegate = self
        userpassword.delegate = self
        
        
        
         username.layer.borderWidth = 1
         useremail.layer.borderWidth = 1
         userpassword.layer.borderWidth = 1
        username.layer.borderColor = UIColorFromRGB(0xE0E0E0, alp: 1.0).CGColor
        useremail.layer.borderColor = UIColorFromRGB(0xE0E0E0, alp: 1.0).CGColor
        userpassword.layer.borderColor = UIColorFromRGB(0xE0E0E0, alp: 1.0).CGColor
        
        useravatar.layer.cornerRadius = useravatar.frame.size.width/2
        useravatar.layer.masksToBounds = true
       
        
      
        username.leftTextMargin = 17 // was 17
        userpassword.leftTextMargin = 17
        useremail.leftTextMargin = 17
        
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
