//
//  AddItemViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 23/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation
import ASHorizontalScrollView


var customcategories = [Category]()


var catalogcategories = [
    Category(catId:"DefaultOthers",catname:NSLocalizedString("catothers", comment: ""),catimage:UIImage(named: "ciothers")!,isCustom:false),
    Category(catId:"DefaultVegetables",catname:NSLocalizedString("catvegs", comment: ""),catimage:UIImage(named: "civegetables")!,isCustom:false),
    Category(catId:"DefaultFruits",catname:NSLocalizedString("catfruits", comment: ""),catimage:UIImage(named: "cifruits")!,isCustom:false),
    Category(catId:"DefaultDairy",catname:NSLocalizedString("catdairy", comment: ""),catimage:UIImage(named: "cidairy")!,isCustom:false),
    Category(catId:"DefaultMeat",catname:NSLocalizedString("catmeat", comment: ""),catimage:UIImage(named: "cimeat")!,isCustom:false),
    Category(catId:"DefaultSeafood",catname:NSLocalizedString("catseafood", comment: ""),catimage:UIImage(named: "ciseafood")!,isCustom:false),
    Category(catId:"DefaultBakery",catname:NSLocalizedString("catbakery", comment: ""),catimage:UIImage(named: "cibakery")!,isCustom:false),
    Category(catId:"DefaultSnacks",catname:NSLocalizedString("catsnacks", comment: ""),catimage:UIImage(named: "cisnacks")!,isCustom:false),
    Category(catId:"DefaultBeverages",catname:NSLocalizedString("catbeverages", comment: ""),catimage:UIImage(named: "cibeverages")!,isCustom:false),
    Category(catId:"DefaultAlcohol",catname:NSLocalizedString("catalcohol", comment: ""),catimage:UIImage(named: "cialcohol")!,isCustom:false),
    Category(catId:"DefaultCereals",catname:NSLocalizedString("catcereals", comment: ""),catimage:UIImage(named: "cibreakfast")!,isCustom:false),
    Category(catId:"DefaultSweets",catname:NSLocalizedString("catsweets", comment: ""),catimage:UIImage(named: "cisweets")!,isCustom:false),
    Category(catId:"DefaultCondiments",catname:NSLocalizedString("catcondiments", comment: ""),catimage:UIImage(named: "cicondiments")!,isCustom:false),
    Category(catId:"DefaultCanned",catname:NSLocalizedString("catcanned", comment: ""),catimage:UIImage(named: "cicanned")!,isCustom:false),
    Category(catId:"DefaultPasta",catname:NSLocalizedString("catpasta", comment: ""),catimage:UIImage(named: "cipasta")!,isCustom:false),
    Category(catId:"DefaultGrains",catname:NSLocalizedString("catgrains", comment: ""),catimage:UIImage(named: "cigrains")!,isCustom:false),
    Category(catId:"DefaultFrozen",catname:NSLocalizedString("catfrozen", comment: ""),catimage:UIImage(named: "cifrozen")!,isCustom:false),
    Category(catId:"DefaultBaby",catname:NSLocalizedString("catbaby", comment: ""),catimage:UIImage(named: "cibaby")!,isCustom:false),
    Category(catId:"DefaultPets",catname:NSLocalizedString("catpets", comment: ""),catimage:UIImage(named: "cipets")!,isCustom:false),
    Category(catId:"DefaultPersonal",catname:NSLocalizedString("catpersonalcare", comment: ""),catimage:UIImage(named: "cipersonal")!,isCustom:false),
    Category(catId:"DefaultPharmacy",catname:NSLocalizedString("catpharmacy", comment: ""),catimage:UIImage(named: "cimedications")!,isCustom:false),
    Category(catId:"DefaultHousehold",catname:NSLocalizedString("cathousehold", comment: ""),catimage:UIImage(named: "cihousehold")!,isCustom:false),
    Category(catId:"DefaultTobacco",catname:NSLocalizedString("cattobacco", comment: ""),catimage:UIImage(named: "citobacco")!,isCustom:false),
    
    
    
    
    
]

protocol RefreshListDelegate
{
    //func choosecategory(category:Category)
    func refreshtable()
}

protocol RefreshAddWithOptions
{
    //func choosecategory(category:Category)
    func refreshaddoptions()
}

var units : [[String]] = [
    [NSLocalizedString("units", comment: ""),NSLocalizedString("un", comment: "")],
    [NSLocalizedString("pieces", comment: ""),NSLocalizedString("pcs", comment: "")],
    [NSLocalizedString("packages", comment: ""),NSLocalizedString("packs", comment: "")],
    [NSLocalizedString("kilograms", comment: ""),NSLocalizedString("kg", comment: "")],
    [NSLocalizedString("grams", comment: ""),NSLocalizedString("g", comment: "")],
    [NSLocalizedString("liters", comment: ""),NSLocalizedString("L", comment: "")],
    [NSLocalizedString("milliliters", comment: ""),NSLocalizedString("ml", comment: "")],
    [NSLocalizedString("flonz", comment: ""),NSLocalizedString("floz", comment: "")],
    [NSLocalizedString("ounces", comment: ""),NSLocalizedString("oz", comment: "")],
    [NSLocalizedString("pounds", comment: ""),NSLocalizedString("lb", comment: "")],
    [NSLocalizedString("gallons", comment: ""),NSLocalizedString("gal", comment: "")],
    [NSLocalizedString("meters", comment: ""),NSLocalizedString("m", comment: "")],
    [NSLocalizedString("centimeters", comment: ""),NSLocalizedString("cm", comment: "")],
    [NSLocalizedString("inches", comment: ""),"\""],
    [NSLocalizedString("dozens", comment: ""),NSLocalizedString("dz", comment: "")],
]




class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIPopoverPresentationControllerDelegate, CategoryPopupDelegate, ImagesPopupDelegate, UITextFieldDelegate, UITextViewDelegate, ManageCatsDelegate {

    
    var withoptionsdelegete : RefreshAddWithOptions?
    
    var shopdelegate : RefreshListDelegate?
    
