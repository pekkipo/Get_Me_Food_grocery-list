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




class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIPopoverPresentationControllerDelegate, CategoryPopupDelegate, ImagesPopupDelegate, UITextFieldDelegate, UITextViewDelegate {

    
    var withoptionsdelegete : RefreshAddWithOptions?
    
    var shopdelegate : RefreshListDelegate?
    
    var sendercontroller = String()
    
    
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

    //
    //for image
   // let imageData = UIImagePNGRepresentation(itemImageOutlet.image)
    //let imageFile = PFFile(name:"itemImage.png", data:imageData)
    
    
    
    @IBOutlet weak var nomatchlabel: UILabel!
    
    
    
    
    @IBOutlet weak var perUnitOutlet: UIButton!
    
    @IBOutlet weak var additemtofav: UIButton!
    
    
    @IBAction func addtofavaction(sender: AnyObject) {
        
        
        if isFavouriteItem == true {

        additemtofav.setImage(notfavimage, forState: UIControlState.Normal)
       // additemtofav.setTitle("Add Item to Favourites", forState: UIControlState.Normal)
            
            isFavouriteItem = false
            
        } else {
              additemtofav.setImage(favimage, forState: UIControlState.Normal)
           // additemtofav.setTitle("Remove from Favourites", forState: UIControlState.Normal)
            isFavouriteItem = true
        }
        
        
    }
    
    @IBOutlet weak var stepper: UIStepper!
    
    
    @IBOutlet weak var categorybutton: UIButton!
    
    @IBOutlet weak var categoryimageoutlet: UIImageView!
    
    @IBOutlet weak var UnitsButton: UIButton!
   
   
    @IBOutlet var Qfield: UITextField!
    
    
    @IBOutlet weak var QuantityStepper: UIStepper!
  
    @IBAction func showCategoryButton(sender: AnyObject) {
        
        
        
    }
    
    @IBAction func showUnitsButton(sender: AnyObject) {
        
        showPickerInActionSheet(sender as! UIButton)
      //  showPickerInActionSheet()
    }
    
    
    @IBAction func showPerUnitsPicker(sender: AnyObject) {
        
         showPickerInActionSheet(sender as! UIButton)
    }
    
    
   
    
    var itemsDictionary: NSDictionary = NSDictionary()
    
    
    
    @IBOutlet weak var DoneButtonOutlet: UIButton!
    @IBOutlet var itemNameOutlet: CustomTextField!//UITextField!
   
    
    @IBOutlet var itemNoteOutlet: UITextView!
    
    @IBOutlet var itemPriceOutlet: UITextField!
    @IBOutlet var itemImageOutlet: UIImageView!
    @IBOutlet var totalsumlabel: UILabel!
    
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
    
    
    //////////CATEGORY PART
    
      
    //////////CATEGORY PART END
    
    
    
    //// Start save to local
    /*
    func saveImageLocally(imageData:NSData!) -> String {
        var uuid = NSUUID().UUIDString
        //let time =  NSDate().timeIntervalSince1970
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
            //.stringByAppendingPathComponent(subDirForImage) as String
        
        if !fileManager.fileExistsAtPath(dir) {
            var error: NSError?
            if !fileManager.createDirectoryAtPath(dir, withIntermediateDirectories: true, attributes: nil, error: &error) {
                print("Unable to create directory: \(error)")
                return ""
            }
        }
        
        let pathToSaveImage = dir.stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }
    
    
    //// retrieve image from local
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        let path = dir.stringByAppendingPathComponent(imageName)
        
        if(!path.isEmpty){
            let image = UIImage(contentsOfFile: path)
            print(image);
            if(image != nil){
                //return image!;
                self.imageToLoad = image!
                return imageToLoad
            }
        }
        
        return UIImage(named: "activity.png")!
    }
    
    func loadCatImageFromLocalStore(imageName1: String) -> UIImage {
        let fileManager1 = NSFileManager.defaultManager()
        let dir1 = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        let path1 = dir1.stringByAppendingPathComponent(imageName1)
        
        if(!path1.isEmpty){
            let image1 = UIImage(contentsOfFile: path1)
            print(image1);
            if(image1 != nil) {
                //return image!;
                self.catimageToLoad = image1!
                return catimageToLoad
            }
        }
        self.catimageToLoad = UIImage(named: "activity.png")!
        return UIImage(named: "activity.png")!
        
    }
    */
    
    //// END save to local
    
    
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
    
    // itemImageOutlet.image = chosenimage
    
   // var isdefaultpicture = Bool()
    //var defaultpicturename = String()
    
   // var isdefaultpicture : Bool = true
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
        
        
         //   (Qfield.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
        
        
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
        //Qfield.text = String(stringInterpolationSegment: numberchangeddouble)
      //  Qfield.text = String(format: "%.2f", (stringInterpolationSegment: numberchangeddouble))
      //  Qfield.text = String(format: "%.##", (stringInterpolationSegment: numberchangeddouble))
       //  Qfield.text = String(stringInterpolationSegment: numberchangeddouble)
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        
        
