//
//  LoginViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 14/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse



//var loggedIn: Bool = Bool()
/*
extension ViewController: VKSdkDelegate {
    func vkSdkNeedCaptchaEnter(captchaError: VKError) { }
    func vkSdkTokenHasExpired(expiredToken: VKAccessToken) { }
    func vkSdkUserDeniedAccess(authorizationError: VKError) { }
    func vkSdkShouldPresentViewController(controller: UIViewController) { }
    func vkSdkReceivedNewToken(newToken: VKAccessToken) { }
}
*/

class LoginViewController: UIViewController, GIDSignInUIDelegate, VKSdkDelegate, VKSdkUIDelegate, UITextFieldDelegate {

    //var loggedIn = false
   
   // var currentView : LoginViewController?
    
    //var VC : UIViewController!
    
    var maindelegate : refreshmainviewDelegate?
    
    
    @IBOutlet weak var LoginField: CustomTextField!//UITextField!
    
    @IBOutlet weak var PassField: CustomTextField!//UITextField!
    
    var errorMessage = NSLocalizedString("trylater", comment: "")
    
    
    @IBOutlet var registerview: UIView!
    
    
    @IBOutlet var facebookview: UIView!
    
    @IBOutlet var loginbuttonview: UIView!

    @IBOutlet var dimmerview: UIView!
    

    let progressHUD = ProgressHUD(text: NSLocalizedString("loggingin", comment: ""))
    
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
    
    func displayInfoAlert(title: String, message: String) {
        
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(cancelCallback)
        
        
        
    }
    
    func closeCallback() {
        
     print("OK")
        
    }
    
    func cancelCallback() {
        
        print("canceled")
        
    }
    
    
    ////////// FORGOT PASSWORD SECTION
    
    @IBOutlet var forgotblock: UIView!
    
    
    @IBAction func showforgotblock(sender: AnyObject) {
        
        dimmerview.hidden = false
        forgotblock.hidden = false
        
    }
    
    
    
    @IBOutlet var closeforgotpass: UIButton!
    
