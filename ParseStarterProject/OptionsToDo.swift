//
//  OptionsToDo.swift
//  PerfectList
//
//   Created by PekkiPo (Aleksei Petukhov) on 11/01/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit
import EventKit

protocol ToDoOptionsPopupDelegate
{

    func changecolor(code: String)

}

class OptionsToDo: UIViewController, UITextFieldDelegate {

    
    
    
    var senderVC = String()
    
    var delegate: ToDoOptionsPopupDelegate?
    
    var colorcode = String()
    
    var red:String = "F23D55"
    var dgreen:String = "31797D"
    var lgreen:String = "61C791"
    var yellow:String = "DAFFA4"
    var black:String = "2A2F36"
    var gold:String = "A2AF36"
    var grey:String = "838383"
    
    @IBOutlet var redcolor: UIButton!
    
    @IBOutlet var darkgreencolor: UIButton!
    
    @IBOutlet var lightgreencolor: UIButton!
    
    
    @IBOutlet var yellowcolor: UIButton!
    
    @IBOutlet var blackcolor: UIButton!
    
    
    @IBOutlet var greycolor: UIButton!
    
    
    @IBOutlet var goldcolor: UIButton!
    
    
    var colorchanged: Bool = false
   
    
    @IBAction func redaction(sender: AnyObject) {
        
        colorcode = red
        redcolor.alpha = 1
        darkgreencolor.alpha = 0.4
        lightgreencolor.alpha = 0.4
        yellowcolor.alpha = 0.4
        blackcolor.alpha = 0.4
        greycolor.alpha = 0.4
        goldcolor.alpha = 0.4
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)

        
    }
    
    
    @IBAction func darkgreenaction(sender: AnyObject) {
        
        colorcode = dgreen
        redcolor.alpha = 0.4
        darkgreencolor.alpha = 1
        lightgreencolor.alpha = 0.4
        yellowcolor.alpha = 0.4
        blackcolor.alpha = 0.4
        greycolor.alpha = 0.4
        goldcolor.alpha = 0.4
        
         colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    @IBAction func lightgreenaction(sender: AnyObject) {
        colorcode = lgreen
        redcolor.alpha = 0.4
        darkgreencolor.alpha = 0.4
        lightgreencolor.alpha = 1
        yellowcolor.alpha = 0.4
        blackcolor.alpha = 0.4
        greycolor.alpha = 0.4
        goldcolor.alpha = 0.4
        
         colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    @IBAction func yellowaction(sender: AnyObject) {
        
        colorcode = yellow
        redcolor.alpha = 0.4
        darkgreencolor.alpha = 0.4
        lightgreencolor.alpha = 0.4
        yellowcolor.alpha = 1
        blackcolor.alpha = 0.4
        greycolor.alpha = 0.4
        goldcolor.alpha = 0.4
        
         colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    @IBAction func blackaction(sender: AnyObject) {
        colorcode = black
        redcolor.alpha = 0.4
        darkgreencolor.alpha = 0.4
        lightgreencolor.alpha = 0.4
        yellowcolor.alpha = 0.4
        blackcolor.alpha = 1
        greycolor.alpha = 0.4
        goldcolor.alpha = 0.4
        
         colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    
    @IBAction func greyaction(sender: AnyObject) {
        colorcode = grey
        redcolor.alpha = 0.4
        darkgreencolor.alpha = 0.4
        lightgreencolor.alpha = 0.4
        yellowcolor.alpha = 0.4
        blackcolor.alpha = 0.4
        greycolor.alpha = 1
        goldcolor.alpha = 0.4
        
         colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    @IBAction func goldaction(sender: AnyObject) {
        colorcode = gold
        redcolor.alpha = 0.4
        darkgreencolor.alpha = 0.4
        lightgreencolor.alpha = 0.4
        yellowcolor.alpha = 0.4
        blackcolor.alpha = 0.4
        greycolor.alpha = 0.4
        goldcolor.alpha = 1
        
         colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    
    @IBAction func cancelbutton(sender: AnyObject) {
        
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    var listtoupdate = String()
    
    @IBAction func savebutton(sender: AnyObject) {
        
        if senderVC == "ToDoList" {
            
            delegate?.changecolor(colorcode)
            
        } else if senderVC == "AllListsVC" {
            
            let query = PFQuery(className:"toDoLists")
            
            query.fromLocalDatastore()
            query.whereKey("listUUID", equalTo: listtoupdate)
            
            query.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {
                    if self.colorchanged == true {
                    shopList["ListColorCode"] = self.colorcode
                    }
                    
                    shopList.pinInBackground()
                    shopList.saveEventually()
                    
                    
                    
                }
                
            }
            
            
            if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                if self.colorchanged == true {
                UserToDoLists[foundtodolist].listcolorcode = colorcode
                }
            }
            
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                if self.colorchanged == true {
                UserLists[foundlist].listcolorcode = colorcode
                }
            }
            
            if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                if self.colorchanged == true {
                UserFavLists[foundfavlist].listcolorcode = colorcode
                }
            }
            
            
        }
        
         dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//(1.0)
        )
    }
    
    func displaySuccessAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "SuccessAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        //alertview.addAction(closeCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addCancelAction(closeCallback)
    }
    
    
    
    func cancelCallback() {
        print("CANCELED")
    }
    
    func closeCallback() {
        
        //self.tableView.reloadData()
        
        print("JUST CLOSED")
        
    }
    //// REMINDER PART
    
    @IBOutlet var datePicker: UIDatePicker!
    
  
    
    
    @IBOutlet var setreminderoutlet: UIButton!
    
    
    @IBAction func savereminder(sender: AnyObject) {
        
        
        let reminder = EKReminder(eventStore: self.eventStore)
        reminder.title = self.remindernote.text!
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dueDateComponents = appDelegate.dateComponentFromNSDate(self.datePicker.date)
        reminder.dueDateComponents = dueDateComponents
        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
        do {
            try self.eventStore.saveReminder(reminder, commit: true)
            //dismissViewControllerAnimated(true, completion: nil)
            self.displaySuccessAlert(NSLocalizedString("DoneExc", comment: "DoneExc"), message: NSLocalizedString("RemSet", comment: "ReminderSet"))
        }catch{
            self.displayFailAlert(NSLocalizedString("Oops", comment: "Oops"), message: NSLocalizedString("WasError", comment: "WasError"))
            print("Error creating and saving new reminder : \(error)")
        }
        
        /*
        let reminder = EKReminder(eventStore: self.eventStore)
        reminder.title = remindernote.text!
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dueDateComponents = appDelegate.dateComponentFromNSDate(datePicker.date)
        reminder.dueDateComponents = dueDateComponents
        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
        do {
            try self.eventStore.saveReminder(reminder, commit: true)
            //dismissViewControllerAnimated(true, completion: nil)
            displaySuccessAlert("Done!", message: "Reminder is set")
        }catch{
            displayFailAlert("Oops", message: "There was an error")
            print("Error creating and saving new reminder : \(error)")
        }
        */

        
    }
    
  
    
    @IBOutlet var remindernote: UITextField!
    
    var eventStore: EKEventStore!
    
    func addDate(){
       // duelabel.text = "Time: \(datePicker.date.description)"
    }
    
    override func viewWillAppear(animated: Bool) {
        // Fetch all reminders
        // Connect to the Event Store
        self.eventStore = EKEventStore()
        
        self.eventStore.requestAccessToEntityType(EKEntityType.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                
                print("access granted")
                /*
                let reminder = EKReminder(eventStore: self.eventStore)
                reminder.title = self.remindernote.text!
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let dueDateComponents = appDelegate.dateComponentFromNSDate(self.datePicker.date)
                reminder.dueDateComponents = dueDateComponents
                reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                do {
                try self.eventStore.saveReminder(reminder, commit: true)
                //dismissViewControllerAnimated(true, completion: nil)
                self.displaySuccessAlert("Done!", message: "Reminder is set")
                }catch{
                self.displayFailAlert("Oops", message: "There was an error")
                print("Error creating and saving new reminder : \(error)")
                }
                */
                
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }
        
        
    }

    
    //// END REMINDER PART

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
    
    
    @IBOutlet var cancelb: UIButton!
    
    @IBOutlet var doneb: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelb.layer.borderWidth = 1
        cancelb.layer.borderColor = UIColorFromRGBalpha(0xF23D55, alp: 1.0).CGColor
        cancelb.layer.cornerRadius = 8
        
        
        doneb.layer.cornerRadius = 8

        remindernote.delegate = self
       // datePicker = UIDatePicker()
        datePicker.addTarget(self, action: "addDate", forControlEvents: UIControlEvents.ValueChanged)
        
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
       // dateTextField.inputView = datePicker
        
        // Do any additional setup after loading the view.
        
        setreminderoutlet.layer.borderWidth = 1
        setreminderoutlet.layer.borderColor = UIColorFromRGBalpha(0x61C791, alp: 1.0).CGColor
        
       // duedateoutlet.layer.borderWidth = 1
       // duedateoutlet.layer.borderColor = UIColorFromRGBalpha(0x2A2F36, alp: 1.0).CGColor
        
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