        Qfield.text = formatter.stringFromNumber(numberchangeddouble)
        

        
        multiplication()
    }
    
    /*
    var initialValue : Int = 5//Qfield.text.toInt()
    
    var value : Int = initialValue {//value = 0 {
        
        didSet {
            
            //number = oldValue
           
            //value = numberchanged
            //quantitylabel.text = String(value)
            Qfield.text = String(value)
        }
    }
    
    */
    
    var pricevalue = Double()
    
    var newvalue = Double()
    
    func multiplication() {
       // self.totalsumlabel.text = "\((Double(value))*((itemPriceOutlet.text) as NSString).doubleValue)"
        
        
           // (itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
      
       
           // (itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
       

        
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
            
            //self.totalsumlabel.text = "\((Double(numberchanged))*((itemPriceOutlet.text) as NSString).doubleValue)"
          //  self.totalsumlabel.text = "\((numberchangeddouble)*((itemPriceOutlet.text)! as NSString).doubleValue)"
            
         //   self.totalsumlabel.text = "\((numberchangeddouble)*pricevalue)"
           // String(format: "%.2f", (stringInterpolationSegment: numberchangeddouble)
            
            newvalue = numberchangeddouble*pricevalue
            
           
            
           // self.totalsumlabel.text = String(format: "%.2f", (stringInterpolationSegment: newvalue))
            
            self.totalsumlabel.text = formatter.stringFromNumber(newvalue)
            
            nomatchlabel.hidden = true
        } else {
            
            //DEAL WITH UNITS/PER UNITS
            
            //var units : [[String]] = [["",""],["pieces","pcs"],["Dozens","dz"],["kilograms","Kg"], ["grams","g"], ["liters","L"], ["milliliters","ml"],["fluid ounces","fl oz"], ["ounces","oz"], ["pounds","lb"],["gallons","gal"],["meters","m"],["centimeters","cm"],["inches","\""]]
            
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
            
            /*
            if unit == units[3][1] && perunit == units[4][1] {
                
                self.totalsumlabel.text = "\((numberchangeddouble)*1000*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[4][1] && perunit == units[3][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.001*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[6][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*1000*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[6][1] && perunit == units[5][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.001*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[11][1] && perunit == units[12][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*1000*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[12][1] && perunit == units[11][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.001*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[8][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*16.0*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[8][1] && perunit == units[9][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.0625*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[3][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.453*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[3][1] && perunit == units[9][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*2.204*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[7][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*33.814*pricevalue)"
                nomatchlabel.hidden = true
            } else if unit == units[7][1] && perunit == units[5][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.029*pricevalue)"
                nomatchlabel.hidden = true
            } else {
                //case when no match
                nomatchlabel.hidden = false
                nomatchlabel.text = NSLocalizedString("dontmatch", comment: "")
            }
        */
            /*

            if unit == units[3][1] && perunit == units[4][1] {
            
            self.totalsumlabel.text = "\((numberchangeddouble)*1000*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[4][1] && perunit == units[3][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.001*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[6][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*1000*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[6][1] && perunit == units[5][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.001*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[11][1] && perunit == units[12][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*1000*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[12][1] && perunit == units[11][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.001*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[8][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*16.0*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[8][1] && perunit == units[9][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.0625*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[3][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.453*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[3][1] && perunit == units[9][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*2.204*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[7][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*33.814*pricevalue)"
            nomatchlabel.hidden = true
            } else if unit == units[7][1] && perunit == units[5][1] {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.029*pricevalue)"
            nomatchlabel.hidden = true
            } else {
            //case when no match
            nomatchlabel.hidden = false
            nomatchlabel.text = NSLocalizedString("dontmatch", comment: "")
            }

*/
            
        /*
        if unit == perunit {
        
        //self.totalsumlabel.text = "\((Double(numberchanged))*((itemPriceOutlet.text) as NSString).doubleValue)"
            self.totalsumlabel.text = "\((numberchangeddouble)*((itemPriceOutlet.text)! as NSString).doubleValue)"
        } else {
        
        //DEAL WITH UNITS/PER UNITS
            
              //var units : [[String]] = [["",""],["pieces","pcs"],["Dozens","dz"],["kilograms","Kg"], ["grams","g"], ["liters","L"], ["milliliters","ml"],["fluid ounces","fl oz"], ["ounces","oz"], ["pounds","lb"],["gallons","gal"],["meters","m"],["centimeters","cm"],["inches","\""]]
        
            
            if unit == units[3][1] && perunit == units[4][1] {
                
                self.totalsumlabel.text = "\((numberchangeddouble)*1000*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[4][1] && perunit == units[3][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.001*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[6][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*1000*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[6][1] && perunit == units[5][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.001*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[11][1] && perunit == units[12][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*1000*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[12][1] && perunit == units[11][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.001*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[8][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*16.0*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[8][1] && perunit == units[9][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.0625*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[3][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.453*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[3][1] && perunit == units[9][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*2.204*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[7][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*33.814*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else if unit == units[7][1] && perunit == units[5][1] {
                self.totalsumlabel.text = "\((numberchangeddouble)*0.029*((itemPriceOutlet.text)! as NSString).doubleValue)"
                nomatchlabel.hidden = true
            } else {
                //case when no match
                nomatchlabel.hidden = false
                nomatchlabel.text = NSLocalizedString("dontmatch", comment: "")
            }
            */
            /*

            if unit == "Kg" && perunit == "g" {
            
            self.totalsumlabel.text = "\((numberchangeddouble)*1000*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "g" && perunit == "Kg" {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.001*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "L" && perunit == "ml" {
            self.totalsumlabel.text = "\((numberchangeddouble)*1000*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "ml" && perunit == "L" {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.001*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "m" && perunit == "cm" {
            self.totalsumlabel.text = "\((numberchangeddouble)*1000*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "cm" && perunit == "m" {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.001*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "lb" && perunit == "oz" {
            self.totalsumlabel.text = "\((numberchangeddouble)*16.0*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "oz" && perunit == "lb" {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.0625*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "lb" && perunit == "Kg" {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.453*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "Kg" && perunit == "lb" {
            self.totalsumlabel.text = "\((numberchangeddouble)*2.204*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "L" && perunit == "fl oz" {
            self.totalsumlabel.text = "\((numberchangeddouble)*33.814*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else if unit == "fl oz" && perunit == "L" {
            self.totalsumlabel.text = "\((numberchangeddouble)*0.029*((itemPriceOutlet.text)! as NSString).doubleValue)"
            nomatchlabel.hidden = true
            } else {
            //case when no match
            nomatchlabel.hidden = false
            nomatchlabel.text = "Units don't match, sum is not calculated"
            }

*/
            
            /*
            if unit == "Kg" && perunit == "g" {
            
               self.totalsumlabel.text = "\((Double(numberchanged))*1000*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "g" && perunit == "Kg" {
                self.totalsumlabel.text = "\((Double(numberchanged))*0.001*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "L" && perunit == "ml" {
                self.totalsumlabel.text = "\((Double(numberchanged))*1000*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "ml" && perunit == "L" {
                self.totalsumlabel.text = "\((Double(numberchanged))*0.001*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "m" && perunit == "cm" {
                self.totalsumlabel.text = "\((Double(numberchanged))*1000*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "cm" && perunit == "m" {
                self.totalsumlabel.text = "\((Double(numberchanged))*0.001*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "lb" && perunit == "oz" {
                self.totalsumlabel.text = "\((Double(numberchanged))*16*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "oz" && perunit == "lb" {
                self.totalsumlabel.text = "\((Double(numberchanged))*0.0625*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "lb" && perunit == "Kg" {
                self.totalsumlabel.text = "\((Double(numberchanged))*0.453*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "Kg" && perunit == "lb" {
                self.totalsumlabel.text = "\((Double(numberchanged))*2.204*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "L" && perunit == "fl oz" {
                self.totalsumlabel.text = "\((Double(numberchanged))*33.814*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else if unit == "fl oz" && perunit == "L" {
                self.totalsumlabel.text = "\((Double(numberchanged))*0.029*((itemPriceOutlet.text) as NSString).doubleValue)"
            } else {
                //case when no match
                nomatchlabel.text = "Units don't match, sum is not calculated"
            }
            */

            
            
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
            
            thetopconstraint.constant = -100
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in

                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in

            })
            // self.view.frame.origin.y -= 200
            
        } else if up == false {
            
            thetopconstraint.constant = 8
           
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
        }
    }
    
    
    
    @IBAction func texfielddidstart(sender: UITextField) {
       // shiftview(true)
        // animateViewMoving(true, moveValue: 300)
    }
    
    @IBAction func textfieldend(sender: AnyObject) {
       // shiftview(false)
        // animateViewMoving(false, moveValue: 300)
        
       // if (itemPriceOutlet.text! as NSString).containsString(",") {
            //(itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
       // }
        
        itemPriceOutlet.text!.doubleConverter
        
         multiplication()
    }
    
    @IBAction func textfieldedit(sender: UITextField) {
        
       // if (itemPriceOutlet.text! as NSString).containsString(",") {
           // (itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
      //  }
        itemPriceOutlet.text!.doubleConverter
        
        multiplication()
    }
    
    
    @IBAction func pricevaluechanged(sender: AnyObject) {
        
      //  if (itemPriceOutlet.text! as NSString).containsString(",") {
          //  (itemPriceOutlet.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
       // }
        
        itemPriceOutlet.text!.doubleConverter
        
        multiplication()
    }
    
    
    @IBAction func qtychanged(sender: AnyObject) {
       
        //if (Qfield.text! as NSString).containsString(",") {
           // (Qfield.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
      //  }
        
        itemPriceOutlet.text!.doubleConverter
        
       // if (Qfield.text.toInt() != nil) {
        if (Qfield.text != nil) {
       // numberchanged = Qfield.text.toInt()!
            //numberchangeddouble = (Qfield.text! as NSString).doubleValue
            numberchangeddouble = Qfield.text!.doubleConverter
        } else {
            print("no number")
        }
        
       
        
        multiplication()
        
    }
    
    @IBAction func qtyedit(sender: AnyObject) {
        /*
        //number = (Qfield.text).toInt()!
        if (Qfield.text.toInt() != nil) {
            numberchanged = Qfield.text.toInt()!
        } else {
            println("no number")
        }
*/
        
       // if (Qfield.text! as NSString).containsString(",") {
         //   (Qfield.text! as NSString).stringByReplacingOccurrencesOfString(",", withString: ".")
      //  }

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
    
        //var itemsData:NSDictionary = NSDictionary()
    
    /*
    func additemstolistarray() {
        // var userquery = PF
        var query = PFQuery(className:"shopLists")
        query.whereKey("objectId", equalTo: getcurrentlist!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                //self.arrayofItemsNames.removeAll(keepCapacity: true)
                
                if let lists = objects as? [PFObject] {
                    
                    //var arrayofobjects = [AnyObject]()
                    
                    for object in lists {
                        println(object.objectId)
                        //arrayofobjects.append()
                        
                        //arrayofobjects.append(arra)
                        object.setObject(self.arrayofItemsNames, forKey: "ItemsInTheShopList")
                        object.saveInBackground()
                        /*
                        var array = object.objectForKey("ItemsInTheShopList") as! [PFObject]
                        for obj in array {
                            self.ar.append(obj as String)
                        } */
                    }
                }
            } else {
                // Log details of the failuself.re
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    } */
    
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
    
    /* apparently problem on iPhone 5C
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let path = (dir as NSString).stringByAppendingPathComponent(imageName)
        
        if(!path.isEmpty){
            let image = UIImage(contentsOfFile: path)
            print(image);
            if(image != nil){
                //return image!;
                self.imageToLoad = image!
                return imageToLoad
            }
        }
        
        return UIImage(named: "activity.png")!
    }
    */
    /*
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        //try for ios9.2
        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(imageName)
        
        // if(!path.isEmpty){
        if path != "" {
            
            let data = NSData(contentsOfURL:path)
            
            let image = UIImage(data:data!)
            
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
        
        return imageToLoad
    }
    */
    
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
        
        //itemImageOutlet.image = chosenPicture
    
        
        
        //image part
        
        
        //self.totalsumlabel.text = "\((Double(self.value))*((self.itemPriceOutlet.text) as NSString).doubleValue)"
       // self.totalsumlabel.text = "\((Double(self.numberchanged))*((self.itemPriceOutlet.text) as NSString).doubleValue)"
        
        
        //creation of an itemlist
        pause()
        
        multiplication()
        
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
            
       // shopItem["NewImage"] = NSNull()
            
        shopItem["defaultpicture"] = true
        shopItem["OriginalInDefaults"] = defaultpicturename//self.itemImageOutlet.image.
            
            shopItem["imageLocalPath"] = ""
            
        } else {
            
          //  imageResize(self.itemImageOutlet.image!)
           // let imageData = UIImagePNGRepresentation(scaledpicture)
            
            let imageData = UIImagePNGRepresentation(self.itemImageOutlet.image!)

            //let imageData = UIImagePNGRepresentation(chosenPicture)
            //let imageFile = PFFile(name:"itemImage", data:imageData!)
            saveImageLocally(imageData)

            
            shopItem["itemImage"] = NSNull()//imageFile
            
            shopItem["imageLocalPath"] = self.imagePath
            
            //shopItem["NewImage"] = imageFile
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
        
     //   dispatch_async(dispatch_get_main_queue(), {
        //shopItem["itemImage"] = imageFile
            
                //self.saveImageLocally(imageData)
               // shopItem["imageLocalPath"] = ""//self.imagePath
          //  })

      //  print(self.imagePath)
        //shopItem.saveInBackgroundWithBlock {
            //shopItem.pinInBackground()
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
        /*
            println("Id on local data store is \(shopItem.objectId)")
            if shopItem.objectId != nil {
                self.restore()
                self.newitemid = shopItem.objectId! //WOULDNT WORK
            } else {
                println("no id found")
            }
            */
        /*
        shopItem.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        */
           // shopItem.saveEventually()
        /* {
            //shopItem.saveInBackgroundWithBlock() {
          //  shopItem.pinInBackground() {
                //eventually means that it is saved offline first
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                //var dictionary = ["name" : shopItem["itemName"], "note": shopItem["itemNote"], "price": shopItem["itemPrice"]]
                self.restore()
               // println(shopItem.objectId)

            } else {
                // There was a problem, check error.description
                    }
                }
            */
        
        
        
        //New List Creation
        /*
        var shopList = PFObject(className:"ShopLists")
        
        shopList["ItemsInTheShopList"] = newitemsArray
        
        shopList.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println(newitemsArray)
                // The object has been saved.
                //let dictionary = ["name": number, "string": string]
                
            } else {
                // There was a problem, check error.description
            }
        }
        
    
        */
        
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
        
       // self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog]
       // dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImage2":itemimage2,"ItemUnit":itemunit,"ItemChecked":itemchecked,"ItemImagePath":itemimagepath,"ItemCategory":itemcategory,"ItemCategoryName":itemcategoryname]
       // itemsDataDict.append(newitemdictionary)
        
        itemsDataDict.append(newitemdictionary)
        
        shoppingcheckedtocopy.append(false)
        
        itemsorderarray.append(itemuuid)
        
        //self.receivedarrayofdicts.append(newitemdictionary)
       // println(self.receivedarrayofdicts)
        
        
        // now update the itemsintheshoplist field
        
       
        

        
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        
            let destination : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            // now this variable destinationVC holds everything that this VC comprises and can be used in shoplistcreation VC
            
        
                destination.justCreatedList = false
        
            
            
    
    }
 */
    /*
    func stepperValueChanged(stepper: Stepper) {
        println(stepper.value)
    }
   */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
      
        if segue.identifier == "showimagesfromadditem" {
            
            let popoverViewController = segue.destinationViewController as! ImagesCollectionVC//UIViewController
            
            
            popoverViewController.preferredContentSize = CGSize(width: 280, height: 380)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover//FullScreen //.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            popoverViewController.view.backgroundColor = UIColorFromRGBalpha(0xFAFAFA, alp: 1) // F7F7F7
            
            popoverViewController.delegate = self
            
        }
        
        
               
        if segue.identifier == "AddingDone" {
            
          //  let destinationVC : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
           // destinationVC.itemsDataDict = receivedarrayofdicts
            //here I pass the current lists id to product history tableViewController
            
            
            
        }
        
        if segue.identifier == "categoryPopover" {
           // let popoverViewController = segue.destinationViewController as! CategoryPopup//UIViewController
            
            let popoverViewController = segue.destinationViewController as! CategoryPopup
            //popoverViewController.preferredContentSize = CGSize(width: 300, height: 400)
            
           // popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
           // popoverViewController.popoverPresentationController!.delegate = self
            
            
            
            popoverViewController.delegate = self //WITHOUT THIS IT WONT WORK
            popoverViewController.cattext = self.categorybutton.titleForState(.Normal)
            //popoverViewController.delegate = self
         //   popoverViewController.sourceView = sender
            //popoverViewController.cattext = self.categorybutton.titleForState(.Normal)
            
           // popoverViewController.mDelegate = self
            
            
        }

        /*
        if segue.identifier == "DoneAddingItem" {
            let destination : ShoppingListCreation = segue.destinationViewController as! ShoppingListCreation
            
            destination.currentList = getcurrentlist
            

            //here I pass the current lists id to product history tableViewController
            
            
            
        }
*/
    }
    
    /*
    func category(name:String) {
         categorybutton.setTitle(name, forState: .Normal)
    }
*/
    
    ///for popover
    /*
    func choosecategory(categoryname:String, categoryimage:UIImage) {
        categorybutton.setTitle(categoryname, forState: .Normal)
        categoryimageoutlet.image = categoryimage
    }
*/
    
    func choosecategory(category:Category) {
       // categorybutton.setTitle(categoryname, forState: .Normal)
        //categoryimageoutlet.image = categoryimage
        
        categorybutton.setTitle(category.catname, forState: .Normal)
        categoryimageoutlet.image = category.catimage
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
        
       // let imageDataexisting = UIImagePNGRepresentation(self.itemImageOutlet.image)
        //let imageData = UIImagePNGRepresentation(chosenPicture)
        //let imageFileexisting = PFFile(name:"itemImage.png", data:imageDataexisting)
        
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
                
                //itemch["itemImage"] = NSNull()
                
                // })
                
                //image part
                //  dispatch_async(dispatch_get_main_queue(), {
               // self.saveImageLocally(imageDataexisting)
                //self.imagePath
                // })
                
                self.multiplication()
                
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
                itemch.pinInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Item saved")
                    
                    
                    // now update this item in itemsDataDict
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
                            if self.perUnitOutlet.titleForState(.Normal) == "Units" || self.UnitsButton.titleForState(.Normal) == "" {
                             itemsDataDict[i]["ItemPerUnit"] = ""
                            } else {
                            itemsDataDict[i]["ItemPerUnit"] = self.perUnitOutlet.titleForState(.Normal)
                            }
                            itemsDataDict[i]["UpdateDate"] = update
                            itemsDataDict[i]["ItemIsDefPict"] = self.isdefaultpicture
                            itemsDataDict[i]["ItemOriginalInDefaults"] = self.defaultpicturename
                            
                            //dictionary = ["ItemId":self.itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname]
                            
                            print(itemsDataDict[i])
                            
                        }
                    }
                    
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
                    
                    ////segue stuff 
                    if self.sendercontroller == "EditWithOptions" {
                        
                        if((self.withoptionsdelegete) != nil)
                        {
                            self.withoptionsdelegete?.refreshaddoptions()
                            
                            //refreshtable
                            
                        }
                        self.dismissViewControllerAnimated(true, completion: nil)
                        //self.performSegueWithIdentifier("gobacktoaddwithoptions", sender: self)
                        
                        
                    } else if self.sendercontroller == "ShopListCreation" {
                        
                        if((self.shopdelegate) != nil)
                        {
                            self.shopdelegate?.refreshtable()
                            //refreshtable in shoplist view!
                            
                        }
                        self.dismissViewControllerAnimated(true, completion: nil)
                       // self.performSegueWithIdentifier("gobacktocreationshoplist", sender: self)
                        
                    } else {
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                      //  self.performSegueWithIdentifier("gobacktocreationshoplist", sender: self) // FOR NOW
                        
                        
                    }
                    
                    ////
                    
                    
                } else {
                    // There was a problem, check error.description
                    }
                })
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
    
    
    
    func retrieveexistingitemfromdictionary(current:String) {
        
        for ( var i = 0; i < itemsDataDict.count; i++ ) {
            if itemsDataDict[i]["ItemId"] as? String == current {
                
                self.itemNameOutlet.text = itemsDataDict[i]["ItemName"] as! String
                self.itemNoteOutlet.text = itemsDataDict[i]["ItemNote"] as! String
                
               // ["ItemId":newitemid,"ItemName":itemName,"ItemNote":itemNote, "ItemQuantity":itemQty,"ItemTotalPrice":itemPrice,"ItemImagePath":itemimagepath,"ItemUnit":itemUnit,"ItemIsChecked":itemischecked,"ItemImage2":itemImage2,"ItemCategory":thisitemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname]

                
                self.itemiscatalog = itemsDataDict[i]["ItemIsCatalog"] as! Bool
                
               // self.itemisdefaultpict = itemsDataDict[i]["ItemIsDefPict"] as! Bool
                self.isdefaultpicture = itemsDataDict[i]["ItemIsDefPict"] as! Bool //if false then it is customimage, not defaults
                self.defaultpicturename = itemsDataDict[i]["ItemOriginalInDefaults"] as! String
                
                if self.itemiscatalog == true {
                    
                    self.categorybutton.enabled = false
                    self.chooseitemimageoutlet.enabled = false
                    self.itemNameOutlet.enabled = false
                    
                    self.categorybutton.alpha = 0.6
                    self.chooseitemimageoutlet.alpha = 0.6
                    self.itemNameOutlet.alpha = 0.6
                }
                
                
                //NOW EASIER JUST TO GET IMAGE FROM DICT
                self.itemImageOutlet.image = itemsDataDict[i]["ItemImage2"] as? UIImage
                
                //self.itemisfavourite = itemsDataDict[i]["ItemIsFav"] as! Bool
                self.isFavouriteItem = itemsDataDict[i]["ItemIsFav"] as! Bool
                
                
                if isFavouriteItem == true {
                   // favimage = UIImage(named: "FavStar.png") as UIImage!
                    additemtofav.setImage(favimage, forState: UIControlState.Normal)
                   // additemtofav.setTitle("Remove from favourites", forState: .Normal)
                   // additemtofav.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
                } else {
                   // notfavimage = UIImage(named: "GrayStar.png") as UIImage!
                    additemtofav.setImage(notfavimage, forState: UIControlState.Normal)
                   // additemtofav.setTitle("Add to favourites", forState: .Normal)
                    //additemtofav.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
                    }
                
                
                /*
                if self.itemiscatalog == true {
                    
                    self.categorybutton.enabled = false
                    self.chooseitemimageoutlet.enabled = false
                    self.itemNameOutlet.enabled = false
                    
                    var originalincatalog = itemsDataDict[i]["ItemOriginal"] as! String
                    
                    self.getcatalogitemimage(originalincatalog)
                    self.itemImageOutlet.image = self.catalogitemimage
                    
                } else {
                    // new approach to load image
                    self.loadImageFromLocalStore(itemsDataDict[i]["ItemImagePath"] as! String)
                    self.itemImageOutlet.image = self.imageToLoad
                    //
                    println("Custom Item")
                }
                */
                
                
             //PROBLEM!   self.itemPriceOutlet.text = String(stringInterpolationSegment: itemsDataDict[i]["itemPrice"] as! Double)
                //althouth I know how to handle this easy...just divide total sum by the quantity
                //self.itemPriceOutlet.text = String(stringInterpolationSegment: ((itemsDataDict[i]["ItemTotalPrice"] as! Double)/(NSNumberFormatter().numberFromString(itemsDataDict[i]["ItemQuantity"] as! String)!.doubleValue)))
                //workaround for now. if item quanity = 0 then Im fucked
                
               // self.itemPriceOutlet.text = String(stringInterpolationSegment: itemsDataDict[i]["ItemOneUnitPrice"] as! Double)
                
                if itemsDataDict[i]["ItemUnit"] as? String != "" {
                self.UnitsButton.setTitle(itemsDataDict[i]["ItemUnit"] as? String, forState: UIControlState.Normal)
                } else {
                     self.UnitsButton.setTitle(NSLocalizedString("units", comment: ""), forState: UIControlState.Normal)
                }
                
                if itemsDataDict[i]["ItemPerUnit"] as? String != "" {
                self.perUnitOutlet.setTitle(itemsDataDict[i]["ItemPerUnit"] as? String, forState: UIControlState.Normal)
                } else {
                     self.perUnitOutlet.setTitle(NSLocalizedString("units", comment: ""), forState: UIControlState.Normal)
                }
                
       
                
               // self.itemPriceOutlet.text = String(stringInterpolationSegment: itemsDataDict[i]["ItemOneUnitPrice"] as! Double)
                
              
                     //self.itemPriceOutlet.text = String(stringInterpolationSegment: itemsDataDict[i]["ItemOneUnitPrice"] as! Double)
                
                print(itemsDataDict[i]["ItemOneUnitPrice"])
                
                print(itemsDataDict[i]["ItemTotalPrice"])
               
                self.itemPriceOutlet.text = itemsDataDict[i]["ItemOneUnitPrice"] as! String
                
                self.Qfield.text = itemsDataDict[i]["ItemQuantity"] as! String
                
                self.totalsumlabel.text = itemsDataDict[i]["ItemTotalPrice"] as! String
                //self.totalsumlabel.text = String(stringInterpolationSegment: itemsDataDict[i]["ItemTotalPrice"] as! Double)
                
                
                
                
                
                self.itemcategoryUUID = itemsDataDict[i]["ItemCategory"] as! String
                
                // if category["isCustom"] as! Bool == true {
                if (self.itemcategoryUUID as NSString).containsString("custom") {
                    //CASE IF CATEGORY IS CUSTOM
                    /* ALREADY IN MENU I LOAD ALL CUSTOMCATS AND ADD THEM TO THE CATEGOIRES ARRAY, SO DON'T NEED WHAT IS BELOW
                    var querycat = PFQuery(className:"shopListsCategory")
                    querycat.fromLocalDatastore()
                    querycat.whereKey("categoryUUID", equalTo: self.itemcategoryUUID)//
                    querycat.getFirstObjectInBackgroundWithBlock() {
                        (category: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            println(error)
                        } else if let category = category {

                            //var thiscatimagepath: String = category["imagePath"] as! String
                            //println(thiscatimagepath)
                            //self.loadCatImageFromLocalStore(thiscatimagepath)

                            //println(self.catimageToLoad)

                            //var retrievedcat = Category(catId: self.itemcategoryUUID, catname: category["catname"] as! String, catimage: self.catimageToLoad, isCustom: category["isCustom"] as! Bool)
                            //self.itemcategory =
                            
                            
                            self.categorybutton.setTitle(retrievedcat.catname, forState: .Normal)
                            
                            self.categoryimageoutlet.image = retrievedcat.catimage

                        }
                        
                        
                        
                        
                    }
                    */
                   // if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), self.itemcategoryUUID) {
                    
                    if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(self.itemcategoryUUID) {
                    let catalogcategory = catalogcategories[foundcategory]
                    
                    print(catalogcategory)
                    
                    self.itemcategoryUUID = catalogcategory.catId
                    
                    self.categorybutton.setTitle(catalogcategory.catname, forState: .Normal)
                    
                    self.categoryimageoutlet.image = catalogcategory.catimage
                    }

                    
                } else {

                    
                    //if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), self.itemcategoryUUID) {
                    
                    if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(self.itemcategoryUUID) {
                    let catalogcategory = catalogcategories[foundcategory]
                        
                        print(catalogcategory)
                        
                        self.itemcategoryUUID = catalogcategory.catId
                        
                        self.categorybutton.setTitle(catalogcategory.catname, forState: .Normal)
                        
                        self.categoryimageoutlet.image = catalogcategory.catimage
                    }
                    
                    
                }
                
                
            } else {
                print("WHERE THE FUCK IS THIS ITEM?!")
            }
        }
    
        
    }
    
    /*
    func retrieveexistingitem(current:String) {
    
        var query = PFQuery(className:"shopItems")
        query.whereKey("itemUUID", equalTo: current)
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        //if let item = query.getObjectWithId(currentitem) {
            
        //just get object was calling an error of blicking main thread
        //query.getObjectInBackgroundWithId(currentitem) {
            
          //  (objects:PFObject?, error:NSError?) -> Void in
            
           // if let item: AnyObject = objects as? AnyObject {
        
        query.fromLocalDatastore()
        //query.getObjectInBackgroundWithId(current) {
        query.getFirstObjectInBackgroundWithBlock() {
            (item: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let item = item {
        
            
            self.itemNameOutlet.text = item["itemName"] as! String
            self.itemNoteOutlet.text = item["itemNote"] as! String
            
                /*
            item.objectForKey("itemImage")!.getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.itemImageOutlet.image = downloadedImage
                }
                
            }
            */
                
                // new approach to load image
               // self.loadImageFromLocalStore(item["imageLocalPath"] as! String)
               // self.itemImageOutlet.image = self.imageToLoad
                //
                
            self.itemiscatalog = item["isCatalog"] as! Bool
                
                if self.itemiscatalog == true {
                    
                    self.categorybutton.enabled = false
                    self.chooseitemimageoutlet.enabled = false
                    self.itemNameOutlet.enabled = false
                    
                    var originalincatalog = item["originalInCatalog"] as! String
                    
                    self.getcatalogitemimage(originalincatalog)
                    self.itemImageOutlet.image = self.catalogitemimage
                    
                } else {
                    // new approach to load image
                    self.loadImageFromLocalStore(item["imageLocalPath"] as! String)
                    self.itemImageOutlet.image = self.imageToLoad
                    //
                    println("Custom Item")
                }

                
            self.itemPriceOutlet.text = String(stringInterpolationSegment: item["itemPrice"] as! Double)
            
            self.UnitsButton.setTitle(item["itemUnit"] as? String, forState: UIControlState.Normal)
            
            self.totalsumlabel.text = String(stringInterpolationSegment: item["TotalSum"] as! Double)
            
            self.Qfield.text = item["itemQuantity"] as! String
                
                self.itemcategoryUUID = item["Category"] as! String
                
               // if category["isCustom"] as! Bool == true {
                if (self.itemcategoryUUID as NSString).containsString("custom") {
                //CASE IF CATEGORY IS CUSTOM
                var querycat = PFQuery(className:"shopListsCategory")
                querycat.fromLocalDatastore()
                querycat.whereKey("categoryUUID", equalTo: self.itemcategoryUUID)//
                querycat.getFirstObjectInBackgroundWithBlock() {
                    (category: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        println(error)
                    } else if let category = category {
                       // self.itemcategory = category as? Category
                       // if category["isCustom"] as! Bool == true {
                            //dispatch_async(dispatch_get_main_queue(), {
                            var thiscatimagepath: String = category["imagePath"] as! String
                        println(thiscatimagepath)
                        self.loadCatImageFromLocalStore(thiscatimagepath)
                                //})
                       // var catimageloaded = UIImage()
                            //var catimageloaded : UIImage = self.catimageToLoad
                        
                       // println(catimageloaded)
                        println(self.catimageToLoad)
                                
                            
                           //NOT SURE IF NEEDED self.itemcategoryUUID = category["categoryUUID"] as! String
                       var retrievedcat = Category(catId: self.itemcategoryUUID, catname: category["catname"] as! String, catimage: self.catimageToLoad, isCustom: category["isCustom"] as! Bool)
                        //self.itemcategory =
                            
                            self.categorybutton.setTitle(retrievedcat.catname, forState: .Normal)
                            
                            self.categoryimageoutlet.image = retrievedcat.catimage

                        
                       // self.categorybutton.setTitle(retrievedcat.catname, forState: .Normal)
                        
                        // self.categoryimageoutlet.image = retrievedcat.catimage
                   
                        // shopList.pinInBackground()
                        //shopList.saveInBackground()
                            }
                    
                    
                    
                    
                }
                
            } else {
                // CASE IF IT IS DEFAULT CATEGORY
                
                
                
                // Find this object of product type which has property catId = itemcategoryUUID
                
                if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), self.itemcategoryUUID) {
                    let catalogcategory = catalogcategories[foundcategory]
                    
                    println(catalogcategory)
                    
                    self.itemcategoryUUID = catalogcategory.catId
                    
                    self.categorybutton.setTitle(catalogcategory.catname, forState: .Normal)
                    
                    self.categoryimageoutlet.image = catalogcategory.catimage
                }
                
                
            }
            
          
            
                }
        
        }
    }
    */
    /*
     override func viewDidAppear(animated: Bool) {

        println(existingitem)
        println(currentitem)

        if existingitem == true {
            retrieveexistingitem(currentitem)
            ProductHistoryOutlet.hidden = true
            
            
        } else {
            ProductHistoryOutlet.hidden = false
        }
        
        
    }
*/
    
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
    /*
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var selectedRange: UITextRange = textField.selectedTextRange!
        var start: UITextPosition = textField.beginningOfDocument
        var cursorOffset = textField.offsetFromPosition(start, toPosition: selectedRange.start)
        // Update the string in the text input
        var currentString: NSMutableString = NSMutableString(string: textField.text)
        var currentLength: UInt = UInt(currentString.length)
        currentString.replaceCharactersInRange(range, withString: string)
        // Strip out the decimal seperator
        let r = NSRange(location: 0, length: currentString.length)
        currentString.replaceOccurrencesOfString(decimalSeparator as String, withString: "", options: NSStringCompareOptions.LiteralSearch, range: r)
        // Generate a new string for the text input
        var currentValue: Int = currentString.integerValue
        var format: NSString = NSString(format: "%%.%df", maximumFractionDigits)
        var minotUnitsPerMajor: Double = pow(10.00, Double(maximumFractionDigits))
        var m = Double(currentValue) / minotUnitsPerMajor
        var newString: NSString = NSString(format: format, m).stringByReplacingOccurrencesOfString(".", withString: decimalSeparator as String)
        if newString.length <= 7 {
            textField.text = newString as String
            // if the cursor was not at the end of the string being entered, restore cursor position
            if UInt(cursorOffset) != currentLength {
                var lengthDelta: Int = UInt(newString.length) - currentLength
                var newCursorOffset: Int = max(0, min(newString.length, cursorOffset + lengthDelta))
                var newPosition: UITextPosition = textField.positionFromPosition(textField.beginningOfDocument, offset: newCursorOffset)!
                var newRange = textField.textRangeFromPosition(newPosition, toPosition: newPosition)
                textField.selectedTextRange = newRange  
            }  
        }  
    }
    */
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
    /*
    var kbHeight: CGFloat!
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                self.animateTextField(true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    
    func animateTextField(up: Bool) {
        var movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    */
    //myTextField.delegate = self
    ///
    func closenumberpad(sender: UIButton) {
    itemPriceOutlet.resignFirstResponder()
    }
    
    func closenumberpad2(sender: UIButton) {
        Qfield.resignFirstResponder()
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
    
    
    @IBOutlet var categoryview: UIView!
   
    
    @IBOutlet var cancelbuttonoutlet: UIButton!
    
    
    @IBOutlet var changeconstr1: NSLayoutConstraint!

    @IBOutlet var changeconstr2: NSLayoutConstraint!
    
    
    @IBOutlet var curcodelabel: UILabel!
    
    
    @IBOutlet var changepictview: UIView!
    
    @IBOutlet var pictview: UIView!
    
    @IBOutlet var noteheight: NSLayoutConstraint!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            
            curcodelabel.text = symbol
           // if UIDevice().screenType == UIDevice.ScreenType.iPhone4 {
          //  if UIScreen.mainScreen().sizeType == .iPhone4 {
               if UIScreen.mainScreen().nativeBounds.height == 960 {
            
                noteheight.constant = 42
                changeconstr1.constant = 8
                changeconstr2.constant = 8
            }
            
            
         //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
            
          //  NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
            
            
            
            /*
            
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbar sizeToFit];
            numberTextField.inputAccessoryView = numberToolbar;
            
            
            */
            
           
            /*
            var numberToolbar2 = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
            
            let flexibleSpace2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            
            let done2: UIBarButtonItem = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Plain, target: self, action: "closenumberpad2:")
            done2.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!, NSForegroundColorAttributeName: UIColorFromRGB(0xFAFAFA)], forState: UIControlState.Normal)
            
            let toolbarButtons2 = [flexibleSpace2,done2]
            
            
            numberToolbar2.sizeToFit()
            numberToolbar2.translucent = true
            numberToolbar2.barTintColor = UIColorFromRGB(0x2A2F36)
            numberToolbar2.alpha = 1
            numberToolbar2.setItems(toolbarButtons2, animated: true)
            */
            
            
            
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
            
            /*
            var numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            numberFormatter.currencyCode = code
            maximumFractionDigits = numberFormatter.maximumFractionDigits
            decimalSeparator = numberFormatter.decimalSeparator!
            */
           // itemNameOutlet.layer.sublayerTransform = CATransform3DMakeTranslation(2, 0, 0)
            itemNameOutlet.leftTextMargin = 8
            
            itemNameOutlet.delegate = self
            itemNoteOutlet.delegate = self
            Qfield.delegate = self
            itemPriceOutlet.delegate = self
            
            
            self.view.backgroundColor = UIColorFromRGB(0xF1F1F1)
            
            
            cancelbuttonoutlet.layer.borderWidth = 1
            cancelbuttonoutlet.layer.borderColor = UIColorFromRGB(0xF23D55).CGColor
            cancelbuttonoutlet.layer.cornerRadius = 4
            
            changepictview.layer.borderWidth = 1
            changepictview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            changepictview.layer.cornerRadius = 4
            
            pictview.layer.borderWidth = 1
            pictview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            pictview.layer.cornerRadius = 4
           
            DoneButtonOutlet.layer.cornerRadius = 4
            
            amountview.layer.borderWidth = 1
            amountview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            amountview.layer.cornerRadius = 4
            
            categoryview.layer.borderWidth = 1
            categoryview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            categoryview.layer.cornerRadius = 4

            UnitsButton.layer.borderWidth = 1
            UnitsButton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            UnitsButton.layer.cornerRadius = 4
            
            perUnitOutlet.layer.borderWidth = 1
            perUnitOutlet.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            perUnitOutlet.layer.cornerRadius = 4
            
            itemNameOutlet.layer.borderWidth = 1
            itemNameOutlet.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            itemNameOutlet.layer.cornerRadius = 4
            
            itemNoteOutlet.layer.borderWidth = 1
            itemNoteOutlet.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            itemNoteOutlet.layer.cornerRadius = 4
           
           
            
            itemPriceOutlet.layer.borderWidth = 1
            itemPriceOutlet.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            itemPriceOutlet.layer.cornerRadius = 4
          
       // stepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: .ValueChanged)
        // Do any additional setup after loading the view.
        /*
        catalogcategories = [
            Category(catId:"DefaultOthers",catname:"Others",catimage:UIImage(named: "restau.png")!,isCustom:false),
            Category(catId:"DefaultVegetables",catname:"Vegetables",catimage:UIImage(named: "veg_icon.jpg")!,isCustom:false),
            Category(catId:"DefaultFruits",catname:"Fruits",catimage:UIImage(named: "fruits_icon.jpg")!,isCustom:false),
            Category(catId:"DefaultBeverages",catname:"Beverages",catimage:UIImage(named: "check.png")!,isCustom:false),
            Category(catId:"DefaultPoultry",catname:"Poultry",catimage:UIImage(named: "testimage.png")!,isCustom:false),
            Category(catId:"DefaultDomesticStuff",catname:"Domestic stuff",catimage:UIImage(named: "testimage.png")!,isCustom:false)
        ]
        */

        
       // categorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
        
       // categoryimageoutlet.image = catalogcategories[0].catimage
        
        
               print("Controller is \(sendercontroller)")
            
        print("LIST IS \(getcurrentlist)")
        print(existingitem)
        print(currentitem)
        
        if existingitem == true {
            //retrieveexistingitem(currentitem)
            retrieveexistingitemfromdictionary(currentitem)
           // ProductHistoryOutlet.hidden = true
                       
            
        } else {
           // ProductHistoryOutlet.hidden = false
          //  pricevalue = 0
          //  newvalue = 0
            
            itemcategory = catalogcategories[0]
            itemcategoryUUID = catalogcategories[0].catId
            categorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
            
            categoryimageoutlet.image = catalogcategories[0].catimage
            
            self.isFavouriteItem = false
            self.UnitsButton.setTitle(NSLocalizedString("units", comment: ""), forState: .Normal)
            self.perUnitOutlet.setTitle(NSLocalizedString("units", comment: ""), forState: .Normal)
            
            
            
            isdefaultpicture = true
           // defaultpicturename = imagestochoose[0].imagename

            
        }
        /*
        if isFavouriteItem == true {
            favimage = UIImage(named: "FavStar.png") as UIImage!
            additemtofav.setImage(favimage, forState: UIControlState.Normal)
            additemtofav.addTarget(self, action: "delfromfav:", forControlEvents: .TouchUpInside)
        } else {
            notfavimage = UIImage(named: "GrayStar.png") as UIImage!
            additemtofav.setImage(notfavimage, forState: UIControlState.Normal)
            additemtofav.addTarget(self, action: "addtofav:", forControlEvents: .TouchUpInside)
        }
        */
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ///// ALERT CODE
    func showPickerInActionSheet(sentBy: UIButton!) {
        // func showPickerInActionSheet() {
        let title = ""
        let message = "\n\n\n\n\n\n\n\n\n\n";
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet);
        alert.modalInPopover = true;
        
        // height was 80
        //Create a frame (placeholder/wrapper) for the picker and then create the picker
        let pickerFrame: CGRect = CGRectMake(17, 42, 270, 120); // CGRectMake(left), top, width, height) - left and top are like margins //17 52 270 80
        let picker: UIPickerView = UIPickerView(frame: pickerFrame);
        picker.backgroundColor = UIColor.clearColor()//UIColorFromRGBalpha(0xFAFAFA, alp: 1)

/* If there will be 2 or 3 pickers on this view, I am going to use the tag as a way
to identify them in the delegate and datasource.  This part with the tags is not required.
I am doing it this way, because I have a variable, witch knows where the Alert has been invoked from. */
        
if(sentBy.tag == 77) {
picker.tag = 1;
} else if (sentBy.tag == 78) {
picker.tag = 2;
} else {
picker.tag = 1;
}
// I decided to mark two buttons with tags 77 and 78 to distinguish them

//set the pickers datasource and delegate
picker.delegate = self
picker.dataSource = self

//Add the picker to the alert controller
alert.view.addSubview(picker);

//Create the toolbar view - the view witch will hold our 2 buttons
//let toolFrame = CGRectMake(17, 5, 270, 45);
        let toolFrame = CGRectMake(0, 2, alert.view.frame.size.width, 46);
let toolView: UIView = UIView(frame: toolFrame);
        
        
//close this view?
        
        

//add buttons to the view
//let buttonCancelFrame: CGRect = CGRectMake(0, 7, 100, 30); //size & position of the button as placed on the toolView
        
        let buttonCancelFrame: CGRect = CGRectMake(toolView.frame.size.width - 82, 2, 56, 42); //size & position of the button as placed on the toolView
        
        //Create the cancel button & set its title
       // let closepad: UIButton = UIButton(frame: buttonCancelFrame);


//Create the cancel button & set its title
let buttonCancel: UIButton = UIButton(frame: buttonCancelFrame);
        //buttonCancel.imageEdgeInsets = UIEdgeInsetsMake(0,35,0,35);
//buttonCancel.setTitle("Cancel", forState: UIControlState.Normal);
//buttonCancel.setTitleColor(UIColorFromRGB(0xF23D55), forState: UIControlState.Normal);
buttonCancel.setImage(closepadimage, forState: UIControlState.Normal)
        
toolView.addSubview(buttonCancel); //add it to the toolView

//Add the target - target, function to call, the event witch will trigger the function call
//buttonCancel.addTarget(self, action: "cancelSelection:", forControlEvents: UIControlEvents.TouchDown);


//add buttons to the view
//let buttonOkFrame: CGRect = CGRectMake(190, 7, 30, 30); //size & position of the button as placed on the toolView
  //      let buttonOkFrame: CGRect = CGRectMake(190, 7, 100, 30);

//Create the Select button & set the title
//let buttonOk: UIButton = UIButton(frame: buttonOkFrame);
//        buttonOk.imageEdgeInsets = UIEdgeInsetsMake(0,35,0,35)
//buttonOk.setTitle("Submit", forState: UIControlState.Normal);
//buttonOk.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal);
//buttonOk.setImage(submitimage, forState: UIControlState.Normal)
//toolView.addSubview(buttonOk); //add to the subview

//Add the tartget. In my case I dynamicly set the target of the select button
if(sentBy.tag == 77 ){
buttonCancel.addTarget(self, action: "saveUnit:", forControlEvents: UIControlEvents.TouchDown);
} else if (sentBy.tag == 78){
buttonCancel.addTarget(self, action: "savePerUnit:", forControlEvents: UIControlEvents.TouchDown);
}

//add the toolbar to the alert controller
alert.view.addSubview(toolView);

self.presentViewController(alert, animated: true, completion: nil);
        
        //
        
        
        
}