    @IBAction func closeforgot(sender: AnyObject) {
        
        dimmerview.hidden = true
        forgotblock.hidden = true
        
    }
    
    
    @IBOutlet var sendpassfield: CustomTextField!//UITextField!
    
    
    @IBAction func sendpass(sender: AnyObject) {
        
        if sendpassfield.text!.isEmpty || !((sendpassfield.text! as NSString).containsString("@")) || !((sendpassfield.text! as NSString).containsString(".")) {
            
            PFUser.requestPasswordResetForEmailInBackground(sendpassfield.text!)
        } else {
            displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("validemail", comment: ""))
        }
    }
    //////////

    
    
    /////// GOOGLE STUFF
    
    @IBOutlet var googlesignin: GIDSignInButton!
    
    @IBOutlet var mygoogle: UIButton!
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
       // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func RegisterButton(sender: AnyObject) {
        
       
    }
    
    @IBOutlet var registeroutlet: UIButton!
    
    
    @IBAction func backBar(sender: AnyObject) {
        
        self.performSegueWithIdentifier("LoggedInSegue", sender: self)
    // not necessarily logged in, just a name of an exit segue
    }
    
    
    @IBAction func LoginButton(sender: AnyObject) {
        
        PFUser.logOut()
        
        PFUser.logInWithUsernameInBackground(LoginField.text!, password: PassField.text!, block: { (user, error) -> Void in
            
           // self.activityIndicator.stopAnimating()
            //UIApplication.sharedApplication().endIgnoringInteractionEvents()
            self.pause()
            
            if user != nil {
                
                // Logged In!
                
                var installation: PFInstallation = PFInstallation.currentInstallation()
                installation.addUniqueObject("ReloadNew", forKey: "channels")
                installation["user"] = PFUser.currentUser()
                installation.saveInBackground()
                
                 self.maindelegate?.loaduserdata()
                
                
                
                self.maindelegate?.refreshmainview()
                
                self.restore()
                
              self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                loggedIn = true
                
                
            } else {
                
                 self.restore()
                if let errorString = error!.userInfo["error"] as? String {
                    
                    self.errorMessage = errorString
                    
                }
                
                self.displayFailAlert(NSLocalizedString("failedlogin", comment: ""), message: self.errorMessage)
                
            }
            
        })
    }
    
    var fbusername = String()
    var fbuseremail = String()
    var fbuserid = String()
    var fbuserimage = UIImage()
    var userdetails = [AnyObject]()
    
    
    func returnUserProfileImage(accessToken: NSString) -> UIImage
    {
        let userID = accessToken as NSString
        let facebookProfileUrl = NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
        
        if let data = NSData(contentsOfURL: facebookProfileUrl!) {
            fbuserimage = UIImage(data: data)!
        }
        return fbuserimage
    }
    
    func loadFacebookData() -> [AnyObject] {
        
        
        
        // Create request for user's Facebook data
        let request = FBSDKGraphRequest(graphPath:"me", parameters:["fields": "email, name, id"])
        
        // Send request to Facebook
        request.startWithCompletionHandler {
            
            (connection, result, error) in
            
            if error != nil {
                // Some error checking here
            }
            else if let userData: AnyObject = result {//as? [String:AnyObject] {
                
                // Access user data
                 self.fbusername = userData.valueForKey("name") as! String//userData["name"] as? String
                 self.fbuseremail = userData.valueForKey("email") as! String //userData["email"] as? String
                 self.fbuserid = userData.valueForKey("id") as! String
                //let pictureURL: NSURL = NSURL(string: "https://graph.facebook.com/\(fbuserid)/picture?type=large&return_ssl_resources=1")!
                // ....
                self.returnUserProfileImage(self.fbuserid)
                
                self.userdetails = [self.fbusername,self.fbuseremail,self.fbuserimage]
                
                print(self.userdetails)
          
            }
        }
        
        return self.userdetails
        
    }
    
    
    var twittername = String()
    var twitterid = String()
    var twitterimage = UIImage()
    var twitteremail = String()
    var twitteruserdetails = [AnyObject]()
    
    
    /*
    func loadTwitterData() -> [AnyObject]{
        
        if PFTwitterUtils.isLinkedWithUser(PFUser.currentUser()!) {
            
            let screenName = PFTwitterUtils.twitter()?.screenName!
            
            let requestString = ("https://api.twitter.com/1.1/users/show.json?screen_name=" + screenName!)
            
            let verify: NSURL = NSURL(string: requestString)!
            
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: verify)
            
            PFTwitterUtils.twitter()?.signRequest(request)
            
            var response: NSURLResponse?
            var error: NSError?
            
            let data: NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)!
            
            if error == nil {
                
                let result : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
                
                
                let names: String! = result?.objectForKey("name") as! String
                
                let separatedNames: [String] = names.componentsSeparatedByString(" ")
                
                var firstName = String()
                var lastName = String()
                
                firstName = separatedNames.first!
                lastName = separatedNames.last!
                
                twittername = "\(firstName) \(lastName)"
                
                
                let urlString = result?.objectForKey("profile_image_url_https") as! String
                
                let hiResUrlString = urlString.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                
                let twitterPhotoUrl = NSURL(string: hiResUrlString)
                let imageData = NSData(contentsOfURL: twitterPhotoUrl!)
                let twitterImage: UIImage! = UIImage(data:imageData!)
                
                twitterimage = twitterImage
                twitteremail = "default@default.com"
                
                twitteruserdetails = [twittername,twitteremail,twitterimage]
            }
            
        }
    
        return twitteruserdetails
    }
    */

    
    
    /*
    @IBAction func TwitterLoginButton(sender: AnyObject) {
        
       //  self.pause()
        
        PFTwitterUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            
            self.restore()
            
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in with Twitter!")
                    self.loadTwitterData()
                    
                    
                    var query:PFQuery = PFUser.query()!
                    query.whereKey("objectId", equalTo: user.objectId!)
                    query.limit = 1
                    query.getFirstObjectInBackgroundWithBlock() {
                        
                        (user: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                            self.restore()
                            self.displayFailAlert("Oops!", message: "Something went wrong, please try again later.")
                        } else if let user = user {
                            
                            user["username"] = self.twitteruserdetails[1]
                            user["email"] = self.twitteruserdetails[1]
                            user["name"] = self.twitteruserdetails[0]
                            var file = PFFile(data: UIImageJPEGRepresentation(self.twitteruserdetails[2] as! UIImage, 0.7))
                            user["Avatar"] = file
                            
                            user.saveInBackgroundWithBlock({ (success, error) -> Void in
                                if success {
                                    
                                    
                                    
                                    self.maindelegate?.loaduserdata()
                                    
                                    self.maindelegate?.refreshmainview()
                                    
                                    self.restore()
                                    
                                   // self.displayTwitterInfoAlert("Edit email address", message: "Twitter forbids loading your email. Please, set email address in account settings in order to be able to receive lists")
                                    
                                    self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                                    loggedIn = true
                                    
                                } else {
                                    self.restore()
                                    self.displayFailAlert("Error!", message: "Error occured: \(error)")
                                    print("error")
                                }
                                
                            })
                            
                        }
                    }
                    
                } else {
                    print("User logged in with Twitter!")
                    
                    
                    self.maindelegate?.loaduserdata()
                    
                    self.maindelegate?.refreshmainview()
                    
                    self.restore()
                    self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                    loggedIn = true
                }
            } else {
                 self.restore()
                print("Uh oh. The user cancelled the Twitter login.")
            }
        }
        
    }
    */
    
   
    func customfacebooklogin() {
        
        self.pause()
        
        var permissions = ["email", "public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {

                    
                    // Create request for user's Facebook data
                    let request = FBSDKGraphRequest(graphPath:"me", parameters:["fields": "email, name, id"])
                    
                    // Send request to Facebook
                    request.startWithCompletionHandler {
                        
                        (connection, result, error) in
                        
                        if error != nil {
                            // Some error checking here
                            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        }
                        else if let userData: AnyObject = result {//as? [String:AnyObject] {
                            
                            // Access user data
                            self.fbusername = userData.valueForKey("name") as! String//userData["name"] as? String
                            self.fbuseremail = userData.valueForKey("email") as! String //userData["email"] as? String
                            self.fbuserid = userData.valueForKey("id") as! String

                            
                            let userID = self.fbuserid as NSString//accessToken as NSString
                            let facebookProfileUrl = NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
                            
                            if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                                self.fbuserimage = UIImage(data: data)!
                            } else {
                                self.fbuserimage = defaultcatimages[1].itemimage
                            }
                            
                            
                            self.userdetails = [self.fbusername,self.fbuseremail,self.fbuserimage]
                            
                            print(self.userdetails)
                            
                            var pass = "fbuser12345"
                            
                            
                            //////////
                            
                            var query:PFQuery = PFUser.query()!
                            query.whereKey("fbid", equalTo: userID)

                            query.getFirstObjectInBackgroundWithBlock {
                                (object: PFObject?, error: NSError?) -> Void in
                                if error != nil && object == nil {
                                    
                                    var file = PFFile(data: UIImageJPEGRepresentation(self.fbuserimage, 0.7)!)
                                    
                                   

                                    
                                                var pfUser = PFUser()
                                                pfUser.username = self.fbuseremail
                                                pfUser.email = self.fbuseremail
                                                pfUser["name"] = self.fbusername
                                                pfUser["Avatar"] = file
                                                pfUser.password = pass
                                                pfUser["fbid"] = userID
                                                
                                                
                                                pfUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
                                                    
                                                    
                                                    if error == nil {
                                                        
                                                        
                                                        // NEED TO LOGIN ALSO IMMEDIATELY
                                                        PFUser.logInWithUsernameInBackground(self.fbuseremail, password: pass, block: { (newuser, error) -> Void in
                                                            
                                                            
                                                            if newuser != nil {
                                                                
                                                                // Logged In!
                                                                loggedIn = true
                                                                
                                                                var installation: PFInstallation = PFInstallation.currentInstallation()
                                                                // installation.addUniqueObject("ReloadNew", forKey: "channels")
                                                                installation["user"] = PFUser.currentUser()
                                                                installation.saveInBackground()
                                                                
                                                                let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                                                
                                                                let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                                                                
                                                                //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                                                                
                                                                
                                                                mainmenu.loaduserdata()
                                                                
                                                                mainmenu.refreshafterlogin()
                                                                
                                                                self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                                                                
                                                            } else {
                                                                
                                                                if let errorString = error!.userInfo["error"] as? String {
                                                                    
                                                                    print(errorString)
                                                                    
                                                                }
                                                                
                                                                print("failedlogin")
                                                                
                                                            }
                                                            
                                                        })
                                                        
                                                        
                                                        
                                                        
                                                    } else {
                                                        
                                                        if let errorString = error!.userInfo["error"] as? String {
                                                            self.restore()
                                                            print(errorString)
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                })
                                                
                                                
                                    
                                    
                                    
                                    
                                } else if error == nil && object != nil {
                                    // The find succeeded.
                                    print("Successfully retrieved the object.")
                                    // sign up for parse
                                    
                                    PFUser.logInWithUsernameInBackground(self.fbuseremail, password: pass, block: { (newuser, error) -> Void in
                                        
                                        
                                        if newuser != nil {
                                            
                                            loggedIn = true
 
                                            var installation: PFInstallation = PFInstallation.currentInstallation()
                                            installation["user"] = PFUser.currentUser()
                                            installation.saveInBackground()
                                            
                                            let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                            
                                            let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                                            
                                            //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                                            
                                            
                                            mainmenu.loaduserdata()
                                            
                                            mainmenu.refreshafterlogin()
                                            
                                            
                                            
                                            self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                                            
                                        } else {
                                            
                                            if let errorString = error!.userInfo["error"] as? String {
                                                self.restore()
                                                print(errorString)
                                                
                                            }
                                            self.restore()
                                            print("failedlogin")
                                            
                                        }
                                        
                                    })
                                    ///
                                    
                                    
                                    
                                } else {
                                    self.restore()
                                    print("error! \(error)")
                                }
                                
                                
                            }
                            
                            /////////
                       
                            
                            
                        }
                    }
                    

                
                
            } else {
                self.restore()
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
        

        
        
    }
    
