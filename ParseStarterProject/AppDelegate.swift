//
//  AppDelegate.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit

import Bolts
import Parse

import FBSDKLoginKit
import FBSDKCoreKit
/*
extension UIViewController {
func presentViewControllerFromVisibleViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    if let navigationController = self as? UINavigationController, let topViewController = navigationController.topViewController {
        topViewController.presentViewControllerFromVisibleViewController(viewControllerToPresent, animated: true, completion: completion)
    } else if (presentedViewController != nil) {
        presentedViewController!.presentViewControllerFromVisibleViewController(viewControllerToPresent, animated: true, completion: completion)
    } else {
        presentViewController(viewControllerToPresent, animated: true, completion: completion)
    }
}
}
*/
// If you want to use any of the UI components, uncomment this line
// import ParseUI

// If you want to use Crash Reporting - uncomment this line
// import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Enable storing and querying data from Local Datastore. 
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
        Parse.enableLocalDatastore()
        
        UIApplication.sharedApplication().idleTimerDisabled = true

        // ****************************************************************************
        // Uncomment this line if you want to enable Crash Reporting
        // ParseCrashReporting.enable()
        //
        // Uncomment and fill in with your Parse credentials:
        Parse.setApplicationId("rmOTXYhhIhvNJNoD8lji40M6t2TD5GiLnPCm88v3",
            clientKey: "lWARXbJPC23A8VzpQAZgzsoXztdl0IBFS3D4sBYd")
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        PFTwitterUtils.initializeWithConsumerKey("5gVWGw2APWMoZ7wj7ueIGiBR5",  consumerSecret:"WEqWE1IEGYnd5M32DHXwp6fay6LAI81kpLYFL04xNzo7uDSgmH")
        
        //
        // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
        // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
        // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
        // PFFacebookUtils.initializeFacebook()
        // ****************************************************************************

        PFUser.enableAutomaticUser()
        
        PFUser.enableRevocableSessionInBackground()
        
        
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        
        UINavigationBar.appearance().backgroundColor = UIColorFromHex(0xF9F9F9)

        let defaultACL = PFACL();

        // If you would like all objects to be private by default, remove this line.
        defaultACL.setPublicReadAccess(true)

        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)

        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.

            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var noPushPayload = false;
            if let options = launchOptions {
                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
            }
            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            //let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
            
            //let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            //application.registerUserNotificationSettings(settings)
           // application.registerForRemoteNotifications()
            
            
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
            
        } else {
           // let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
             let types = UIRemoteNotificationType([.Alert, .Badge, .Sound])
            application.registerForRemoteNotificationTypes(types)
           // let types = UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound
             //application.registerForRemoteNotificationTypes(types)//registerForRemoteNotifications(types)
            
            
           // var settings = UIUserNotificationSettings(forTypes: UIUserNotificationType([.Alert, .Badge, .Sound]), categories: nil)
        }

        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
           //
            if url.scheme == "fb162714990748932" {
                return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
            } else if url.scheme == "vk5155199" {
                let ret:Bool = VKSdk.processOpenURL(url, fromApplication: sourceApplication)
                return ret
            } else {
                return GIDSignIn.sharedInstance().handleURL(url,
                    sourceApplication: sourceApplication,
                    annotation: annotation)
            }
           //IF ONLY FACEBOOK //return FBSDKApplicationDelegate.sharedInstance().application(application,
              //  openURL: url,
             //   sourceApplication: sourceApplication,
             //   annotation: annotation)
            
            
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
    
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                var userId = user.userID                  // For client-side use only!
                var idToken = user.authentication.idToken // Safe to send to the server
                var name = user.profile.name
                var email = user.profile.email
                var avatar = UIImage()
                var profileimage = user.profile.imageURLWithDimension(50)
                
                var pass = "12345"
                    
               // var profileimage = NSURL(string: "https://plus.google.com/s2/photos/profile/\(userId)?sz=100")
                
                //var profileimage = NSURL(string: "https://www.googleapis.com/plus/v1/people/\(userId)?fields=image&key={AIzaSyCAgSBQ2iDB5z9UdkLmY0ADt67PPuve5F4}")
                //perfectlist-b2383
                
                print(userId)
                
                if let data = NSData(contentsOfURL: profileimage!) {
                    avatar = UIImage(data: data)!
                }
                
                let imageData = UIImagePNGRepresentation(avatar)
                //let imageData = UIImagePNGRepresentation(chosenPicture)
                let imageFile = PFFile(name:"user_avatar.png", data:imageData!)
                
                saveImageLocally(imageData)
                
               
                
                var query:PFQuery = PFUser.query()!
               // query.whereKey("googleId", notEqualTo: nil)
                query.whereKey("googleId", equalTo: userId)
               // query.getFirstObjectInBackgroundWithBlock() {
                //var allusers = query.findObjects()
                
                
                query.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                if error != nil && object == nil {
                    
                    
                    var pfUser = PFUser()
                    pfUser.username = email
                    pfUser.email = email
                    pfUser["name"] = name
                    pfUser["Avatar"] = imageFile
                    pfUser.password = pass //commonpass for all users from google
                    pfUser["googleId"] = userId
                    pfUser["avatarimagepath"] = self.imagePath
                    
                    
                    pfUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
                        
                        
                        if error == nil {
                            
                            
                            // NEED TO LOGIN ALSO IMMEDIATELY
                            PFUser.logInWithUsernameInBackground(email, password: pass, block: { (newuser, error) -> Void in
                                
                                
                                if newuser != nil {
                                    
                                    // Logged In!
                                    loggedIn = true
                                    
                                    let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                                    
                                    let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
                                    
                                    //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                                    
                                    self.window?.rootViewController = mainmenu
                                    
                                    
                                    mainmenu.loaduserdata()
                                    
                                    mainmenu.refreshmainview()
                                    
                                    
                                    
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
                    
                    
                   } else if error == nil && object != nil {
                // The find succeeded.
                    print("Successfully retrieved the object.")
                    // sign up for parse
                    
                    PFUser.logInWithUsernameInBackground(email, password: pass, block: { (newuser, error) -> Void in
                        
                        
                        if newuser != nil {
                            
                            // Logged In!
                            loggedIn = true
                            
                            var installation: PFInstallation = PFInstallation.currentInstallation()
                            installation.addUniqueObject("Reload", forKey: "channels")
                            installation["user"] = PFUser.currentUser()
                            installation.saveInBackground()
                            
                            let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                            
                            let mainmenu = myStoryBoard.instantiateViewControllerWithIdentifier("MainMenu") as! MainMenuViewController
                            
                            
                            self.window?.rootViewController = mainmenu
                            
                            
                            mainmenu.loaduserdata()
                            
                            mainmenu.refreshmainview()
                            
                            
                            
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
                
                print("App del : \(name) and \(email) and \(avatar)")
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
    }
    
    
    //Make sure it isn't already declared in the app delegate (possible redefinition of func error)
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
        
        let currentInstallation = PFInstallation.currentInstallation()
        if currentInstallation.badge != 0 {
            currentInstallation.badge = 0
            currentInstallation.saveEventually()
        }
        // ...
    }

    //--------------------------------------
    // MARK: Push Notifications
    //--------------------------------------

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
        
        PFPush.subscribeToChannelInBackground("") { (succeeded: Bool, error: NSError?) in
            if succeeded {
                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
            } else {
                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.", error)
            }
        }
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    
    // FOR push within the app
    /*
    func displayReceivedAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "plus.png")
        let alertview = JSSAlertView().show( (self.window?.rootViewController?. )!, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x9b59b6, alpha: 1), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(closeCallback)
    }
    */
    func closeCallback() {
        //(self.window?. .reloadData()
        //(self.window?.rootViewController)!
        print("Closed")
    }

    ////
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // PFPush.handlePush(userInfo)
        // MY STUFF

        //var mesalert = String()
        
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                    
                    mesalert = message as String
                }
            } else if let alert = aps["alert"] as? NSString {
                
                mesalert = alert as String
            }
        }
        
        print(mesalert)
        
        var customIcon = UIImage()
        
        if (mesalert as NSString).containsString("Incoming") || (mesalert as NSString).containsString("Входящий"){
            
            //receivedeventscount += 1
             NSNotificationCenter.defaultCenter().postNotificationName("reloadTableLists", object: nil)
            
           // receivedcount += 1
           customIcon = UIImage(named: "ListSentSuccess")!
         //   displayReceivedAlert("", message: mesalert)
            
        } else if (mesalert as NSString).containsString("going") || (mesalert as NSString).containsString("собирается") {
          //  displayReceivedAlert("", message: mesalert)
            
            NSNotificationCenter.defaultCenter().postNotificationName("reloadTable", object: nil)
          //  receivedeventscount += 1
            customIcon = UIImage(named: "EventAlert")!
            
            
        } else {
           // displayReceivedAlert("", message: mesalert)
             NSNotificationCenter.defaultCenter().postNotificationName("reloadTable", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotificationName("reloadTableLists", object: nil)
            
            //NSNotificationCenter.defaultCenter().postNotificationName("reloadTableMenu", object: nil)
            
            customIcon = UIImage(named: "EventAlert")!
        }
        
        
        let alertview = JSSAlertView().show((self.window?.rootViewController)!, title: "", text: mesalert, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        alertview.addCancelAction(closeCallback)
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadTableMenu", object: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadTableShop", object: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadTableToDo", object: nil)
        
      //  self.window?.rootViewController?.presentViewController(alertview, animated: true, completion: nil)
        
       // NSNotificationCenter.defaultCenter().postNotificationName("reloadTable", object: nil)
        //
        
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }
    
    
/*
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
       // PFPush.handlePush(userInfo)
        // MY STUFF
        
        var mesalert = String()
        
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                 if let alert = aps["alert"] as? NSString {
                
                    mesalert = alert as String
                    
                }
            }
        }
            if (mesalert as NSString).containsString("Incoming") {
            
                //receivedeventscount += 1
                receivedcount += 1
                
                displayReceivedAlert("", message: mesalert)
                
            } else if (mesalert as NSString).containsString("going") {
                displayReceivedAlert("", message: mesalert)
                receivedeventscount += 1
            }
        NSNotificationCenter.defaultCenter().postNotificationName("reloadTable", object: nil)
        //
        
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }
*/
    ///////////////////////////////////////////////////////////
    // Uncomment this method if you want to use Push Notifications with Background App Refresh
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    //     if application.applicationState == UIApplicationState.Inactive {
    //         PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
    //     }
    // }

    //--------------------------------------
    // MARK: Facebook SDK Integration
    //--------------------------------------

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you are using Facebook
    

    
/*
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
       return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
   }
    */
    
    func dateComponentFromNSDate(date: NSDate)-> NSDateComponents{
        
        let calendarUnit: NSCalendarUnit = [.Hour, .Day, .Month, .Year]
        let dateComponents = NSCalendar.currentCalendar().components(calendarUnit, fromDate: date)
        return dateComponents
    }
}