func saveUnit(sender: UIButton){
// Your code when select button is tapped
   
   // unit = buttontitle
    UnitsButton.setTitle(buttontitle, forState: UIControlState.Normal)
    perUnitOutlet.setTitle(buttontitle, forState: UIControlState.Normal)
    multiplication()
    print("SaveUnit")
    self.dismissViewControllerAnimated(true, completion: nil)
}
    
func savePerUnit(sender: UIButton){
        // Your code when select button is tapped
        
        // unit = buttontitle
        perUnitOutlet.setTitle(perbuttontitle, forState: UIControlState.Normal)
        print("SaveUnit")
        multiplication()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

func saveUser(sender: UIButton){
// Your code when select button is tapped
}

func cancelSelection(sender: UIButton){
print("Cancel");
self.dismissViewControllerAnimated(true, completion: nil);
// We dismiss the alert. Here you can add your additional code to execute when cancel is pressed
}

    /*
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        
    }
    */
    
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
// returns number of rows in each component..
func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
/*
    if(pickerView.tag == 1){
return self.profilesList.count;
} else if(pickerView.tag == 2){
return self.usersList.count;
} else  {
return 0;
}
*/
    return units.count
}
    
    

// Return the title of each row in your picker ... In my case that will be the profile name or the username string
func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//if(pickerView.tag == 1){

//var selectedProfile: Profiles = self.profilesList[row] as Profiles;
//return selectedProfile.profileName;

//} else if(pickerView.tag == 2){

//var selectedUser: Users = self.usersList[row] as Users;
//return selectedUser.username;

//} else  {

//return "";

//}
    return units[row][0]//[1]
}

func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {/*
if(pickerView.tag == 1){
var choosenProfile: Profiles = profilesList[row] as Profiles;
self.selectedProfile = choosenProfile.profileName;
} else if (pickerView.tag == 2){
var choosenUser: Profiles = usersList[row] as Users;
self.selectedUsername = choosenUser.username;
}
*/
    if(pickerView.tag == 1){
    buttontitle = units[row][1]
    UnitsButton.setTitle(buttontitle, forState: UIControlState.Normal)
    } else if (pickerView.tag == 2){
        perbuttontitle = units[row][1]
        perUnitOutlet.setTitle(perbuttontitle, forState: UIControlState.Normal)
    }
    
    if buttontitle == perbuttontitle {
        nomatchlabel.hidden = true
    }
    }

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