    var sendercontroller = String()
    
    
    func handlecustomcat(added: Bool) {

        if added == true {
        horizontalScrollView.removeAllItems()
        categoriessetup()
        
        var lastcatitem : Int = catalogcategories.count - 1
        var vel: CGPoint = CGPointMake(horizontalScrollView.finditem(lastcatitem - 1, inScrollView: horizontalScrollView), 0.0)
        horizontalScrollView.contentOffset = vel
        }
        
        // Mark the current cat!
          if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf((self.itemcategory!.catId)) {
        
        for view in horizontalScrollView.subviews {

            if view.tag == foundcategory {
                
                view.tintColor = UIColorFromRGB(0x31797D)
                for subview in view.subviews {
                    subview.tintColor = UIColorFromRGB(0x31797D)
                    //if let labelview : UILabel = subview as! UILabel {
                    if subview == subview as? UILabel {
                        // that's how one finds out the type
                        (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                    }
                }
                view.layer.borderWidth = 1
                view.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                
                break;
            }
            // }
        }
    }
    

    }
    
    
    func getscaninfo() {
    
        //set name here
    }
    
    
    
    @IBOutlet var borderview: UIView!
    
    var existingitem = Bool()
    var currentitem = String()
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    ///
    var itemId = String()
    var itemName = String()
    var itemNote = String()
    var itemQty = String()
    var itemPrice = Double()
    var itemImage = PFFile()
    var itemUnit = String()
    var itemcategory:Category?
    var itemcategoryUUID = String()
    var itemiscatalog = Bool()
    var itemcategoryname = String()
    var itemoneunitprice = Double()
    var itemisfavourite = Bool()
    var itemperunit = String()
    
    //var itemisdefaultpict = Bool()
    //var itemoriginalindefaults = String()
    
    var imagePath = String()
    
    var imageToLoad = UIImage()
    
    var catimageToLoad = UIImage()
    
    var getcurrentlist = String()
    
    //var arrayofitems = [PFObject]()
    
    //var arrayofobjects = [AnyObject]()
    
    var arrayofItemsNames = [String]()
    
   
    
    //var units = ["","pieces","Dozens","kilograms", "grams", "liters", "milliliters","fluid ounces", "ounces", "pounds","gallons","meters","centimeters","inches"]
    /*
    var units : [[String]] = [
        [NSLocalizedString("units", comment: ""),NSLocalizedString("un", comment: "")],
        [NSLocalizedString("pieces", comment: ""),NSLocalizedString("pcs", comment: "")],
        [NSLocalizedString("dozens", comment: ""),NSLocalizedString("dz", comment: "")],
        [NSLocalizedString("kilograms", comment: ""),NSLocalizedString("kg", comment: "")],
        [NSLocalizedString("grams", comment: ""),NSLocalizedString("g", comment: "")],
        [NSLocalizedString("liters", comment: ""),NSLocalizedString("L", comment: "")],
        [NSLocalizedString("milliliters", comment: ""),NSLocalizedString("ml", comment: "")],
        [NSLocalizedString("flonz", comment: ""),NSLocalizedString("floz", comment: "")],
        [NSLocalizedString("ounces", comment: ""),NSLocalizedString("oz", comment: "")],
        [NSLocalizedString("pounds", comment: ""),NSLocalizedString("lb", comment: "")],
        [NSLocalizedString("gallons", comment: ""),NSLocalizedString("gal", comment: "")],
        [NSLocalizedString("meters", comment: ""),NSLocalizedString("m", comment: "")],
        [NSLocalizedString("centimeters", comment: ""),NSLocalizedString("cm", comment: "")],
        [NSLocalizedString("inches", comment: ""),"\""]
    ]
     */
    //var units = ["","Dozens",""Kg", "g", "l", "pcs"]
    
    var buttontitle = String()
    
    var perbuttontitle = String()
    
    var unit = String()
    
    var number = Int()
    
    var receivedarrayofdicts = [Dictionary<String, AnyObject>]()
    
    var newitemdictionary = Dictionary<String, AnyObject>()
    
    var newitemid = String()
    
    var numberchanged = Int() ?? 0
    
    var numberchangeddouble = Double() ?? 0
    
    var isFavouriteItem = Bool()
    
   // var favimage: UIImage = UIImage()
    //var notfavimage: UIImage = UIImage()
    var favimage = UIImage(named: "ICFavStarActive") //as UIImage!
    var notfavimage = UIImage(named: "ICFavStar") //as UIImage!
    
    var itemtofav = String()

    
    
    @IBOutlet weak var nomatchlabel: UILabel!
    
    
    
    
    @IBOutlet weak var perUnitOutlet: UIButton!
    
    
    @IBAction func addtofavaction(sender: AnyObject) {
        
        
        if isFavouriteItem == true {

       
            
            isFavouriteItem = false
            
        } else {
            
            isFavouriteItem = true
        }
        
        
    }
    
    @IBOutlet weak var stepper: UIStepper!
    


    
    @IBOutlet weak var UnitsButton: UIButton!
   
   
    @IBOutlet var Qfield: UITextField!
    
    
    @IBOutlet weak var QuantityStepper: UIStepper!
  

    
    @IBAction func showUnitsButton(sender: AnyObject) {
        
        showunitsview("unit")
        
    }
    
    
    @IBAction func showPerUnitsPicker(sender: AnyObject) {
        
         showunitsview("perunit")
    }
    
    
   
    
    var itemsDictionary: NSDictionary = NSDictionary()
    
    
    
    @IBOutlet weak var DoneButtonOutlet: UIButton!
    @IBOutlet var itemNameOutlet: CustomTextField!//UITextField!
   
    
    @IBOutlet var itemNoteOutlet: UITextView!
    
    @IBOutlet var itemPriceOutlet: UITextField!
    @IBOutlet var itemImageOutlet: UIImageView!
    //@IBOutlet var totalsumlabel: UILabel!
    
    @IBOutlet var totalsumlabel: UITextField!
    
    
    @IBAction func sumbegin(sender: AnyObject) {
        
        sumline.backgroundColor = UIColorFromRGB(0x31797D)
        totalsumlabel.textColor = UIColorFromRGB(0x31797D)
        totalsumlabel.textInputView.tintColor = UIColorFromRGB(0x31797D)
    }
    
    @IBAction func sumeditchanged(sender: AnyObject) {
        
        if totalsumlabel.text! != "0" && totalsumlabel.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }
   
    }
    