// THIS IS REAL BUTTON
    @IBAction func FacebookLoginButton(sender: AnyObject) {
        
        //customfacebooklogin()
        
        
        
        self.pause()
        
        var permissions = ["email", "public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                
                
               /*
                if PFAnonymousUtils.isLinkedWithUser(PFUser.currentUser()) {
                    PFUser.logOut()
                }
*/
                
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                    
                    // self.loadFacebookData()
                    
                    // Create request for user's Facebook data
                    let request = FBSDKGraphRequest(graphPath:"me", parameters:["fields": "email, name, id"])
                    
                    // Send request to Facebook
                    request.startWithCompletionHandler {
                        
                        (connection, result, error) in
                        
                        if error != nil {
                            // Some error checking here
                            self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                        }
                        else if let userData: AnyObject = result {//as? [String:AnyObject] {
                            
                            // Access user data
                            self.fbusername = userData.valueForKey("name") as! String//userData["name"] as? String
                            self.fbuseremail = userData.valueForKey("email") as! String //userData["email"] as? String
                            self.fbuserid = userData.valueForKey("id") as! String
                            //let pictureURL: NSURL = NSURL(string: "https://graph.facebook.com/\(fbuserid)/picture?type=large&return_ssl_resources=1")!
                            // ....
                           // self.returnUserProfileImage(self.fbuserid)
                            
                            let userID = self.fbuserid as NSString//accessToken as NSString
                            let facebookProfileUrl = NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
                            
                            if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                                self.fbuserimage = UIImage(data: data)!
                            } else {
                                self.fbuserimage = defaultcatimages[1].itemimage
                            }

                            
                            self.userdetails = [self.fbusername,self.fbuseremail,self.fbuserimage]
                            
                            print(self.userdetails)
                            
                            var query:PFQuery = PFUser.query()!
                            query.whereKey("objectId", equalTo: user.objectId!)
                            query.limit = 1
                            query.getFirstObjectInBackgroundWithBlock() {
                                //getFirstObject()
                                /*
                                var categories = querycat.findObjects()
                                if (categories != nil) {
                                for category in categories! {

                */
                                (user: PFObject?, error: NSError?) -> Void in
                                if error != nil {
                                    print(error)
                                    self.restore()
                                    self.displayFailAlert(NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("error2", comment: ""))
                                } else if let user = user {
                                    
                                    //user["username"] = self.userdetails[0]
                                    user["username"] = self.userdetails[1]
                                    user["name"] = self.userdetails[0]
                                    user["email"] = self.userdetails[1]
                                    
                                    print(self.userdetails)
                                    
                                    var file = PFFile(data: UIImageJPEGRepresentation(self.userdetails[2] as! UIImage, 0.7)!)
                                    user["Avatar"] = file
                                    
                                    user.saveInBackgroundWithBlock({ (success, error) -> Void in
                                        if success {
                                            
                                            var installation: PFInstallation = PFInstallation.currentInstallation()
                                            installation.addUniqueObject("ReloadNew", forKey: "channels")
                                            installation["user"] = PFUser.currentUser()
                                            installation.saveInBackground()
                                            
                                            loggedIn = true
                                            
                                           // self.maindelegate?.loaduserdata()
                                            
                                           // self.maindelegate?.refreshmainview()
                                            
                                           // if self.maindelegate == nil {
                                            
                                            let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                            
                                            let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                                            
                                            //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                                            
                                            
                                            mainmenu.loaduserdata()
                                            
                                            mainmenu.refreshafterlogin()
                                            self.restore()
                                            
                                            self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                                            
                                            
                                       
                                            
                                        } else {
                                            self.restore()
                                            self.displayFailAlert(NSLocalizedString("errorExc", comment: ""), message: NSLocalizedString("error2", comment: ""))
                                            print("error")
                                        }
                                        
                                    })
                                    
                                }
                            }
                            
                            
                        }
                    }
                    
                    
                } else {
                    
                  
                    loggedIn = true
                    
                    print("User logged in through Facebook!")
                    
                   // self.maindelegate?.loaduserdata()
                    
                   // self.maindelegate?.refreshmainview()
                    
                   // if self.maindelegate == nil {
                        
                    let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    
                    let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                    
                    //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                    
                    
                    mainmenu.loaduserdata()
                    
                    mainmenu.refreshafterlogin()
                    
                    self.restore()
                    
                    self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                }
                
                
                
            } else {
                self.restore()
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
 
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        if segue.identifier == "Registration" {
            
           // let regNav = segue.destinationViewController as! UINavigationController

           //  let toViewController = regNav.viewControllers.first as! RegisterViewController
            
            let toViewController = segue.destinationViewController as! RegisterViewController
            
            toViewController.maindelegate = maindelegate
            
            
        }

    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
  
    @IBOutlet var sendpassoutlet: UIButton!
    
    @IBOutlet var googleouterview: UIView!
    
    /*
    func vkSdkAcceptedUserToken(token: VKAccessToken!) {
        print("ACCEPTED", appendNewline: true)
    }
    */
    
    
    /////// VKONTAKTE LOGIN PART
    
    
    var socialParams : NSDictionary!
    
    let vkToken = "my_token_from_vk"
    
    @IBAction func VkontakteLoginButton(sender: AnyObject) {
        
        //VKSdk.authorize([VK_PER_EMAIL], revokeAccess: true)
        VKSdk.authorize([VK_PER_WALL,VK_PER_EMAIL])
    }
    
    func vkSdkAcceptedUserToken(token: VKAccessToken!) {
        //
        
        print("ACCEPTED", terminator: "\n")
    }
    
    
    @IBAction func vkloginbutton2(sender: AnyObject) {
        
         VKSdk.authorize([VK_PER_WALL,VK_PER_EMAIL])
    }
    
    
    //VK DELEGATE FUNCS
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        print("authorized")
        
        vkSdkReceivedNewToken(result.token)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("failed")
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError) { }
    func vkSdkTokenHasExpired(expiredToken: VKAccessToken) { }
    func vkSdkUserDeniedAccess(authorizationError: VKError) {  }
    
    func vkSdkShouldPresentViewController(controller: UIViewController) {
        self.presentViewController(controller, animated: true, completion: nil)
    }
    func vkSdkReceivedNewToken(newToken: VKAccessToken) {
        
        let uEmail = VKSdk.accessToken().email
        // let uName = VKSdk.accessToken().
     //   getAccessToken().email
        
        
        print(uEmail)
        
        if uEmail != nil {
            // let uInfoReq: VKRequest = VKRequest(method: "users.get", andParameters: nil, andHttpMethod: "GET")
            let uInfoReq: VKRequest = VKRequest(method: "users.get", andParameters:  [VK_API_FIELDS : "photo_50,photo_100"])//nil)
            uInfoReq.executeWithResultBlock(
                {
                    (response) -> Void in
                    
                    let uInfo =  response.json as! NSArray
                    
                    let uid: AnyObject = uInfo[0].objectForKey("id")!
                    
                    let ufName: AnyObject = uInfo[0].objectForKey("first_name")
                    
                    let usName: AnyObject = uInfo[0].objectForKey("last_name")
                    
                    let photo: AnyObject = uInfo[0].objectForKey("photo_50")//photo_50//
                    
                    
                    
                    self.socialParams = ["id" : "\(uid)", "email" : "\(uEmail)", "name" : "\(ufName) \(usName)", "avatar" : photo]
                    
                    let pass = "vkpass12345"
                    
                    print(self.socialParams)
                    
                    var avatar = UIImage()
                    var imageFile = PFFile()
                    

                    
                    //// PARSE PART 
                    
                    var query:PFQuery = PFUser.query()!
                    // query.whereKey("googleId", notEqualTo: nil)
                    query.whereKey("vkontakteId", equalTo: uid)
                    // query.getFirstObjectInBackgroundWithBlock() {
                    //var allusers = query.findObjects()
                    
                    
                    query.getFirstObjectInBackgroundWithBlock {
                        (object: PFObject?, error: NSError?) -> Void in
                        if error != nil && object == nil {
                            
                            
                            var imgURL: NSURL = NSURL(string: photo as! String)!
                            let request: NSURLRequest = NSURLRequest(URL: imgURL)
                            NSURLConnection.sendAsynchronousRequest(
                                request, queue: NSOperationQueue.mainQueue(),
                                completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                                    if error == nil {
                                        
                                        
                                        avatar = UIImage(data: data!)!
                                        
                                        imageFile = PFFile(name:"user_avatar.png", data:data!)
                                        
                                        var pfUser = PFUser()
                                        pfUser.username = uEmail
                                        pfUser.email = uEmail
                                        pfUser["name"] = self.socialParams.objectForKey("name")//ufName
                                        
                                        //print(imageFile)
                                        
                                        pfUser["Avatar"] = imageFile
                                        pfUser.password = pass //commonpass for all users from google
                                        pfUser["vkontakteId"] = uid
                                        
                                        
                                        pfUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
                                            
                                            
                                            if error == nil {
                                                
                                                
                                                // NEED TO LOGIN ALSO IMMEDIATELY
                                                PFUser.logInWithUsernameInBackground(uEmail, password: pass, block: { (newuser, error) -> Void in
                                                    
                                                    
                                                    if newuser != nil {
                                                        
                                                        // Logged In!
                                                        loggedIn = true
                                                        
                                                        var installation: PFInstallation = PFInstallation.currentInstallation()
                                                    
                                                        installation["user"] = PFUser.currentUser()
                                                        installation.saveInBackground()
                                                        
                                                      //  self.maindelegate?.loaduserdata()
                                                        
                                                      //  self.maindelegate?.refreshmainview()
                                                        
                                                       // if self.maindelegate == nil {
                                                            
                                                            let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                                            
                                                            let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                                                            
                                                            //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                                                            
                                                            
                                                            mainmenu.loaduserdata()
                                                            
                                                            mainmenu.refreshafterlogin()
                                                            
                                                       // }
                                                        
                                                
                                                      self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                                                        // loggedIn = true
                                                        
                                                    } else {
                                                        
                                                        if let errorString = error!.userInfo["error"] as? String {
                                                            
                                                            print(errorString)
                                                            
                                                        }
                                                        
                                                        print("failedlogin")
                                                        
                                                    }
                                                    
                                                })
                                                
                                                
                                                
                                                
                                            } else {
                                                
                                                if let errorString = error!.userInfo["error"] as? String {
                                                    
                                                    print(errorString)
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                        })
                                        
                                        
                                    } else {
                                        // biatch
                                        self.displayFailAlert("Error!", message: "Can't login via VK.com")
                                    }
                            
                            })

                            
                            
                            
                        } else if error == nil && object != nil {
                            // The find succeeded.
                            print("Successfully retrieved the object.")
                            // sign up for parse
                            
                            PFUser.logInWithUsernameInBackground(uEmail, password: pass, block: { (newuser, error) -> Void in
                                
                                
                                if newuser != nil {
                                    
                                    // Logged In!
                                    loggedIn = true
                                    
                                  //  let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                    
                                  //  let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
                                    
                                    
                                  //  self.window?.rootViewController = mainmenu
                                    
                                    var installation: PFInstallation = PFInstallation.currentInstallation()
                                  //  installation.addUniqueObject("ReloadNew", forKey: "channels")
                                    installation["user"] = PFUser.currentUser()
                                    installation.saveInBackground()
                                    
                                   // self.maindelegate?.loaduserdata()
                                    
                                   // self.maindelegate?.refreshmainview()
                                    
                                   // if self.maindelegate == nil {
                                        
                                        let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                        
                                        let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! AllListsVC
                                        
                                        //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                                        
                                        
                                        mainmenu.loaduserdata()
                                        
                                        mainmenu.refreshafterlogin()
                                        
                                    //}

                                    
                                   // mainmenu.loaduserdata()
                                    
                                   // mainmenu.refreshmainview()
                                    
                                     self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                                    
                                } else {
                                    
                                    if let errorString = error!.userInfo["error"] as? String {
                                        
                                        print(errorString)
                                        
                                    }
                                    
                                    print("failedlogin")
                                    
                                }
                                
                            })
                            ///
                            
                            
                            
                        } else {
                            
                            print("error! \(error)")
                        }
                        
                        
                    }
                    
                    
                    //// END OF PARSE PART
                    
                }, errorBlock: {
                    (error) -> Void in
                    print("error", terminator: "\n")
                    NSLog("VK error: %@", error)
                    
            })
                    
                    
                    
                    
        }
        else {
            //let vkError = ErrorHandler()
            //vkError.showErrorAlert(header: "Ошибка!", message: "Предоставьте доступ к Вашему E-mail адресу!")
            displayFailAlert("Error!", message: "Can't login via VK.com")
        }
    }
    //VK DELEGATE ENDS
    
    
    @IBOutlet var loginoutlet: UIButton!
    
    
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
    //myTextField.delegate = self
    ///
    
    
    
    
    @IBOutlet var logview: UIView!
    
    
    @IBOutlet var passview: UIView!
    
    @IBOutlet var openmenu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openmenu.target = self.revealViewController()
        
        openmenu.action = Selector("revealToggle:")
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        LoginField.delegate = self
        
        PassField.delegate = self
        ////LoginField.layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
        
       // PassField.layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
        LoginField.leftTextMargin = 5
        PassField.leftTextMargin = 5
        
      //  googlesignin.layer.borderWidth = 1
      //  googlesignin.layer.borderColor = UIColorFromRGB(0x3B5998).CGColor
        
        //googlesignin.frame.size.height = 30

        
       // googleouterview.layer.borderWidth = 1
       // googleouterview.layer.borderColor = UIColorFromRGB(0xEA4335).CGColor
        
       // googleouterview.frame.size.height = 30

        
       // facebookview.layer.borderWidth = 1
       // facebookview.layer.borderColor = UIColorFromRGB(0x3B5998).CGColor
        
       // loginoutlet.layer.borderWidth = 1
       // loginoutlet.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
        
        
        logview.layer.borderWidth = 1
        logview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        
        passview.layer.borderWidth = 1
        passview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        
        sendpassoutlet.layer.borderWidth = 1
        sendpassoutlet.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        
        sendpassfield.leftTextMargin = 5
        
        forgotblock.layer.cornerRadius = 4
        forgotblock.layer.borderWidth = 1
        forgotblock.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        //google stuff
        
        GIDSignIn.sharedInstance().uiDelegate = self

        //Maybe its better in MainMenuVC
        
        
        
       // VKSdk.initia
         let sdk = VKSdk.initializeWithAppId("5155199") //.initializeWithDelegate(self, andAppId: "5155199")
         sdk.registerDelegate(self)
         //sdk.uiDelegate(self)
         //VKSdk.registerDelegate(self) //registerDelegate(self)
        
        // Do any additional setup after loading the view.
        /*
        if PFAnonymousUtils.isLinkedWithUser(PFUser.currentUser()) {
            self.registeroutlet.hidden = false
        } else {
            self.registeroutlet.hidden = true
        }
        */
        
        if loggedIn {
            self.registeroutlet.hidden = true
            //self.registerview.hidden = true
            self.notreg.hidden = true
        } else {
            self.registeroutlet.hidden = false
            //self.registerview.hidden = false
            self.notreg.hidden = false
        }
    }

    @IBOutlet var notreg: UILabel!
    
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
