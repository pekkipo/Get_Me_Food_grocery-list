//
//  ListOptionsPopover.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 01/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit

protocol OptionsPopupDelegate
{
    //func catsandcurrencychange(unit: String, quantity: String)
    func popshowcategories(show: Bool)
    func changecodeandsymbol(newcode: String, newsymbol: String)
    func changecolor(code: String)
    func uncheckall()
}

class ListOptionsPopover: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    /*
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
*/
    
    var delegate: OptionsPopupDelegate?
    
    var listtoupdate = String()
    
    var senderVC = String()
    /*
    func displayInfoAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "plus.png")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "BACK", color: UIColorFromHex(0x9b59b6, alpha: 1), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addAction(closeCallback)
    }
    
    func closeCallback() {
        print("Closed")
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
    
    
    @IBOutlet var picker: UIPickerView!
    
    var symbol = String()
    var code = String()
    var showcats = Bool()
    
   
    @IBAction func cancelbutton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet var currencylabel: UILabel!
    
    
    @IBAction func done(sender: AnyObject) {
        
        if senderVC == "ShopList" {
        
        delegate?.changecodeandsymbol(code, newsymbol: symbol)
        dismissViewControllerAnimated(true, completion: nil)
        
        } else if senderVC == "AllListsVC" {
            
            print(listtoupdate)
            
            let query = PFQuery(className:"shopLists")
            
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
                    var currencyarray = [String]()
                    currencyarray.append(self.code)
                    currencyarray.append(self.symbol)
                    shopList["CurrencyArray"] = currencyarray
                    shopList["ShowCats"] = self.showcats
                    shopList.pinInBackground()
                    //shopList.saveEventually()
                    


                }
                
            }
            
            
            if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                UserShopLists[foundshoplist].listcategories = showcats
                UserShopLists[foundshoplist].listcurrency = [code,symbol]
                if self.colorchanged == true {
                UserShopLists[foundshoplist].listcolorcode = colorcode
                }
                
            }
            
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                UserLists[foundlist].listcategories = showcats
                UserLists[foundlist].listcurrency = [code,symbol]
                if self.colorchanged == true {
                UserLists[foundlist].listcolorcode = colorcode
                }
                
            }
            
            if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                UserFavLists[foundfavlist].listcategories = showcats
                UserFavLists[foundfavlist].listcurrency = [code,symbol]
                if self.colorchanged == true {
                UserFavLists[foundfavlist].listcolorcode = colorcode
                }
                
            }
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
   
    
    @IBOutlet var showcatsoutlet: UIButton!
    
  
    
    @IBOutlet var uncheckalloutlet: UIButton!
    
   
    @IBAction func uncheckaction(sender: AnyObject) {
        
        
        
        if senderVC == "AllListsVC" {
            
            print(listtoupdate)
         
                pause()
                
                
                let query = PFQuery(className:"shopItems")
                query.fromLocalDatastore()
                // querynew.getObjectInBackgroundWithId(itemtocheck) {
                query.whereKey("ItemsList", equalTo: listtoupdate)
                query.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        
                        
                        
                        if let listitems = objects as? [PFObject] {
                            
                            
                            for object in listitems {
                                
                                object["isChecked"] = false
                                
                                object.pinInBackground()
                            }
                            
                            self.restore()
                             //JSSAlertView().show(self, title: "Done!")
                        }
                        
                        
                        
                    } else {
                        // Log details of the failure
                         self.restore()
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
                
            
            
        } else if senderVC == "ShopList" {
            
            delegate!.uncheckall()
        }
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
    }
    
    
 
    @IBAction func showcatsaction(sender: AnyObject) {
        
        if showcats == false {
            
            showcats = true
            
            self.showcatsoutlet.setTitle(NSLocalizedString("hidecats", comment: ""), forState: UIControlState.Normal)
            
             // self.showcatsoutlet.titleLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
           // showcatsoutlet.titleLabel!.textColor = UIColorFromRGB(0xF23D55)
           // showcatsoutlet.layer.borderWidth = 1
           // showcatsoutlet.layer.borderColor = UIColorFromRGB(0xF23D55).CGColor
            
            //self.showcatsoutlet.setImage(UIImage(named: "HideCatsButton")!, forState: UIControlState.Normal)
            
            
        } else {
            
            showcats = false
            
            showcatsoutlet.setTitle(NSLocalizedString("showcats", comment: ""), forState: UIControlState.Normal)
            
            //showcatsoutlet.titleLabel!.textColor = UIColorFromRGB(0x61C791)
           // showcatsoutlet.layer.borderWidth = 1
           // showcatsoutlet.layer.borderColor = UIColorFromRGB(0x61C791).CGColor
            
            // self.showcatsoutlet.setImage(UIImage(named: "ShowCatsButton")!, forState: UIControlState.Normal)
        }
        if senderVC == "ShopList" {
        delegate!.popshowcategories(showcats)
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
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//(1.0)
        )
    }
    
    
    ///////// COLOR CODER PART
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
    
    var colorchanged : Bool = false
    
    
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
    
    /////////////
    
    
    override func viewWillAppear(animated: Bool) {
        currencylabel.text = "\(code) - \(symbol)"
        
        if showcats == false {
            
            //self.showcatsoutlet.setTitle("Show categories", forState: UIControlState.Normal)
            
            
            showcatsoutlet.setTitle(NSLocalizedString("showcats", comment: ""), forState: UIControlState.Normal)
            /*
            showcatsoutlet.titleLabel!.textColor = UIColorFromRGB(0x61C791)
            showcatsoutlet.layer.borderWidth = 1
            showcatsoutlet.layer.borderColor = UIColorFromRGB(0x61C791).CGColor
            */
        } else {
            
            // self.showcatsoutlet.setTitle("Hide categories", forState: UIControlState.Normal)
            
            showcatsoutlet.setTitle(NSLocalizedString("hidecats", comment: ""), forState: UIControlState.Normal)
            
            // self.showcatsoutlet.titleLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
           
        }
        
        if colorcode == red {
            
            colorcode = red
            redcolor.alpha = 1
            darkgreencolor.alpha = 0.6
            lightgreencolor.alpha = 0.6
            yellowcolor.alpha = 0.6
            blackcolor.alpha = 0.6
            greycolor.alpha = 0.6
            goldcolor.alpha = 0.6
        } else if colorcode == yellow {
            
            colorcode = yellow
            redcolor.alpha = 0.6
            darkgreencolor.alpha = 0.6
            lightgreencolor.alpha = 0.6
            yellowcolor.alpha = 1
            blackcolor.alpha = 0.6
            greycolor.alpha = 0.6
            goldcolor.alpha = 0.6
            
        } else if colorcode == dgreen {
            
            colorcode = dgreen
            redcolor.alpha = 0.6
            darkgreencolor.alpha = 1
            lightgreencolor.alpha = 0.6
            yellowcolor.alpha = 0.6
            blackcolor.alpha = 0.6
            greycolor.alpha = 0.6
            goldcolor.alpha = 0.6
            
        } else if colorcode == lgreen {
            
            colorcode = lgreen
            redcolor.alpha = 0.6
            darkgreencolor.alpha = 0.6
            lightgreencolor.alpha = 1
            yellowcolor.alpha = 0.6
            blackcolor.alpha = 0.6
            greycolor.alpha = 0.6
            goldcolor.alpha = 0.6
            
        } else if colorcode == black {
            
            colorcode = black
            redcolor.alpha = 0.6
            darkgreencolor.alpha = 0.6
            lightgreencolor.alpha = 0.6
            yellowcolor.alpha = 0.6
            blackcolor.alpha = 1
            greycolor.alpha = 0.6
            goldcolor.alpha = 0.6
            
        } else if colorcode == grey {
            
            colorcode = grey
            redcolor.alpha = 0.6
            darkgreencolor.alpha = 0.6
            lightgreencolor.alpha = 0.6
            yellowcolor.alpha = 0.6
            blackcolor.alpha = 0.6
            greycolor.alpha = 1
            goldcolor.alpha = 0.6
            
        } else if colorcode == gold {
            
            colorcode = gold
            redcolor.alpha = 0.6
            darkgreencolor.alpha = 0.6
            lightgreencolor.alpha = 0.6
            yellowcolor.alpha = 0.6
            blackcolor.alpha = 0.6
            greycolor.alpha = 0.6
            goldcolor.alpha = 1
            
        }






    }
    
    
    @IBOutlet var setreminderpop: UIButton!
    
    
    @IBOutlet var addedindicator: UIView!
    
    
    @IBOutlet var cancelb: UIButton!
    
    
    @IBOutlet var doneb: UIButton!
    
    
    @IBOutlet var tableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return ((ListsNames.count) - (ListsNames.count - 4))
        if section == 0 {
            return commoncurrencies.count
        } else {
        return currencies.count
        }
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return NSLocalizedString("commoncur", comment: "")
        } else if section == 1 {
            return NSLocalizedString("allcur", comment: "")
        } else {
        return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "curcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! currencycellTableViewCell
        
        if indexPath.section == 0 {
            cell.curlabel.text = "\(commoncurrencies[indexPath.row][0]) (\(commoncurrencies[indexPath.row][1]))"
        } else {
            cell.curlabel.text = "\(currencies[indexPath.row][0]) (\(currencies[indexPath.row][1]))"
        }
        
      //  cell.curlabel.text = "\(currencies[indexPath.row][0]) (\(currencies[indexPath.row][1]))"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            symbol = commoncurrencies[indexPath.row][1]
            code = commoncurrencies[indexPath.row][0]
            
            currencylabel.text = "\(code) (\(symbol))"
        } else {
            symbol = currencies[indexPath.row][1]
            code = currencies[indexPath.row][0]
            
            currencylabel.text = "\(code) (\(symbol))"
        }
        /*
        symbol = currencies[indexPath.row][1]
        code = currencies[indexPath.row][0]
        
        currencylabel.text = "\(code) (\(symbol))"
        */
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if senderVC == "AllListsVC" {
            
            let visuaEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
            visuaEffectView.frame = self.view.bounds
            
            visuaEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]//.FlexibleWidth | .FlexibleHeight
            visuaEffectView.translatesAutoresizingMaskIntoConstraints = true//setTranslatesAutoresizingMaskIntoConstraints(true)
            self.view.addSubview(visuaEffectView)
            
        }
        */
        
        
        cancelb.layer.borderWidth = 1
        cancelb.layer.borderColor = UIColorFromRGB(0xF23D55).CGColor
        cancelb.layer.cornerRadius = 8
        
        
        doneb.layer.cornerRadius = 8
        
        
        addedindicator.alpha = 0
        addedindicator.layer.cornerRadius = 8
        addedindicator.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 1)
        
        self.view.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 0.5)
        
        uncheckalloutlet.layer.borderWidth = 1
        uncheckalloutlet.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        
        
        showcatsoutlet.layer.borderWidth = 1
        showcatsoutlet.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        
      //  self.picker.delegate = self
     //   self.picker.dataSource = self
        //self.currencybuttonoutlet.setTitle(String(stringInterpolationSegment: symbol), forState: UIControlState.Normal)
        /*
        currencylabel.text = "\(code) - \(symbol)"
        
        if showcats == false {
            
            //self.showcatsoutlet.setTitle("Show categories", forState: UIControlState.Normal)
            
            
            self.showcatsoutlet.setTitle("Show categories", forState: UIControlState.Normal)
            
            self.showcatsoutlet.titleLabel!.textColor = UIColorFromRGB(0x61C791)
            
            showcatsview.layer.borderColor = UIColorFromRGB(0x61C791).CGColor
            
        } else {
            
           // self.showcatsoutlet.setTitle("Hide categories", forState: UIControlState.Normal)
            
            self.showcatsoutlet.setTitle("Hide categories", forState: UIControlState.Normal)
            
            // self.showcatsoutlet.titleLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
            self.showcatsoutlet.titleLabel!.textColor = UIColorFromRGB(0xF23D55)
            showcatsview.layer.borderColor = UIColorFromRGB(0xF23D55).CGColor
        }
*/
        
        
        
        //view.layer.cornerRadius = 10
        /*
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        */
        //view.alpha = 0.70
        
        view.backgroundColor = UIColorFromRGB(0xFAFAFA)
       // view.layer.borderWidth = 1
       // view.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "reminderpopover" {
            
            let popoverViewController = segue.destinationViewController as! ReminderPopover//UIViewController
            
            
           // popoverViewController.preferredContentSize = CGSize(width: 300, height: 320)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.senderVC = "ShopOptions"
            
            
            //popoverViewController.delegate = self
            
        }
    
    }
    
    /*
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns number of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return currencies.count
    }
    
    
    
    // Return the title of each row in your picker ... In my case that will be the profile name or the username string
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return currencies[row][1]//[1]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        symbol = currencies[row][1]
        code = currencies[row][0]


        
        currencylabel.text = "\(code) (\(symbol))"
        
        //delegate?.changecodeandsymbol(code, newsymbol: symbol)
        
        
    }
    */
    ///// END ALERT CODE


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