    @IBAction func sumchanged(sender: AnyObject) {
    
        
    
    
    
        if totalsumlabel.text! != "0" && totalsumlabel.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }

    }
    
    @IBAction func sumend(sender: AnyObject) {
        
        if totalsumlabel.text! != "0" && totalsumlabel.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }
    }
    
    
    
    
    @IBAction func DoneButton(sender: AnyObject) {
        
        
        
        if existingitem == false
        {
            detailedItemAdd()
            
            if sendercontroller == "EditWithOptions" {
                
                if((self.withoptionsdelegete) != nil)
                {
                    withoptionsdelegete?.refreshaddoptions()
                    
                    //refreshtable
                    
                }
                 self.dismissViewControllerAnimated(true, completion: nil)
               // performSegueWithIdentifier("gobacktoaddwithoptions", sender: self)
                
                
            } else if sendercontroller == "ShopListCreation" {
                
                if((self.shopdelegate) != nil)
                {
                    shopdelegate?.refreshtable()
                    //refreshtable in shoplist view!
                    
                }
                
               //  self.dismissViewControllerAnimated(true, completion: nil)
               performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
                
            } else {
                
                
                performSegueWithIdentifier("gobacktocreationshoplist", sender: self) // FOR NOW
                
                
            }
            
        }
        else {
        saveexistingitem()
            
            ///SEGUE AND RELOAD DATA STUFF IS WITHIN savex function!
                  }
        
        /*
        if((self.shopdelegate) != nil)
        {
           shopdelegate?.refreshtable()
            //refreshtable in shoplist view!
 
        }
        */
        
        ///// THIS STUF HAVE TO BE PUT WITIN SAVEEXISTINGITEM!
            }
    
    
    
    @IBAction func CancelButton(sender: AnyObject) {
        
        if sendercontroller == "EditWithOptions" {
            
            //performSegueWithIdentifier("gobacktoaddwithoptions", sender: self)
            
            //performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
            
             self.dismissViewControllerAnimated(true, completion: nil)
            
        } else if sendercontroller == "ShopListCreation" {
            
          performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
            
            //performSegueWithIdentifier("gobacktoaddwithoptions", sender: self)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("gobacktocreationshoplist", sender: self) // FOR NOW
            //self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    

    
    
    //IMAGE PART
    
    var chosenPicture = UIImage()
    
    
    @IBOutlet weak var chooseitemimageoutlet: UIButton!
    
    @IBAction func chooseItemImage(sender: AnyObject) {
        /*
        var chosenimage = UIImagePickerController()
        chosenimage.delegate = self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = false
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
        */
        performSegueWithIdentifier("showimagesfromadditem", sender: self)
        
    }
    
    
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        
        itemImageOutlet.image = chosenimage
        
        //chosenPicture = chosenimage
        
        
    }
    

    var isdefaultpicture = Bool()
    var defaultpicturename : String = imagestochoose[0].imagename
    
    func choosecollectionimage(pict: UIImage, defaultpicture: Bool, picturename: String?) {
        
         itemImageOutlet.image = pict
        
         isdefaultpicture = defaultpicture
        if picturename != nil {
         defaultpicturename = picturename!
        } else {
            defaultpicturename = ""
        }
    }

    
    @IBAction func editchangedquantity(sender: AnyObject) {
        
         multiplication()
    }
    
    
    //CUSTOMIZING THE STEPPER
    
    //var value = Int(Qfield.text)
    
    @IBOutlet weak var quantitylabel: UILabel!
    /*
    var getvalue: Int {
        get {return Qfield.text.toInt()!}
    }
    */
    @IBAction func decrement(sender: AnyObject) {

        
        var getvalue: Double {
            // get {return Qfield.text.toInt()!}
          //  get {return (Qfield.text! as NSString).doubleValue}
            get {return Qfield.text!.doubleConverter}
        }
        
        numberchangeddouble = getvalue

        numberchangeddouble -= 1
        //Qfield.text = String(format: "%.2f", (stringInterpolationSegment: numberchangeddouble))
        
       // Qfield.text = String(stringInterpolationSegment: numberchangeddouble)
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        
        
        Qfield.text = formatter.stringFromNumber(numberchangeddouble)
        
       //  Qfield.text = String(format: "%.##", (stringInterpolationSegment: numberchangeddouble))
        multiplication()
    }
    
    @IBAction func increment(sender: AnyObject) {
        //value += 1
        
        
           // (itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
       
        
        var getvalue: Double {
           // get {return Qfield.text.toInt()!}
            //get {return (Qfield.text! as NSString).doubleValue}
            get {return Qfield.text!.doubleConverter}
        } // THIS THING ALLOWS TO SET THE VALUE AND START INCREMENTING FROM IT

        numberchangeddouble = getvalue
        
        numberchangeddouble += 1

        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        
        
        Qfield.text = formatter.stringFromNumber(numberchangeddouble)
        

        
        multiplication()
    }
    

    
    var pricevalue = Double()
    
    var newvalue = Double()
    
    func multiplication() {

        
        var unit =  self.UnitsButton.titleForState(.Normal)
        var perunit = self.perUnitOutlet.titleForState(.Normal)
        
        
        
        //itemPriceOutlet.text!.doubleConverter
        
       // Qfield.text!.doubleConverter
        
        var getvalueofprice: Double {
            // get {return Qfield.text.toInt()!}
            //get {return (itemPriceOutlet.text! as NSString).doubleValue}
            get {return itemPriceOutlet.text!.doubleConverter}
        } // THIS THING ALLOWS TO SET THE VALUE AND START INCREMENTING FROM IT
        
        var getvalue: Double {
            // get {return Qfield.text.toInt()!}
            //get {return (Qfield.text! as NSString).doubleValue}
            get {return Qfield.text!.doubleConverter}
        } // THIS THING ALLOWS TO SET THE VALUE AND START INCREMENTING FROM IT
        
        numberchangeddouble = getvalue
        
        pricevalue = getvalueofprice
        
        //var newvalue = Double()
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9

        if unit == perunit {

            newvalue = numberchangeddouble*pricevalue

            self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
            
            nomatchlabel.hidden = true
        } else if (unit != "") && perunit == "" {
            
            nomatchlabel.hidden = true
            newvalue = numberchangeddouble*pricevalue
            
            self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
            
        } else {
            
                if unit == units[3][1] && perunit == units[4][1] {
                newvalue = (numberchangeddouble)*1000*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[4][1] && perunit == units[3][1] {
                newvalue = (numberchangeddouble)*0.001*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[6][1] {
                newvalue = (numberchangeddouble)*1000*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[6][1] && perunit == units[5][1] {
                newvalue = (numberchangeddouble)*0.001*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[11][1] && perunit == units[12][1] {
                newvalue = (numberchangeddouble)*1000*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[12][1] && perunit == units[11][1] {
                newvalue = (numberchangeddouble)*0.001*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[8][1] {
                newvalue = (numberchangeddouble)*16.000*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[8][1] && perunit == units[9][1] {
                newvalue = (numberchangeddouble)*0.062*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[3][1] {
                newvalue = (numberchangeddouble)*0.453*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[3][1] && perunit == units[9][1] {
                newvalue = (numberchangeddouble)*2.204*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[7][1] {
                newvalue = (numberchangeddouble)*33.814*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[7][1] && perunit == units[5][1] {
                newvalue = (numberchangeddouble)*0.029*pricevalue
                self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else {
                //case when no match
                nomatchlabel.hidden = false
                nomatchlabel.text = NSLocalizedString("dontmatch", comment: "")
            }
            
            
            
        }
        
        if totalsumlabel.text! != "0" && totalsumlabel.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            totalsumlabel.textColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            totalsumlabel.textColor = UIColorFromRGB(0xE0E0E0)
        }

        /// other case
        
    }
    
    // KEEP TRACK ON changing the textfield to update the total sum in live mode. Just create IBAction choosing Editing Changed as action
    
    func textViewDidBeginEditing(textView: UITextView) {
        shiftview(true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        shiftview(false)
    }
    
    
    @IBOutlet var thetopconstraint: NSLayoutConstraint!
    
    
    func shiftview(up: Bool) {
        
        if up == true {
            
            thetopconstraint.constant = -250
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in

                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in

            })
            // self.view.frame.origin.y -= 200
            
        } else if up == false {
            
            thetopconstraint.constant = 9
           
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
        }
    }
    
    
    
    @IBAction func texfielddidstart(sender: UITextField) {
       // shiftview(true)
        // animateViewMoving(true, moveValue: 300)
        
        priceline.backgroundColor = UIColorFromRGB(0x31793D)
        itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
        
    }
    
    @IBAction func textfieldend(sender: AnyObject) {
       // shiftview(false)
        // animateViewMoving(false, moveValue: 300)
        
       // if (itemPriceOutlet.text! as NSString).containsString(",") {
            //(itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
       // }
        
        if itemPriceOutlet.text! != "0" && itemPriceOutlet.text! != "" {
            priceline.backgroundColor = UIColorFromRGB(0x31797D)
            itemPriceOutlet.textColor = UIColorFromRGB(0x31797D)
            itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
             priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
             itemPriceOutlet.textColor = UIColorFromRGB(0x31797D)
             itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }
        
        itemPriceOutlet.text!.doubleConverter
        
         multiplication()
        
        
    }
    
    @IBAction func textfieldedit(sender: UITextField) {
        

        itemPriceOutlet.text!.doubleConverter
        
        multiplication()
    }
    
    
    @IBAction func pricevalueditchanged(sender: AnyObject) {
        
        if itemPriceOutlet.text! != "0" && itemPriceOutlet.text! != "" {
            priceline.backgroundColor = UIColorFromRGB(0x31793D)
            itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
            itemPriceOutlet.textColor = UIColorFromRGB(0x31797D)
        } else {
            priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
            itemPriceOutlet.textColor = UIColorFromRGB(0xE0E0E0)
        }
        
        
        itemPriceOutlet.text!.doubleConverter
        
        multiplication()
    }
    
    
    @IBAction func pricevaluechanged(sender: AnyObject) {

        
        if itemPriceOutlet.text! != "0" && itemPriceOutlet.text! != "" {
            priceline.backgroundColor = UIColorFromRGB(0x31793D)
            itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
            itemPriceOutlet.textColor = UIColorFromRGB(0x31797D)
        } else {
            priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            itemPriceOutlet.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
            itemPriceOutlet.textColor = UIColorFromRGB(0xE0E0E0)
        }

        
        itemPriceOutlet.text!.doubleConverter
        
        multiplication()
    }
    
    
    @IBAction func qtychanged(sender: AnyObject) {
       
        
        itemPriceOutlet.text!.doubleConverter

        if (Qfield.text != nil) {

            numberchangeddouble = Qfield.text!.doubleConverter
        } else {
            print("no number")
        }
        
       
        
        multiplication()
        
    }
    
    @IBAction func qtyedit(sender: AnyObject) {
       
        Qfield.text!.doubleConverter
        
        if (Qfield.text != nil) {
            // numberchanged = Qfield.text.toInt()!
            //numberchangeddouble = (Qfield.text! as NSString).doubleValue
            numberchangeddouble = Qfield.text!.doubleConverter
        } else {
            print("no number")
        }
        
        
        multiplication()
    }
    
          func pause() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func restore() {
         activityIndicator.stopAnimating()
         UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    
    func getcategoryname(categoryid: String) -> String {
        
       // for categoryid in categoryIds {
            
            if (categoryid as NSString).containsString("custom") {
                //CASE IF CATEGORY IS CUSTOM
                //println(categoryIds)

                let querycat = PFQuery(className:"shopListsCategory")
                querycat.fromLocalDatastore()
                querycat.whereKey("categoryUUID", equalTo: categoryid)
                let categories = querycat.findObjects()
                if (categories != nil) {
                    for category in categories! {
                        if let thiscatname = category["catname"] as? String {
                            print("NAME IS \(thiscatname)")
                            //self.shoppingListItemsCategoriesNames.append(thiscatname)
                            itemcategoryname = thiscatname
                            break;
                        }
                    }
                } else {
                    print("No custom cats yet")
                }
              
                
            } else {
                // CASE IF IT IS DEFAULT CATEGORY

                
                //if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), categoryid) {
                
                  if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(categoryid) {
                let catalogname = catalogcategories[foundcategory].catname
                    
                    print(catalogname)
                    
                   // self.shoppingListItemsCategoriesNames.append(catalogname)
                    itemcategoryname = catalogname
                    print("Name is \(itemcategoryname)")
                    
                }
                
                
            }
            
           
       // }
        return itemcategoryname
    }
    
    
    
    var scaledpicture = UIImage()
    
    func imageResize (imageObj:UIImage)-> UIImage{
        
        // Automatically use scale factor of main screen
        
        let avsize = CGSizeMake(100, 100)
        UIGraphicsBeginImageContextWithOptions(avsize, true, 1.0)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: avsize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        scaledpicture = scaledImage
        return scaledpicture
    }
    

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
                imagePath = ""
                return imagePath//""
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //try for ios9.2
        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(imageName)
        
        // if(!path.isEmpty){
        if path != "" {
            
            let data = NSData(contentsOfURL:path)
            if (data != nil) {
                let image = UIImage(data:data!)
                //}
                print(image);
                if(image != nil){
                    //return image!;
                    self.imageToLoad = image!
                    // return imageToLoad
                } else {
                    self.imageToLoad = imagestochoose[0].itemimage
                }
                
            } else {
                self.imageToLoad = imagestochoose[0].itemimage
            }
            
        } else {
            self.imageToLoad = imagestochoose[0].itemimage
        }
        
        return imageToLoad
    }

    
    func detailedItemAdd() {
        

        pause()
        
       // multiplication() // not sure if need this
        
        var shopItem = PFObject(className:"shopItems")
        var uuid = NSUUID().UUIDString
        var itemuuid = "shopitem\(uuid)"
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = self.itemNameOutlet.text
        shopItem["itemNote"] = self.itemNoteOutlet.text
        
        //shopItem["itemQuantity"] = itemQuantityOutlet.text
        shopItem["itemQuantity"] = self.Qfield.text
        shopItem["itemPriceS"] = self.itemPriceOutlet.text//((self.itemPriceOutlet.text)! as NSString).doubleValue //must convert string to DOUBLE
        shopItem["TotalSumS"] = self.totalsumlabel.text //((self.totalsumlabel.text) as NSString?)?.doubleValue //complicated stuff
        
        shopItem["ItemsList"] = self.getcurrentlist
        
        
        
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        
        if self.UnitsButton.titleForState(.Normal) == NSLocalizedString("units", comment: "") || self.UnitsButton.titleForState(.Normal) == "" {
            shopItem["itemUnit"] = ""
        } else {
        shopItem["itemUnit"] = self.UnitsButton.titleForState(.Normal)//self.buttontitle
        }
        
        if self.perUnitOutlet.titleForState(.Normal) == NSLocalizedString("units", comment: "") || self.perUnitOutlet.titleForState(.Normal) == "" {
            shopItem["perUnit"] = ""
        } else {
            shopItem["perUnit"] = self.perUnitOutlet.titleForState(.Normal)//self.buttontitle
        }
        
        shopItem["chosenFromHistory"] = false
        
       
        
        
        if isdefaultpicture == true {
        shopItem["itemImage"] = NSNull()
        shopItem["defaultpicture"] = true
        shopItem["OriginalInDefaults"] = defaultpicturename
        shopItem["imageLocalPath"] = ""
            
        } else {

        let imageData = UIImagePNGRepresentation(self.itemImageOutlet.image!)
            saveImageLocally(imageData)
            shopItem["itemImage"] = NSNull()
            shopItem["imageLocalPath"] = self.imagePath
            shopItem["defaultpicture"] = false
            shopItem["OriginalInDefaults"] = ""
        }
        
        
        
        shopItem["isChecked"] = false
        
        shopItem["Category"] = itemcategoryUUID
        
        shopItem["isCatalog"] = false
        
        shopItem["originalInCatalog"] = ""
        
        shopItem["isFav"] = isFavouriteItem
        
        shopItem["chosenFromFavs"] = false
        
        var date = NSDate()
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
        
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = true //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        //getcategoryname(itemcategoryUUID)
        
        
        //in case
        self.newitemid = itemuuid
        

        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                self.restore()
                print("saved item")
                self.newitemid = itemuuid
                print("Id on local data store is \(self.newitemid)")
            } else {
                print("no id found")
            }
        })

        
        self.itemName = self.itemNameOutlet.text!
        self.itemNote = self.itemNoteOutlet.text!
        self.itemQty = self.Qfield.text!//self.quantitylabel.text!
       // self.itemPrice = ((self.totalsumlabel.text) as NSString?)!.doubleValue//((self.itemPriceOutlet.text) as NSString).doubleValue
       // self.itemImage = imageFile
        
        if self.UnitsButton.titleForState(.Normal) == NSLocalizedString("units", comment: "") || self.UnitsButton.titleForState(.Normal) == "" {
            self.itemUnit = ""
        } else {
             self.itemUnit = UnitsButton.titleForState(.Normal)!
        }
        
        if self.perUnitOutlet.titleForState(.Normal) == NSLocalizedString("units", comment: "") || self.perUnitOutlet.titleForState(.Normal) == "" {
            self.itemperunit = ""
        } else {
            self.itemperunit = perUnitOutlet.titleForState(.Normal)!
        }

        
        //self.itemUnit = UnitsButton.titleForState(.Normal)!//self.unit
       // self.itemperunit = perUnitOutlet.titleForState(.Normal)!
        
        var itemImage2 : UIImage = self.itemImageOutlet.image!
        var itemischecked : Bool = false
        var itemimagepath : String = self.imagePath
       // var categoryname : String = itemcategoryname
        var thisitemcategory : String = itemcategoryUUID
        var categoryname : String = itemcategory!.catname
        var itemiscatalog : Bool = false
        var originalincatalog : String = ""
        //self.itemoneunitprice = ((self.itemPriceOutlet.text) as NSString).doubleValue
        var oneitemprice : String = self.itemPriceOutlet.text!//((self.itemPriceOutlet.text)! as NSString).doubleValue
        
        
        var totalprice : String = self.totalsumlabel.text!//((self.totalsumlabel.text) as NSString?)!.doubleValue
        
        var isFav : Bool = self.isFavouriteItem
        
        var isdefaultpict = Bool()
        var originalindefaults = String()
        
        if isdefaultpicture == true {
            isdefaultpict = true
            originalindefaults = defaultpicturename//self.itemImageOutlet.image.
            
        } else {
            isdefaultpict = false
            originalindefaults = ""
        }

        
        
        newitemdictionary = ["ItemId":newitemid,"ItemName":itemName,"ItemNote":itemNote, "ItemQuantity":itemQty,"ItemTotalPrice":totalprice,"ItemImagePath":itemimagepath,"ItemUnit":itemUnit,"ItemIsChecked":itemischecked,"ItemImage2":itemImage2,"ItemCategory":thisitemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":oneitemprice,"ItemIsFav":isFav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
        

        
        itemsDataDict.append(newitemdictionary)
        
        shoppingcheckedtocopy.append(false)
        
        itemsorderarray.append(itemuuid)
        
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
      
        if segue.identifier == "showimagesfromadditem" {
            
            let popoverViewController = segue.destinationViewController as! ImagesCollectionVC//UIViewController
            
       
            
           // popoverViewController.view.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 1) // F7F7F7
            
            popoverViewController.delegate = self
            
        }
        
        
               
        if segue.identifier == "AddingDone" {

        }
        
        if segue.identifier == "createcustomcategory" {
           // let popoverViewController = segue.destinationViewController as! CategoryPopup//UIViewController
            
           // let addnavVC = segue.destinationViewController as! UINavigationController
            
           // let popoverViewController = addnavVC.viewControllers.first as! ManageCategoriesVC
            
            let popoverViewController = segue.destinationViewController as! ManageCategoriesVC
            //popoverViewController.preferredContentSize = CGSize(width: 300, height: 400)
            
           // popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
           // popoverViewController.popoverPresentationController!.delegate = self
            
            
            
            popoverViewController.additemdelegate = self //WITHOUT THIS IT WONT WORK

            
        }

    }

    
    func choosecategory(category:Category) {
       // categorybutton.setTitle(categoryname, forState: .Normal)
        //categoryimageoutlet.image = categoryimage
        
      //  categorybutton.setTitle(category.catname, forState: .Normal)
       
        itemcategory = category
        itemcategoryUUID = category.catId
    }

    //// JUST FOR TESTING I SWITCH THIS OFF!
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
       /////end for popover
    
    @IBAction func unwindToAddItemAfterScan(sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
       
    
    func saveexistingitem() {

        var query1 = PFQuery(className:"shopItems")
        query1.fromLocalDatastore()
        query1.whereKey("itemUUID", equalTo: currentitem)
        // query1.getObjectInBackgroundWithId(currentitem) {
        query1.getFirstObjectInBackgroundWithBlock() {
            (itemch: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let itemch = itemch {
                
                itemch["itemName"] = self.itemNameOutlet.text
                //dispatch_async(dispatch_get_main_queue(), {
                
                if itemch["isCatalog"] as! Bool == false {
                
                if self.isdefaultpicture == true {
                    itemch["itemImage"] = NSNull()
                    itemch["defaultpicture"] = true
                    itemch["OriginalInDefaults"] = self.defaultpicturename//self.itemImageOutlet.image.
                    itemch["imageLocalPath"] = ""
                } else {
                    
                    
                   // self.imageResize(self.itemImageOutlet.image!)
                  //  let imageDataexisting = UIImagePNGRepresentation(self.scaledpicture)
                    
                    let imageDataexisting = UIImagePNGRepresentation(self.itemImageOutlet.image!)
                    //let imageData = UIImagePNGRepresentation(chosenPicture)
                  //  let imageFileexisting = PFFile(name:"itemImage", data:imageDataexisting!)
                    


                    self.saveImageLocally(imageDataexisting)
                    

                    
                    itemch["imageLocalPath"] = self.imagePath

                    
                    itemch["itemImage"] = NSNull()//imageFileexisting
                    itemch["defaultpicture"] = false
                    itemch["OriginalInDefaults"] = ""
                }

                } else {
                    itemch["itemImage"] = NSNull()
                    itemch["defaultpicture"] = false
                    itemch["OriginalInDefaults"] = ""
                    itemch["imageLocalPath"] = ""
                }
                
     
                
               // self.multiplication() // NO NEED
                
                itemch["itemNote"] = self.itemNoteOutlet.text
                itemch["itemQuantity"] = self.Qfield.text
                itemch["itemPriceS"] = self.itemPriceOutlet.text//((self.itemPriceOutlet.text!) as NSString).doubleValue
                itemch["TotalSumS"] = self.totalsumlabel.text//((self.totalsumlabel.text) as NSString?)?.doubleValue
                itemch["ItemsList"] = self.getcurrentlist //as String!
                itemch["belongsToUser"] = PFUser.currentUser()!.objectId!
                //itemch["itemUnit"] = self.UnitsButton.titleForState(.Normal)//self.buttontitle//self.unit
                itemch["chosenFromHistory"] = false
             
                if self.UnitsButton.titleForState(.Normal) == NSLocalizedString("units", comment: "") || self.UnitsButton.titleForState(.Normal) == "" {
                    itemch["itemUnit"] = ""
                } else {
                    itemch["itemUnit"] = self.UnitsButton.titleForState(.Normal)//self.buttontitle
                }
                
                if self.perUnitOutlet.titleForState(.Normal) == NSLocalizedString("units", comment: "") || self.perUnitOutlet.titleForState(.Normal) == "" {
                    itemch["perUnit"] = ""
                } else {
                    itemch["perUnit"] = self.perUnitOutlet.titleForState(.Normal)//self.buttontitle
                }

                
                itemch["Category"] = self.itemcategoryUUID
                
                itemch["isFav"] = self.isFavouriteItem
                
                var update = NSDate()
                
                itemch["UpdateDate"] = update
                
                
                
             //   itemch["chosenFromFavs"] = self.item
                
                print("item \(self.currentitem) was updated and saved")
                
                
                // dispatch_async(dispatch_get_main_queue(), {
                /*item.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                //println("Object has been saved.")
                println("item \(self.currentitem) was updated and saved")
                
                }*/
                
                
                for ( var i = 0; i < itemsDataDict.count; i++ ) {
                    if itemsDataDict[i]["ItemId"] as? String == self.currentitem {
                        
                        
                        print(itemsDataDict[i])
                        
                        
                        ////get cat name
                        self.getcategoryname(self.itemcategoryUUID)
                        
                        ////
                        
                        itemsDataDict[i]["ItemName"] = self.itemNameOutlet.text
                        itemsDataDict[i]["ItemNote"] = self.itemNoteOutlet.text
                        itemsDataDict[i]["ItemQuantity"] = self.Qfield.text
                        itemsDataDict[i]["ItemTotalPrice"] = self.totalsumlabel.text//((self.totalsumlabel.text) as NSString?)?.doubleValue
                        itemsDataDict[i]["ItemImagePath"] = self.imagePath
                        if self.UnitsButton.titleForState(.Normal) == "Units" || self.UnitsButton.titleForState(.Normal) == "" {
                            itemsDataDict[i]["ItemUnit"] = ""
                        } else {
                            itemsDataDict[i]["ItemUnit"] = self.UnitsButton.titleForState(.Normal)
                        }
                        //itemsDataDict[i]["ItemIsChecked"] = self.itemNameOutlet.text
                        itemsDataDict[i]["ItemImage2"] = self.itemImageOutlet.image
                        itemsDataDict[i]["ItemCategory"] = self.itemcategoryUUID
                        // itemsDataDict[i]["ItemIsCatalog"] = self.itemNameOutlet.text
                        // itemsDataDict[i]["ItemOriginal"] = self.itemNameOutlet.text
                        itemsDataDict[i]["ItemCategoryName"] = self.itemcategoryname
                        
                        // print(self.itemPriceOutlet.text)
                        
                        itemsDataDict[i]["ItemOneUnitPrice"] = self.itemPriceOutlet.text//((self.itemPriceOutlet.text)! as NSString).doubleValue
                        //  print( itemsDataDict[i]["ItemOneUnitPrice"])
                        
                        itemsDataDict[i]["ItemIsFav"] = self.isFavouriteItem
                        
                        if self.perUnitOutlet.titleForState(.Normal) == "Units" || self.perUnitOutlet.titleForState(.Normal) == "" {
                            itemsDataDict[i]["ItemPerUnit"] = ""
                            
                        } else {
                            itemsDataDict[i]["ItemPerUnit"] = self.perUnitOutlet.titleForState(.Normal)
                        }
                        itemsDataDict[i]["UpdateDate"] = update
                        itemsDataDict[i]["ItemIsDefPict"] = self.isdefaultpicture
                        itemsDataDict[i]["ItemOriginalInDefaults"] = self.defaultpicturename
                        
                        
                        
                        print(itemsDataDict[i])
                        
                    }
                }
                
                
                itemch.pinInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Item saved")
                    
                    
                    // now update this item in itemsDataDict
                    
                    // now the same for HISTORY ITEMS if such exists
                    if HistoryitemsDataDict.count != 0 {
                    for ( var i = 0; i < HistoryitemsDataDict.count; i++ ) {
                        if HistoryitemsDataDict[i]["ItemId"] as? String == self.currentitem {
                            
                            
                            print(HistoryitemsDataDict[i])
                            
                            
                            ////get cat name
                            self.getcategoryname(self.itemcategoryUUID)
                            
                            ////
                            
                            HistoryitemsDataDict[i]["ItemName"] = self.itemNameOutlet.text
                            HistoryitemsDataDict[i]["ItemNote"] = self.itemNoteOutlet.text
                            HistoryitemsDataDict[i]["ItemQuantity"] = self.Qfield.text
                            HistoryitemsDataDict[i]["ItemTotalPrice"] = self.totalsumlabel.text//((self.totalsumlabel.text) as NSString?)?.doubleValue
                            HistoryitemsDataDict[i]["ItemImagePath"] = self.imagePath
                            HistoryitemsDataDict[i]["ItemUnit"] = self.UnitsButton.titleForState(.Normal)
                            //itemsDataDict[i]["ItemIsChecked"] = self.itemNameOutlet.text
                            HistoryitemsDataDict[i]["ItemImage2"] = self.itemImageOutlet.image
                            HistoryitemsDataDict[i]["ItemCategory"] = self.itemcategoryUUID
                            // itemsDataDict[i]["ItemIsCatalog"] = self.itemNameOutlet.text
                            // itemsDataDict[i]["ItemOriginal"] = self.itemNameOutlet.text
                            HistoryitemsDataDict[i]["ItemCategoryName"] = self.itemcategoryname
                            
                            
                            
                             HistoryitemsDataDict[i]["ItemOneUnitPrice"] = self.itemPriceOutlet.text//((self.itemPriceOutlet.text)! as NSString).doubleValue
                            HistoryitemsDataDict[i]["ItemIsFav"] = self.isFavouriteItem
                            HistoryitemsDataDict[i]["ItemPerUnit"] = self.perUnitOutlet.titleForState(.Normal)
                            HistoryitemsDataDict[i]["UpdateDate"] = update
                            HistoryitemsDataDict[i]["ItemIsDefPict"] = self.isdefaultpicture
                            HistoryitemsDataDict[i]["ItemOriginalInDefaults"] = self.defaultpicturename

                            //dictionary = ["ItemId":self.itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname]
                            
                            print(HistoryitemsDataDict[i])
                            
                            }
                        }
                    }
                    
                  
                    
                    ////
                    
                    
                } else {
                    // There was a problem, check error.description
                    }
                })
                
                
                ////segue stuff
                if self.sendercontroller == "ShopListCreation" {
                    
                    if((self.shopdelegate) != nil)
                    {
                        self.shopdelegate?.refreshtable()
                        
                        
                    }
                    
                    self.performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
                    
                } else {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    
                }
                //
                //itemch.saveInBackground()
                //itemch.saveEventually()
                /*
                itemch.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        // The object has been saved.
                    } else {
                        // There was a problem, check error.description
                    }
                }
                    */
                // })
                
            }
        }
   
    }
    
    var catalogitemimage = UIImage()
    
    func getcatalogitemimage(itemid: String) -> UIImage {
     
        //if let founditem = find(lazy(catalogitems).map({ $0.itemId }), itemid) {
        
         if let founditem = catalogitems.map({ $0.itemId }).lazy.indexOf(itemid) {
        let catalogitem = catalogitems[founditem]
            
            print(catalogitem)
            
            catalogitemimage = catalogitem.itemimage
        }
        
        return catalogitemimage
    }
    
    
    @IBOutlet var prodnamelabel: UILabel!
    @IBOutlet var photobuttonoutlet: UIButton!
    
    @IBOutlet var iconlabel: UILabel!
    
    func retrieveexistingitemfromdictionary(current:String) {
        
        for ( var i = 0; i < itemsDataDict.count; i++ ) {
            if itemsDataDict[i]["ItemId"] as? String == current {
                
                self.itemNameOutlet.text = itemsDataDict[i]["ItemName"] as! String
                self.itemNoteOutlet.text = itemsDataDict[i]["ItemNote"] as! String
                


                
                self.itemiscatalog = itemsDataDict[i]["ItemIsCatalog"] as! Bool
                
               // self.itemisdefaultpict = itemsDataDict[i]["ItemIsDefPict"] as! Bool
                self.isdefaultpicture = itemsDataDict[i]["ItemIsDefPict"] as! Bool //if false then it is customimage, not defaults
                self.defaultpicturename = itemsDataDict[i]["ItemOriginalInDefaults"] as! String
                
                if self.itemiscatalog == true {
                    
                   // self.categorybutton.enabled = false
                  //  self.chooseitemimageoutlet.enabled = false
                    self.itemNameOutlet.enabled = false
                    self.prodnamelabel.textColor = UIColorFromRGB(0xC6C6C6)
                    self.iconlabel.textColor = UIColorFromRGB(0xC6C6C6)

                    self.photobuttonoutlet.enabled = false
                    
                    self.itemNameOutlet.alpha = 0.6
                    self.photobuttonoutlet.alpha = 0.1
                    
                }
                
                
                //NOW EASIER JUST TO GET IMAGE FROM DICT
                self.itemImageOutlet.image = itemsDataDict[i]["ItemImage2"] as? UIImage
                
                //self.itemisfavourite = itemsDataDict[i]["ItemIsFav"] as! Bool
                self.isFavouriteItem = itemsDataDict[i]["ItemIsFav"] as! Bool
                
                
                
             
                
                if itemsDataDict[i]["ItemUnit"] as? String != "" {
                self.UnitsButton.setTitle(itemsDataDict[i]["ItemUnit"] as? String, forState: UIControlState.Normal)
                self.unline.backgroundColor = UIColorFromRGB(0x31797D)
                    
                } else {
                     self.UnitsButton.setTitle(NSLocalizedString("units", comment: ""), forState: UIControlState.Normal)
                    self.unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
                
                if itemsDataDict[i]["ItemPerUnit"] as? String != "" {
                self.perUnitOutlet.setTitle(itemsDataDict[i]["ItemPerUnit"] as? String, forState: UIControlState.Normal)
                    self.perunline.backgroundColor = UIColorFromRGB(0x31797D)
                } else {
                     self.perUnitOutlet.setTitle(NSLocalizedString("units", comment: ""), forState: UIControlState.Normal)
                    self.perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
                
       
                
                print(itemsDataDict[i]["ItemOneUnitPrice"])
                
                print(itemsDataDict[i]["ItemTotalPrice"])
               
                self.itemPriceOutlet.text = itemsDataDict[i]["ItemOneUnitPrice"] as! String
                
                if self.itemPriceOutlet.text != "" && self.itemPriceOutlet.text != "0" {
                    
                self.priceline.backgroundColor = UIColorFromRGB(0x31797D)
                } else {
                    self.priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
                
                self.Qfield.text = itemsDataDict[i]["ItemQuantity"] as! String
                
                
                self.totalsumlabel.text = itemsDataDict[i]["ItemTotalPrice"] as! String
                
                if self.totalsumlabel.text != "" && self.itemPriceOutlet.text != "0" {
                    
                    self.sumline.backgroundColor = UIColorFromRGB(0x31797D)
                } else {
                    self.sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
                
                //self.totalsumlabel.text = String(stringInterpolationSegment: itemsDataDict[i]["ItemTotalPrice"] as! Double)
                
                
                
                
                
                self.itemcategoryUUID = itemsDataDict[i]["ItemCategory"] as! String
                
                // if category["isCustom"] as! Bool == true {
                if (self.itemcategoryUUID as NSString).containsString("custom") {
   
                    
                    if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(self.itemcategoryUUID) {
                    let catalogcategory = catalogcategories[foundcategory]
                    
                    print(catalogcategory)
                    
                    self.itemcategoryUUID = catalogcategory.catId
                    
                   // self.categorybutton.setTitle(catalogcategory.catname, forState: .Normal)
                    
                    /// HERE PUT CODE EDITING SCROLLER
                    ///    TODO
                        for view in horizontalScrollView.subviews {
                            
                            //if let tappedview = view as? UIButton {
                            if view.tag == foundcategory {
                                
                                view.tintColor = UIColorFromRGB(0x31797D)
                                for subview in view.subviews {
                                    subview.tintColor = UIColorFromRGB(0x31797D)
                                    //if let labelview : UILabel = subview as! UILabel {
                                    if subview == subview as? UILabel {
                                        // that's how one finds out the type
                                        (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                                    }
                                }
                                view.layer.borderWidth = 1
                                view.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                            } else {
                                
                                view.tintColor = UIColorFromRGB(0x979797)
                                for subview in view.subviews {
                                    subview.tintColor = UIColorFromRGB(0x979797)
                                    // if let labelview : UILabel == subview as? UILabel {
                                    if subview == subview as? UILabel {
                                        (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                                    }
                                }
                                
                                view.layer.borderWidth = 0
                                view.layer.borderColor = UIColor.clearColor().CGColor
                            }
                            // }
                        }
                        

                        var vel: CGPoint = CGPointMake(horizontalScrollView.finditem(foundcategory, inScrollView: horizontalScrollView), 0.0)
                        horizontalScrollView.contentOffset = vel

                    }

                    
                } else {


                    if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(self.itemcategoryUUID) {
                    let catalogcategory = catalogcategories[foundcategory]
                        
                        print(catalogcategory)
                        
                        self.itemcategoryUUID = catalogcategory.catId
                        
                       // self.categorybutton.setTitle(catalogcategory.catname, forState: .Normal)
                        
                        /// TODO
                        for view in horizontalScrollView.subviews {
                            
                            //if let tappedview = view as? UIButton {
                            if view.tag == foundcategory {
                                
                                view.tintColor = UIColorFromRGB(0x31797D)
                                for subview in view.subviews {
                                    subview.tintColor = UIColorFromRGB(0x31797D)
                                    //if let labelview : UILabel = subview as! UILabel {
                                    if subview == subview as? UILabel {
                                        // that's how one finds out the type
                                        (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                                    }
                                }
                                view.layer.borderWidth = 1
                                view.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                            } else {
                                
                                view.tintColor = UIColorFromRGB(0x979797)
                                for subview in view.subviews {
                                    subview.tintColor = UIColorFromRGB(0x979797)
                                    // if let labelview : UILabel == subview as? UILabel {
                                    if subview == subview as? UILabel {
                                        (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                                    }
                                }
                                
                                view.layer.borderWidth = 0
                                view.layer.borderColor = UIColor.clearColor().CGColor
                            }
                            // }
                        }
                        

                     
                        var vel: CGPoint = CGPointMake(horizontalScrollView.finditem(foundcategory, inScrollView: horizontalScrollView), 0.0)
                        horizontalScrollView.contentOffset = vel
                       
                    }
                    
                    
                }
                
                
            } else {
                print("WHERE THE FUCK IS THIS ITEM?!")
            }
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
            alpha: CGFloat(alp)//CGFloat(1.0)
        )
    }
    
    
    
    @IBOutlet var minusoutlet: UIButton!
    
    
    @IBOutlet var plusoutlet: UIButton!
        var maximumFractionDigits: Int = 0
    var decimalSeparator: NSString = NSString()
    
    
    
    
    /// Text field stuff
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    /*
    func textFieldDidBeginEditing(textField: UITextField) {
        //return
        
        
        return
    }
     */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
       func closenumberpad(sender: UIButton) {
    itemPriceOutlet.resignFirstResponder()
    }
    
    func closenumberpad2(sender: UIButton) {
        Qfield.resignFirstResponder()
    }
    
    func closenumberpad3(sender: UIButton) {
        totalsumlabel.resignFirstResponder()
    }
    
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        borderview.frame = CGRectOffset(borderview.frame, 0,  movement)
        
        UIView.commitAnimations()
    }
  
    
    var closepadimage = UIImage(named: "ClosePad")!
    
   
    
    
    @IBOutlet var amountview: UIView!
    
    

    
    @IBOutlet var curcodelabel: UILabel!
    
    

    
    @IBOutlet var pictview: UIView!
    
    
    
    // MARK: New categories stuff
    
    @IBOutlet var viewforcats: UIView!
    
    var horizontalScrollView = ASHorizontalScrollView()
    
    func setupbuttonview(buttonview: UIView, buttonimage: UIImageView, buttonlabel: UILabel) {
        
            buttonview.layer.cornerRadius = 8
        
            buttonlabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            buttonlabel.numberOfLines = 2
            buttonlabel.font = UIFont(name: "AvenirNext-Regular", size: 9)
            buttonlabel.textColor = UIColorFromRGB(0x979797)
            buttonlabel.textAlignment = .Center
        
            buttonimage.tintColor = UIColorFromRGB(0x979797)
        
            //Customize the button
           // button.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
           // button.backgroundColor = UIColor.clearColor()
           // button.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 9)
           // button.setTitleColor(UIColorFromRGB(0x979797), forState: UIControlState.Normal)
           // button.layer.borderWidth = 1
           // button.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
          //  button.tintColor = UIColorFromRGB(0x31797D)
          //  button.layer.cornerRadius = 8
        
      
        
    }
    
    func choosecategoryhere(sender: UITapGestureRecognizer? = nil) {
        
        var senderview : UIView = (sender?.view)!
        var sendertag : Int = (sender?.view!.tag)!
       
        var category : Category = catalogcategories[sendertag]
        
        //categorybutton.setTitle(category.catname, forState: .Normal)
       // categoryimageoutlet.image = category.catimage
        itemcategory = category
        itemcategoryUUID = category.catId
        
        
        for view in horizontalScrollView.subviews {
            
            //if let tappedview = view as? UIButton {
                if view.tag == sendertag {
                    
                    senderview.tintColor = UIColorFromRGB(0x31797D)
                    for subview in senderview.subviews {
                        subview.tintColor = UIColorFromRGB(0x31797D)
                        //if let labelview : UILabel = subview as! UILabel {
                        if subview == subview as? UILabel {
                            // that's how one finds out the type
                            (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                        }
                    }
                    senderview.layer.borderWidth = 1
                    senderview.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                } else {
                    
                    view.tintColor = UIColorFromRGB(0x979797)
                    for subview in view.subviews {
                        subview.tintColor = UIColorFromRGB(0x979797)
                       // if let labelview : UILabel == subview as? UILabel {
                        if subview == subview as? UILabel {
                            (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                        }
                    }

                    view.layer.borderWidth = 0
                    view.layer.borderColor = UIColor.clearColor().CGColor
                }
           // }
        }
    }
    
    func addcustomhere(sender: UITapGestureRecognizer? = nil) {
        
        //segue to manage custom cats
        performSegueWithIdentifier("createcustomcategory", sender: self)
        
    }

    /// NEW UNITS STUFF WITH SRK
    
    
    @IBOutlet var picker: UIPickerView!
    
    var chosenunit = String()
    var chosenperunit = String()

    @IBAction func confirmunit(sender: AnyObject) {
        
        saveUnit()
   
    }
    
    
    @IBAction func cancelunit(sender: AnyObject) {
        
        // show view constr = -8
         dimmerview.hidden = true
        
        unitviewbottomconstraint.constant = -283
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        self.picker.selectRow(0, inComponent: 0, animated: false)
        //self.pickerView(self.myPickerView, didSelectRow: 0, inComponent: 0)
        chosenunit = ""
        chosenperunit = ""
        
    
        if UnitsButton.titleForState(.Normal) == "" {
            
            unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
            
        }
        
        
        if perUnitOutlet.titleForState(.Normal) == "" {
            
            perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
            
        }
    
    }
    
    
    func saveUnit(){
        
        if currenttype == "unit" {
            
            if (chosenunit != "") && (perUnitOutlet.titleForState(.Normal) == "") {
                UnitsButton.setTitle(chosenunit, forState: .Normal)
                perUnitOutlet.setTitle(chosenunit, forState: .Normal)
                
                if chosenunit != "" {
                    unline.backgroundColor = UIColorFromRGB(0x31797D)
                    perunline.backgroundColor = UIColorFromRGB(0x31797D)
                } else {
                    unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                    perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
                
            } else {
                UnitsButton.setTitle(chosenunit, forState: .Normal)
                 if chosenunit != "" {
                  unline.backgroundColor = UIColorFromRGB(0x31797D)
                 } else {
                     unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
            }
            
            
        } else if currenttype == "perunit" {
            
            perUnitOutlet.setTitle(chosenperunit, forState: .Normal)
            
            if chosenperunit != "" {
                
                perunline.backgroundColor = UIColorFromRGB(0x31797D)
            } else {
               
                perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            }

        }
        
        multiplication()
        
        dimmerview.hidden = true
        
        unitviewbottomconstraint.constant = -283
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        //restore
         self.picker.selectRow(0, inComponent: 0, animated: false)
        chosenunit = ""
        chosenperunit = ""
        
    }
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns number of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return units.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return units[row][0]//[1]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currenttype == "unit" {
            
                chosenunit = units[row][1]
               // chosenperunit = units[row][1]
            
        
        } else if currenttype == "perunit" {
        
        chosenperunit = units[row][1]
        }
        
    }
    
    var currenttype : String = "unit"
    
    @IBOutlet var dimmerview: UIView!
    
    
    func showunitsview(buttontype: String) {
        
        
        if buttontype == "unit" {
            
            currenttype = "unit"
            
            unline.backgroundColor = UIColorFromRGB(0x31797D)
            
        } else if buttontype == "perunit" {
            
            currenttype = "perunit"
            
            perunline.backgroundColor = UIColorFromRGB(0x31797D)
        }
        
        dimmerview.hidden = false
        
        unitviewbottomconstraint.constant = -8
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })

        
        
    }
    
    @IBOutlet var unitsview: UIView!
    
    @IBOutlet var unitviewbottomconstraint: NSLayoutConstraint!
    
    
    //// UNITS STUFF END
    
    func categoriessetup() {
        //categories setup
        
        // add custom cat button
        let addcustom = UIView(frame: CGRectZero)
        let labelview = UILabel(frame: CGRectMake(2, 36, 66, 31))
        let imageview = UIImageView(frame: CGRectMake(21, 8, 28, 28))
        
        labelview.text = NSLocalizedString("addcustom", comment: "")
        imageview.image = UIImage(named: "4EmptyImage")
        
        addcustom.addSubview(labelview)
        addcustom.addSubview(imageview)
        
        addcustom.tag = catalogcategories.count + 10
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("addcustomhere:"))
        addcustom.userInteractionEnabled = true
        addcustom.addGestureRecognizer(tapGestureRecognizer)
        
        setupbuttonview(addcustom, buttonimage: imageview, buttonlabel: labelview)
        horizontalScrollView.addItem(addcustom)
        
      
        for i in (0..<catalogcategories.count) {

            let addcat = UIView(frame: CGRectZero)
            let labelview = UILabel(frame: CGRectMake(2, 36, 66, 31))
            let imageview = UIImageView(frame: CGRectMake(21, 8, 28, 28))
            
            labelview.text = catalogcategories[i].catname
            imageview.image = catalogcategories[i].catimage
            
            addcat.addSubview(labelview)
            addcat.addSubview(imageview)
            
            addcat.tag = i
            //"addcustomhere:"
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("choosecategoryhere:"))
            addcat.userInteractionEnabled = true
            addcat.addGestureRecognizer(tapGestureRecognizer)
            
            
            setupbuttonview(addcat, buttonimage: imageview, buttonlabel: labelview)
            horizontalScrollView.addItem(addcat)
        }
        
        self.viewforcats.addSubview(horizontalScrollView)
        
    }
 
    
    
    @IBOutlet var cancelbaroutlet: UIBarButtonItem!
    @IBOutlet var savebaroutlet: UIBarButtonItem!
  
    @IBAction func cancelbar(sender: AnyObject) {
        
        performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
    }
    
    
    @IBAction func donebar(sender: AnyObject) {
        
        
        if existingitem == false
        {
            detailedItemAdd()
            
            if sendercontroller == "ShopListCreation" {
                
                if((self.shopdelegate) != nil)
                {
                    shopdelegate?.refreshtable()

                }
                performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
                
            } else {
                
                
                performSegueWithIdentifier("gobacktocreationshoplist", sender: self) // FOR NOW
                
                
            }
            
        }
        else {
            saveexistingitem()
            
            ///SEGUE AND RELOAD DATA STUFF IS WITHIN savex function!
        }
    }
    
    
    
    
    @IBOutlet var unline: UIView!
    @IBOutlet var priceline: UIView!
    @IBOutlet var perunline: UIView!
    @IBOutlet var sumline: UIView!
    
    
    @IBAction func showimagesvc(sender: AnyObject) {
        
        performSegueWithIdentifier("showimagesfromadditem", sender: self)
    }
    
    
    
    @IBOutlet var catviewhconstr: NSLayoutConstraint! // 78
    
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            cancelbaroutlet.tintColor = UIColorFromRGB(0xF23D55)
            savebaroutlet.tintColor = UIColorFromRGB(0x31797D)
            
          //  navigationItem.titleView?. tintColor = UIColorFromRGB(0x979797)
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColorFromRGB(0x979797),NSFontAttributeName:UIFont(name: "AvenirNext-Regular", size: 16)!]
            
          dimmerview.hidden = true
            
            unitsview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            unitsview.layer.borderWidth = 1
            
            picker.delegate = self
            picker.dataSource = self
            
            // SETUP CATEGORIES SCROLLER
            
            horizontalScrollView = ASHorizontalScrollView(frame:CGRectMake(12, 4, viewforcats.frame.width - 24, 70))//viewforcats.frame.height - 5))
            horizontalScrollView.uniformItemSize = CGSizeMake(70, 70)
            horizontalScrollView.leftMarginPx = 0
            horizontalScrollView.miniMarginPxBetweenItems = 0
            horizontalScrollView.miniAppearPxOfLastItem = 10
            horizontalScrollView.setItemsMarginOnce()

            categoriessetup()


            curcodelabel.text = symbol
           // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
          //  if UIScreen.mainScreen().sizeType == .iPhone4 {
               if UIScreen.mainScreen().nativeBounds.height == 960 {
            
                catviewhconstr.constant = 40
                
            }
            

            
            let toolFrame = CGRectMake(0, 0, self.view.frame.size.width, 46);
            let toolView: UIView = UIView(frame: toolFrame);
            
            let closepadframe: CGRect = CGRectMake(self.view.frame.size.width - 66, 2, 56, 42); //size & position of the button as placed on the toolView
            
            //Create the cancel button & set its title
            let closepad: UIButton = UIButton(frame: closepadframe);
           // closepad.setTitle("Close", forState: UIControlState.Normal);
            //closepad.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
            closepad.setImage(closepadimage, forState: UIControlState.Normal)
            toolView.addSubview(closepad); //add it to the toolView
            
            //Add the target - target, function to call, the event witch will trigger the function call
            closepad.addTarget(self, action: "closenumberpad2:", forControlEvents: UIControlEvents.TouchDown);
            
             Qfield.inputAccessoryView = toolView
                        
            let toolFrame2 = CGRectMake(0, 0, self.view.frame.size.width, 46);
            let toolView2: UIView = UIView(frame: toolFrame2);
            
            let closepadframe2: CGRect = CGRectMake(self.view.frame.size.width - 66, 2, 56, 42); //size & position of the button as placed on the toolView
            
            //Create the cancel button & set its title
            let closepad2: UIButton = UIButton(frame: closepadframe2);
            // closepad.setTitle("Close", forState: UIControlState.Normal);
            //closepad.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
            closepad2.setImage(closepadimage, forState: UIControlState.Normal)
            toolView2.addSubview(closepad2); //add it to the toolView
            
            //Add the target - target, function to call, the event witch will trigger the function call
            closepad2.addTarget(self, action: "closenumberpad:", forControlEvents: UIControlEvents.TouchDown);
            
            itemPriceOutlet.inputAccessoryView = toolView2
            
            let toolFrame3 = CGRectMake(0, 0, self.view.frame.size.width, 46);
            let toolView3: UIView = UIView(frame: toolFrame3);
            
            let closepadframe3: CGRect = CGRectMake(self.view.frame.size.width - 66, 2, 56, 42); //size & position of the button as placed on the toolView
            
            //Create the cancel button & set its title
            let closepad3: UIButton = UIButton(frame: closepadframe3);
            // closepad.setTitle("Close", forState: UIControlState.Normal);
            //closepad.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
            closepad3.setImage(closepadimage, forState: UIControlState.Normal)
            toolView3.addSubview(closepad3); //add it to the toolView
            
            //Add the target - target, function to call, the event witch will trigger the function call
            closepad3.addTarget(self, action: "closenumberpad3:", forControlEvents: UIControlEvents.TouchDown);
            
            totalsumlabel.inputAccessoryView = toolView3

            itemNameOutlet.leftTextMargin = 1
            
            itemNameOutlet.delegate = self
            itemNoteOutlet.delegate = self
            Qfield.delegate = self
            itemPriceOutlet.delegate = self
            totalsumlabel.delegate = self
            
            
            
            
           
        
            
        if existingitem == true {
            //retrieveexistingitem(currentitem)
            retrieveexistingitemfromdictionary(currentitem)
           // ProductHistoryOutlet.hidden = true
                       
            
        } else {

            
            itemcategory = catalogcategories[0]
            itemcategoryUUID = catalogcategories[0].catId
            //categorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
            
          //  categoryimageoutlet.image = catalogcategories[0].catimage
            
            self.isFavouriteItem = false
            self.UnitsButton.setTitle(NSLocalizedString("units", comment: ""), forState: .Normal)
            self.perUnitOutlet.setTitle(NSLocalizedString("units", comment: ""), forState: .Normal)

            isdefaultpicture = true
            
            for view in horizontalScrollView.subviews {
                
                //if let tappedview = view as? UIButton {
                if view.tag == 0 {
                    
                    view.tintColor = UIColorFromRGB(0x31797D)
                    for subview in view.subviews {
                        subview.tintColor = UIColorFromRGB(0x31797D)
                        //if let labelview : UILabel = subview as! UILabel {
                        if subview == subview as? UILabel {
                            // that's how one finds out the type
                            (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                        }
                    }
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                    
                    break;
                } /*else {
                    
                    view.tintColor = UIColorFromRGB(0x979797)
                    for subview in view.subviews {
                        subview.tintColor = UIColorFromRGB(0x979797)
                        // if let labelview : UILabel == subview as? UILabel {
                        if subview == subview as? UILabel {
                            (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                        }
                    }
                    
                    view.layer.borderWidth = 0
                    view.layer.borderColor = UIColor.clearColor().CGColor
                }*/
                 }
           
            
            
           


            
        }

    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
