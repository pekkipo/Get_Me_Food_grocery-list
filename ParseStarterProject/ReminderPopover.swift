//
//  ReminderPopover.swift
//  PerfectList
//
//  Created by PekkiPo (Aleksei Petukhov) on 12/01/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit
import EventKit



class ReminderPopover: UIViewController, UITextFieldDelegate {

    var senderVC = String()
    
    var todocaption = String()
    
    
    @IBOutlet var remindernote: CustomTextField!
    
    
    @IBOutlet var datePicker: UIDatePicker!
    
    
    @IBOutlet var reminderoutlet: UIButton!
    
    
    
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
         alertview.addAction(cancelCallback)
        //alertview.addCancelAction(closeCallback)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    @IBAction func close(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    
    
    func cancelCallback() {
         dismissViewControllerAnimated(true, completion: nil)
        print("CANCELED")
    }
    
    func closeCallback() {
        
        //self.tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func savereminder(sender: AnyObject) {
        

        let reminder = EKReminder(eventStore: self.eventStore)
        reminder.title = remindernote.text!
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dueDateComponents = appDelegate.dateComponentFromNSDate(datePicker.date)
        reminder.dueDateComponents = dueDateComponents
        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
        do {
            try self.eventStore.saveReminder(reminder, commit: true)
            //dismissViewControllerAnimated(true, completion: nil)
            displaySuccessAlert(NSLocalizedString("DoneExc", comment: "DoneExc"), message: NSLocalizedString("RemSet", comment: "ReminderSet"))
        }catch{
            displayFailAlert(NSLocalizedString("Oops", comment: "Oops"), message: NSLocalizedString("WasError", comment: "WasError"))
            print("Error creating and saving new reminder : \(error)")
        }
        
        

    }
    
    var eventStore: EKEventStore!
    
    override func viewWillAppear(animated: Bool) {
        // Fetch all reminders
        // Connect to the Event Store
        self.eventStore = EKEventStore()
        
        self.eventStore.requestAccessToEntityType(EKEntityType.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                
                print("access granted")

                
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }

        
        if senderVC == "ToDoItem" {
            remindernote.text = todocaption
            
        } else if senderVC == "ShopOptions" {
            remindernote.text = NSLocalizedString("goshoppingreminder", comment: "Oops")
        } else if senderVC == "ToDoOptions" {
            remindernote.text = ""
        }
        
        
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.clearColor()
        
        remindernote.delegate = self
        
        remindernote.leftTextMargin = 18
        
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        // dateTextField.inputView = datePicker
        
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
