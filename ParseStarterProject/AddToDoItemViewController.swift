//
//  AddToDoItemViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 31/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation

protocol RefreshToDoListDelegate
{
    //func choosecategory(category:Category)
    func refreshtodotable()
}

class AddToDoItemViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPopoverPresentationControllerDelegate {
    
   /*
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    */
    @IBOutlet var borderView: UIView!
    
    var tododelegate : RefreshToDoListDelegate?
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("loading", comment: ""))
    
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
    
    
    
    
    var existingitem = Bool()
    var currentitem = String()
    var currentlist = String()
    
    
    @IBOutlet weak var caption: CustomTextField!//UITextField!
    
    
    @IBOutlet weak var text: UITextView!
    
    
    @IBAction func priority(sender: AnyObject) {
        
        
    }
    
    @IBOutlet weak var priorityswitcher: UISwitch!
    
    @IBAction func cancel(sender: AnyObject) {
        
        performSegueWithIdentifier("gobacktotodolist", sender: self)
    }
    
    
    @IBAction func done(sender: AnyObject) {
        
        if existingitem == false
        {
            createnewitem(currentlist)
        }
        else {
            saveexistingitem()
        }
        
        if((self.tododelegate) != nil)
        {
            tododelegate?.refreshtodotable()
            //refreshtable in shoplist view!
            
        }
        
        performSegueWithIdentifier("gobacktotodolist", sender: self)
        
    }
    
    
    func retrieveexistingitem(thisitemid: String) {
        
        print(thisitemid)
        
       // if let founditem = find(lazy(toDoItems).map({ $0.itemid }), thisitemid) {
        if let founditem = toDoItems.map({ $0.itemid }).lazy.indexOf(thisitemid) {

        
            let item = toDoItems[founditem]
            
            self.caption.text = item.itemname
            
            self.text.text = item.itemnote
            
            if item.itemimportant == true {
                
                priorityswitcher.on = true
                
            } else {
                priorityswitcher.on = false
            }
            
        }
        
        
        
    }
    /* APPROACH 1
    func saveexistingitem() {
    
    var query = PFQuery(className:"toDoItems")
    query.fromLocalDatastore()
    query.whereKey("itemUUID", equalTo: currentitem)
    query.getFirstObjectInBackgroundWithBlock() {
    (item: PFObject?, error: NSError?) -> Void in
    if error != nil {
    println(error)
    } else if let item = item {
    
    item["todoitemname"] = self.caption.text
    item["todoitemnote"] = self.text.text
    if self.priorityswitcher.on {
    item["isImportant"] = true
    } else {
    item["isImportant"] = false
    }
    
    item.pinInBackgroundWithBlock({
    (success: Bool, error: NSError?) -> Void in
    if (success) {
    
    
    if let founditem = find(lazy(toDoItems).map({ $0.itemid }), self.currentitem) {
    
    let item = toDoItems[founditem]
    
    item.itemname = self.caption.text
    
    item.itemnote = self.text.text
    
    if self.priorityswitcher.on {
    item.itemimportant = true
    } else {
    item.itemimportant = false
    }
    
    }
    
    
    
    } else {
    
    }
    })
    
    item.saveEventually()
    
    
    
    }
    }
    
    
    
    }
    */
    
    //APPROACH 2
    func saveexistingitem() {
        
        
       // if let founditem = find(lazy(toDoItems).map({ $0.itemid }), self.currentitem) {
        
        
         if let founditem = toDoItems.map({ $0.itemid }).lazy.indexOf(self.currentitem) {
            let item = toDoItems[founditem]
            
            item.itemname = self.caption.text!
            
            item.itemnote = self.text.text
            
            if self.priorityswitcher.on == true {
                item.itemimportant = true
            } else {
                item.itemimportant = false
            }
            
        }
        
        //dispatch_async(dispatch_get_main_queue(), {
            // START OF DISPATCH
            
            
            let query = PFQuery(className:"toDoItems")
            query.fromLocalDatastore()
            query.whereKey("itemUUID", equalTo: self.currentitem)
            query.getFirstObjectInBackgroundWithBlock() {
                (item: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let item = item {
                    
                    item["todoitemname"] = self.caption.text
                    item["todoitemnote"] = self.text.text
                    if self.priorityswitcher.on {
                        item["isImportant"] = true
                    } else {
                        item["isImportant"] = false
                    }
                    
                    let date = NSDate()
                    
                    item["updateDate"] = date
                    
                    item.pinInBackgroundWithBlock({
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            
                            
                        } else {
                            
                        }
                    })
                    
                   // item.saveEventually()
                    
                    
                    
                }
            }
            
        //})
        // END OF DISPATCH
        
    }
    
    
    
    
  
    
    
    func createnewitem(list: String) {
        
        let todoitem = PFObject(className:"toDoItems")
        let uuid = NSUUID().UUIDString
        let itemuuid = "todoitem\(uuid)"
        
        todoitem["itemUUID"] = itemuuid
        todoitem["todoitemname"] = caption.text
        todoitem["todoitemnote"] = text.text
        
        if priorityswitcher.on {
            todoitem["isImportant"] = true
        } else {
            todoitem["isImportant"] = false
        }
        
        let date = NSDate()
        
        todoitem["creationDate"] = date
        todoitem["updateDate"] = date
        
        todoitem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        todoitem["BelongsToUser"] = PFUser.currentUser()!.objectId!
        todoitem["ItemsList"] = list//currentlist
        
        todoitem["isChecked"] = false
        
        todoitem["isDeleted"] = false
        
        //create new object
        let id = itemuuid
        let name = caption.text
        let note = text.text
        var importance = Bool()
        if priorityswitcher.on {
            importance = true
        } else {
            importance = false
        }
        let check = false
        
        //page 87 of Pro Design Patterns
        
        let newtodoitem: toDoItem = toDoItem(itemid:id,itemname:name!,itemnote:note,itemimportant:importance, ischecked:check)
        
        toDoItems.append(newtodoitem)
        
        
        todoitem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                
                print("saved item")
                
            } else {
                print("no id found")
            }
        })
        
        
        // todoitem.saveEventually()
        /* {
        (success: Bool, error: NSError?) -> Void in
        if (success) {
        
        } else {
        
        }
        }
        */
        
        
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        /*if existingitem == true {
        
        retrieveexistingitem(currentitem)
        
        } else {
        
        priorityswitcher.on = false
        
        }*/
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//(1.0)
        )
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    
    @IBOutlet var textheight: NSLayoutConstraint!
    
    
    @IBOutlet var cancelb: UIButton!
    
    
    @IBOutlet var doneb: UIButton!
    
    let closepadimage = UIImage(named: "ClosePad")!
    
    
    func closetextview(sender: UIButton) {
        
        text.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelb.layer.borderWidth = 1
        cancelb.layer.borderColor = UIColorFromRGB(0xF23D55).CGColor
        cancelb.layer.cornerRadius = 8
        
        
        doneb.layer.cornerRadius = 8
      //  if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
        
       // if UIScreen.mainScreen().sizeType == .iPhone4 {
        
           if UIScreen.mainScreen().nativeBounds.height == 960 {
            text.frame.size.height = 110
            textheight.constant = 110
            
        }
        
        let toolFrame = CGRectMake(0, 0, self.view.frame.size.width, 46);
        let toolView: UIView = UIView(frame: toolFrame);
        
        let closepadframe: CGRect = CGRectMake(self.view.frame.size.width - 66, 2, 56, 42); //size &
        let closepad: UIButton = UIButton(frame: closepadframe);
        closepad.setImage(closepadimage, forState: UIControlState.Normal)
        toolView.addSubview(closepad);
        closepad.addTarget(self, action: "closetextview:", forControlEvents: UIControlEvents.TouchDown);
        
        text.inputAccessoryView = toolView
        
        
        //caption.layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
        
        caption.delegate = self
        
        text.delegate = self
        
        caption.leftTextMargin = 5
        
        text.layer.cornerRadius = 4
        caption.layer.cornerRadius = 4
        
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        caption.layer.borderWidth = 1
        caption.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        /*
        let visuaEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        visuaEffectView.frame = self.view.bounds
        visuaEffectView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        visuaEffectView.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.view.addSubview(visuaEffectView)
        */
        /*
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        borderView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.view.bringSubviewToFront(borderView)
        
        borderView.layer.borderWidth = 1
        
        borderView.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        */
        
       
        
        
        
        borderView.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
      
        
        self.view.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        
        if existingitem == true {
            
            print(currentitem)
            
            retrieveexistingitem(currentitem)
            
        } else {
            
            priorityswitcher.on = false
            caption.text = ""
            text.text = ""
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "todoitemreminder" {
            
            let popoverViewController = segue.destinationViewController as! ReminderPopover//UIViewController
            
            
           // popoverViewController.preferredContentSize = CGSize(width: 300, height: 320)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.todocaption = caption.text!
            popoverViewController.senderVC = "ToDoItem"
            
            //popoverViewController.delegate = self
            
        }
        
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
