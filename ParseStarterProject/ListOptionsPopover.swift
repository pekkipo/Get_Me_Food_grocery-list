//
//  ListOptionsPopover.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 01/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit
import Foundation

protocol OptionsPopupDelegate
{
    //func catsandcurrencychange(unit: String, quantity: String)
    func popshowcategories(show: Bool)
    func changecodeandsymbol(newcode: String, newsymbol: String)
    func changecolor(code: String)
    func uncheckall()
}



class ListOptionsPopover: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    

    
    var delegate: OptionsPopupDelegate?
    
    var listtype = String()
    
    var listtoupdate = String()
    
    var senderVC = String()

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
            
            
            if senderVC == "ToDoList" {
            
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
            
            } else {
                // if to do list
                
                
                if self.colorchanged == true {
                    
                    
                    let query = PFQuery(className:"toDoLists")
                    
                    query.fromLocalDatastore()
                    query.whereKey("listUUID", equalTo: listtoupdate)
                    
                    query.getFirstObjectInBackgroundWithBlock() {
                        (shopList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let shopList = shopList {
                            
                                shopList["ListColorCode"] = self.colorcode

                            shopList.pinInBackground()

                        }
                        
                    }
                    
                    
                
                if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                    
                    
                    
                        UserShopLists[foundtodolist].listcolorcode = colorcode
                    
                    
                }
                
                if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                    
                    
                    
                        UserLists[foundlist].listcolorcode = colorcode
                    
                    
                }
                
                if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                    
                    
                        UserFavLists[foundfavlist].listcolorcode = colorcode
                    
                    
                }
            }
            
            }
        
           
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
    var gold:String = "A2AF36"
    var black:String = "2A2F36"
    var grey:String = "838383"
    var magenta:String = "1EB2BB"
    var lgreen:String = "61C791"
    var lightmagenta: String = "7FC2C6"
    var pink: String = "E88996"
    var orange: String = "E18C16"
    var violet:String = "7D3169"
    var darkred:String = "713D3D"
   

    
    @IBOutlet var redcolor: UIButton!
    @IBOutlet var darkgreencolor: UIButton!
    @IBOutlet var lightgreencolor: UIButton!
    @IBOutlet var blackcolor: UIButton!
    @IBOutlet var greycolor: UIButton!
    @IBOutlet var goldcolor: UIButton!
    @IBOutlet var magentacolor: UIButton!
    @IBOutlet var lightmagentacolor: UIButton!
   
    @IBOutlet var pinkcolor: UIButton!
    @IBOutlet var orangecolor: UIButton!
    @IBOutlet var violetcolor: UIButton!
    @IBOutlet var darkredcolor: UIButton!
    
    
    var colorchanged : Bool = false
    
    
    @IBAction func redaction(sender: UIButton) {
        
        colorcode = red
        
        choosethecolor(sender)

        colorchanged = true
        
        delegate?.changecolor(colorcode)
        
        
    }
    
    @IBAction func darkgreenaction(sender: UIButton) {
        
        colorcode = dgreen
        
        choosethecolor(sender)

        colorchanged = true
        
        delegate?.changecolor(colorcode)
        
    }
    
    
    @IBAction func lightgreenaction(sender: UIButton) {
        
        colorcode = lgreen
        
        choosethecolor(sender)

        colorchanged = true
        
        delegate?.changecolor(colorcode)
        
    }
    
  
    @IBAction func violetaction(sender: UIButton) {
        
        colorcode = violet
        
        choosethecolor(sender)

        colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    
    @IBAction func blackaction(sender: UIButton) {
        
        colorcode = black
        
        choosethecolor(sender)

        colorchanged = true
        
        delegate?.changecolor(colorcode)
        
    }
    
    @IBAction func greyaction(sender: UIButton) {
        
        colorcode = grey
        
        choosethecolor(sender)

        colorchanged = true
        
        delegate?.changecolor(colorcode)
        
    }
    
    
    @IBAction func goldaction(sender: UIButton) {
        
        colorcode = gold
        
        choosethecolor(sender)
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)
        
    }
    
    
    @IBAction func magentaaction(sender: UIButton) {
        
        colorcode = magenta
        
        choosethecolor(sender)
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    
    @IBAction func lightmagentaaction(sender: UIButton) {
        
        colorcode = lightmagenta
        
        choosethecolor(sender)
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    

    @IBAction func pinkaction(sender: UIButton) {
        
        colorcode = pink
        
        choosethecolor(sender)
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    @IBAction func orangeaction(sender: UIButton) {
        
        colorcode = orange
        
        choosethecolor(sender)
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    @IBAction func darkredaction(sender: UIButton) {
        
        colorcode = darkred
        
        choosethecolor(sender)
        
        colorchanged = true
        
        delegate?.changecolor(colorcode)
    }
    
    
    
    
    /////////////
    
    var arrayofbuttonoutlets = [UIButton]()
    
    func setroundness() {
        for button in arrayofbuttonoutlets {
            button.layer.cornerRadius = 8

        }
    }
    
    func choosethecolor(button: UIButton) {
        
        for b in arrayofbuttonoutlets {
            if b == button {
                b.alpha = 1.0
            } else {
                b.alpha = 0.5
            }
        }
        
        colorchanged = true
        
        if senderVC == "ShopList" {
        delegate?.changecolor(colorcode)
        } else if senderVC == "ToDoList" {
        delegate?.changecolor(colorcode)
        } else if senderVC == "AllListsVC" {
            
            if listtype == "Shop" {
            
            let query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            query.whereKey("listUUID", equalTo: listtoupdate)
            query.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                } else if let shopList = shopList {

                        shopList["ListColorCode"] = self.colorcode

                    shopList.pinInBackground()
   
                }
                
            }
            
            
            if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {

                    UserShopLists[foundshoplist].listcolorcode = colorcode

                
            }
            
            } else if listtype == "ToDo" {
                
                let query = PFQuery(className:"toDoLists")
                query.fromLocalDatastore()
                query.whereKey("listUUID", equalTo: listtoupdate)
                query.getFirstObjectInBackgroundWithBlock() {
                    (toDoList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                    } else if let toDoList = toDoList {
                        
                        toDoList["ListColorCode"] = self.colorcode
                        
                        toDoList.pinInBackground()
                        
                    }
                    
                }
                
                
                if let foundtodolist = UserToDoLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                    
                    UserToDoLists[foundtodolist].listcolorcode = colorcode
                    
                    
                }

                
                
            }
        
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {

                    UserLists[foundlist].listcolorcode = colorcode
                
                
            }
            
            if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {

                    UserFavLists[foundfavlist].listcolorcode = colorcode
              
                
            }
            
        }
    }
    
    func setcurrentcolor(button: UIButton) {
        for b in arrayofbuttonoutlets {
            if b == button {
                b.alpha = 1.0
            } else {
                b.alpha = 0.5
            }
        }

    }
    
    
    override func viewWillAppear(animated: Bool) {
        
       
        if listtype == "Shop" {
        currencylabel.text = "\(code) - \(symbol)"
        }
        
        
        
        if colorcode == red {
            colorcode = red
            setcurrentcolor(redcolor)
            
        } else if colorcode == dgreen {
            
            colorcode = dgreen
            setcurrentcolor(darkgreencolor)
        } else if colorcode == gold {
            
            colorcode = gold
            setcurrentcolor(goldcolor)
            
        } else if colorcode == black {
            
            colorcode = black
            setcurrentcolor(blackcolor)
            
        } else if colorcode == grey {
            
            colorcode = grey
            setcurrentcolor(greycolor)
            
        } else if colorcode == magenta {
            
            colorcode = magenta
            setcurrentcolor(magentacolor)
            
        } else if colorcode == lgreen {
            
            colorcode = lgreen
            setcurrentcolor(lightgreencolor)
            
        } else if colorcode == lightmagenta {
            
            colorcode = lightmagenta
            setcurrentcolor(lightmagentacolor)
            
        } else if colorcode == pink {
            
            colorcode = pink
            setcurrentcolor(pinkcolor)
            
        } else if colorcode == orange {
            
            colorcode = orange
            setcurrentcolor(orangecolor)
            
        } else if colorcode == violet {
            
            colorcode = violet
            setcurrentcolor(violetcolor)
            
        } else if colorcode == darkred {
            
            colorcode = darkred
            setcurrentcolor(darkredcolor)
            
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
    
  
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView!
    {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 30))
        
            headerView.backgroundColor = UIColorFromRGB(0xFFFFFF)//UIColor.clearColor()
        
        let headerLabel = UILabel(frame: CGRectMake(12, 8, tableView.frame.width, 30))
        headerLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        headerLabel.textColor = UIColorFromRGB(0x31797D)
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "curcell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! currencycellTableViewCell
        
        if indexPath.section == 0 {
            cell.curlabel.text = "\(commoncurrencies[indexPath.row][0]) (\(commoncurrencies[indexPath.row][1]))"
            
            
                if commoncurrencies[indexPath.row][0] == code {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
            }
            
            
        } else {
            cell.curlabel.text = "\(currencies[indexPath.row][0]) (\(currencies[indexPath.row][1]))"
            
            if currencies[indexPath.row][0] == code {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }

            
        }
        
        
      //  cell.curlabel.text = "\(currencies[indexPath.row][0]) (\(currencies[indexPath.row][1]))"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // let ItemCellIdentifier = "NewListItem"
        // let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ItemShopListCell
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! currencycellTableViewCell
        cell.tintColor = UIColorFromRGB(0x31797D)
        
        if indexPath.section == 0 {
            symbol = commoncurrencies[indexPath.row][1]
            code = commoncurrencies[indexPath.row][0]
            
            currencylabel.text = "\(code) (\(symbol))"
            cell.accessoryType = .Checkmark
            
            
        } else {
            symbol = currencies[indexPath.row][1]
            code = currencies[indexPath.row][0]
            
            currencylabel.text = "\(code) (\(symbol))"
            cell.accessoryType = .Checkmark
        }
        
        if senderVC == "ShopList" {
            
        delegate?.changecodeandsymbol(code, newsymbol: symbol)
            
        } else if senderVC == "AllListsVC" {

            let query = PFQuery(className:"shopLists")
            query.fromLocalDatastore()
            query.whereKey("listUUID", equalTo: listtoupdate)
            query.getFirstObjectInBackgroundWithBlock() {
                (shopList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let shopList = shopList {

                    var currencyarray = [String]()
                    currencyarray.append(self.code)
                    currencyarray.append(self.symbol)
                    shopList["CurrencyArray"] = currencyarray
                    shopList.pinInBackground()

                }
                
            }

            if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
               
                UserShopLists[foundshoplist].listcurrency = [code,symbol]
                
            }
            
            if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {
                
                UserLists[foundlist].listcurrency = [code,symbol]
                
            }
            
            if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(listtoupdate) {

                UserFavLists[foundfavlist].listcurrency = [code,symbol]

            }
            
        }
        
        tableView.reloadData()

    }

    
    @IBOutlet var worldpic: UIImageView!
    @IBOutlet var chooseccy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        arrayofbuttonoutlets  = [redcolor, darkgreencolor, goldcolor, blackcolor, greycolor, magentacolor, lightgreencolor, lightmagentacolor, pinkcolor, orangecolor, violetcolor, darkredcolor]
        
         setroundness()
        
        print(senderVC)
        
        addedindicator.alpha = 0
        addedindicator.layer.cornerRadius = 8
        addedindicator.backgroundColor = UIColorFromRGBalpha(0x31797D, alp: 1)

        view.backgroundColor = UIColorFromRGB(0xFAFAFA)

        if listtype == "ToDo" {
            tableView.hidden = true
            worldpic.hidden = true
            chooseccy.hidden = true
            currencylabel.hidden = true
        } else {
            tableView.hidden = false
            worldpic.hidden = false
            chooseccy.hidden = false
            currencylabel.hidden = false
        }
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
            
            popoverViewController.modalPresentationStyle = .OverCurrentContext
            
            
            if senderVC == "ShopList" {
            
            popoverViewController.senderVC = "ShopOptions"
                
            } else if senderVC == "ToDoList" {
               popoverViewController.senderVC = "ToDoOptions"
            } else if senderVC == "AllListsVC" {
                
                if listtype == "Shop" {
                    popoverViewController.senderVC = "ShopOptions"
                } else if listtype == "ToDo" {
                    popoverViewController.senderVC = "ToDoOptions"
                } else {
                    popoverViewController.senderVC = "ToDoOptions"
                }
            }
            
            
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
