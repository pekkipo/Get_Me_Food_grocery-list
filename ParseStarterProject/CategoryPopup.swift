//
//  CategoryPopup.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 10/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation

/*
protocol CategoryPopupDelegate
{
    func choosecategory(categoryname : String, categoryimage: UIImage)
}
*/
protocol CategoryPopupDelegate
{
    func choosecategory(category:Category)
}
/*
protocol MyProtocol
{
    func category(name:String)
}
*/
var shopcategory = Dictionary<String,AnyObject>()
var shopcategories = [Dictionary<String,AnyObject>()]

var defaultcatmage:UIImage = UIImage(named: "check.png")!
//"/CatImages/fruits_icon.jpg"

//var catalogcategories = [Category]()
/*
var customcategories = [Category]()

var catalogcategories = [
    Category(catId:"DefaultOthers",catname:"Others",catimage:UIImage(named: "restau.png")!,isCustom:false),
    Category(catId:"DefaultVegetables",catname:"Vegetables",catimage:UIImage(named: "veg_icon.jpg")!,isCustom:false),
    Category(catId:"DefaultFruits",catname:"Fruits",catimage:UIImage(named: "fruits_icon.jpg")!,isCustom:false),
    Category(catId:"DefaultBeverages",catname:"Beverages",catimage:UIImage(named: "check.png")!,isCustom:false),
    Category(catId:"DefaultPoultry",catname:"Poultry",catimage:UIImage(named: "testimage.png")!,isCustom:false),
    Category(catId:"DefaultDomesticStuff",catname:"Domestic stuff",catimage:UIImage(named: "testimage.png")!,isCustom:false)
]
*/

class CategoryPopup: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate, ImagesPopupDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    
    var delegate : CategoryPopupDelegate?
    
    var defaultpict = Bool()
    var originalindefaults = String()
    
    func choosecollectionimage(pict: UIImage, defaultpicture: Bool, picturename: String?) {
        
        self.newcustomcategoryimage.image = pict
        defaultpict = defaultpicture
        if picturename != nil {
            originalindefaults = picturename!
        } else {
            originalindefaults = ""
        }
        
    }
    
    
    //// NEW STUFF FOR IMAGE PICKING
    
    @IBOutlet var newcustomcategoryimage: UIImageView!
    
    @IBOutlet var newcustomcategoryname: CustomTextField!//UITextField!
    
    @IBAction func newcustomcategoryadd(sender: AnyObject) {
        
        let newcatuuid = NSUUID().UUIDString
        let newcatid = "custom\(newcatuuid)"
        
        let newcategory = Category(catId: newcatid, catname: newcustomcategoryname.text!, catimage: newcustomcategoryimage.image!, isCustom: true, isAllowed: true)
        
        //catalogcategories.append(newcategory)
        newcategory.addCategory(newcategory, isdefaultpict: defaultpict, defaultpictname: originalindefaults)
        
        
        //Now I need to store category in Parse
        // var customcategory = PFObject(className:"shopListsCategory")
        
        //var catuuid = NSUUID().UUIDString
        
       // JSSAlertView().show(self, title: "Added!")
        
        tableViewScrollToBottom(true)
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
        // SCRIPT FOR scroll here and view fade out!
        
        tableView.reloadData()

    }
    
    @IBOutlet var addedindicator: UIView!
    
   
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    
    @IBOutlet var newcustomcategorychooseimage: UIButton!
    
    @IBAction func newchooseimage(sender: AnyObject) {
        /*
        var chosenimage = UIImagePickerController()
        chosenimage.delegate = self//self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = false
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
        */
        
        //showimagesfromcats
        performSegueWithIdentifier("showimagesfromcats", sender: self)
        
    }
    
   
    @IBAction func taponimage(sender: AnyObject) {
        
        performSegueWithIdentifier("showimagesfromcats", sender: self)
    }
    
    
  //  var categoriessearchresult:Array<Category>?
    
    var filteredcategories = [Category]()
    var shouldShowSearchResults = false
    
    //var mDelegate:MyProtocol?
    
    var cattext : String?
    
    //var chosenitemname = String()
    //var chosenitemimage = UIImage()
    
    var chosencategory:Category?
    
    var chosenPicture = UIImage()
    
    var imageToLoad = UIImage()
    
    var customcategory : Category?
    
    var customCatsIds = [String]()
    
    //var customImagePaths = [String]()//object["imagePath"] as! String
    
    /*
    struct Category {
        
        var catname = String()
        var catimage = UIImage()
        var isCustom = Bool()
        
        func addCategory() {
            
            shopcategory = ["CatName":catname,"CatImage":catimage,"CatCustom":isCustom]
            shopcategories.append(shopcategory)
            }
        
    }
    */
   
    
    @IBOutlet var customview: UIView!

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func DoneButton(sender: UIButton!) {
        /*
        if((self.delegate) != nil)
        {
           // delegate?.choosecategory(categoryname.text);
            //delegate?.choosecategory(chosenitemname, categoryimage: chosenitemimage)//(categoryname.text)
            if chosencategory != nil {
            delegate?.choosecategory(chosencategory!)
            } else {
                chosencategory = catalogcategories[0]
                delegate?.choosecategory(chosencategory!)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
*/
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //// SEARCH STUFF 
    
    func configureCustomSearchController() {
       // customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 30.0), searchBarFont: UIFont(name: "HelveticaNeue-Light", size: 16.0)!, searchBarTextColor: UIColorFromRGB(0x31797D), searchBarTintColor: UIColorFromRGB(0xEFEFEF))
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 40.0), searchBarFont: UIFont(name: "Avenir-Book", size: 14.0)!, searchBarTextColor: UIColorFromRGB(0x61C791), searchBarTintColor: UIColorFromRGB(0x2A2F36))
        
        customSearchController.customSearchBar.placeholder = NSLocalizedString("SearchCat", comment: "")
        tableView.tableHeaderView = customSearchController.customSearchBar
        customSearchController.customDelegate = self
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = NSLocalizedString("Search2", comment: "")
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    
    func didStartSearching() {
       // let searchString = searchController.searchBar.text
        //if searchString.isEmpty == true {
        //    shouldShowSearchResults = false
        //    tableView.reloadData()
      //  } else {
        filteredcategories.removeAll(keepCapacity: true)
        
        filteredcategories.appendContentsOf(catalogcategories)
        shouldShowSearchResults = true
        tableView.reloadData()
        print(filteredcategories)
       // tableView.reloadData() // AT LEAST NOW IT DOESNT'T DISAPPEAR IMMEDIATELY
       // }
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            print(filteredcategories)
            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        print(filteredcategories)
        tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        
        filteredcategories.removeAll(keepCapacity: true)
        
        filteredcategories = catalogcategories.filter({ (category:Category) -> Bool in
            let categoryText: NSString = category.catname
            print(self.filteredcategories)
            return (categoryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        /*
        if searchText.isEmpty == true {
            self.shouldShowSearchResults = false
        } else {
            self.shouldShowSearchResults = true
        }
        */
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text
        
       // if searchString.isEmpty == true {
         //   shouldShowSearchResults = false
           // tableView.reloadData()
       // } else {
        /*
        guard let searchString = searchController.searchBar.text where searchString.isEmpty == false else {
            shouldShowSearchResults = false
            tblSearchResults.reloadData()
            return
        }
        */
        // Filter the data array and get only those countries that match the search text.
      
        
        filteredcategories = catalogcategories.filter({ (category : Category) -> Bool in
            
            let categoryText: NSString = category.catname
            print(self.filteredcategories)
           
            return (categoryText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
        //}
    }
    
    //// END OF SEARCH STUFF
    
    
    override func viewDidAppear(animated: Bool) {
       // customcategories.removeAll(keepCapacity: true)
    }
   
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // 
        newcustomcategoryname.delegate = self
        
        addedindicator.alpha = 0
        addedindicator.layer.cornerRadius = 8
        addedindicator.backgroundColor = UIColorFromRGB(0x2a2f36)
        
        //newcustomcategoryname.layer.sublayerTransform = CATransform3DMakeTranslation(3, 0, 0)
       newcustomcategoryname.leftTextMargin = 5
      //  newcustomcategoryname.layer.borderColor = UIColorFromRGB(0x9A9A9A).CGColor
        
        //configureSearchController()
        configureCustomSearchController()
        
        
        defaultpict = true
        originalindefaults = "DefaultProduct"//"plus.png" //defaultpicture!
        
        print(catalogcategories)
        print(customcategories)
        
       // retrievecustomcategories()
        
       // addcustomstocategories(customcategories)
        
         //catalogcategories.extend(customcategories)
        
        
        //customview.layer.borderWidth = 1
        //customview.layer.borderColor = UIColorFromRGB(0x9A9A9A).CGColor
        
        print(catalogcategories)
        print(catalogcategories[0].catname)
        print(catalogcategories[1].catname)
        print(catalogcategories[2].catname)
        
        
        
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
        
        // Do any additional setup after loading the view.
       // categoryname.text = cattext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
       // if shouldShowSearchResults == true {
        //    return 1
       // } else {
       // return 2
       // }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if shouldShowSearchResults {
          
                return filteredcategories.count 
          
        } else {
        
       // if (section == 1) {
            return catalogcategories.count//3
            
            
            
          //  } else {
           //     return 1
           // }
        }
    }
    
    /*
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
       // if (section == 1)
      //  {
        //    return "Catalog categories"
       // }
        return NSLocalizedString("exccats", comment: "")
    }
    */
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        /*
        if shouldShowSearchResults == false {
        
            if (indexPath.section == 0) {
            
                return 90
                } else {
                return 45
            }
            
            
        } else {
            return 45
        }*/
        return 45
//Choose your custom row height
    }
    /*
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 30.0

        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColorFromRGB(0xEFEFEF)//UIColor(red: 238/255, green: 168/255, blue: 15/255, alpha: 0.8)
        header.textLabel!.textColor = UIColorFromRGB(0x31797D)//UIColor.whiteColor()
        //header.textLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
        header.alpha = 1
        
        //var topline = UIView(frame: CGRectMake(0, 0, header.contentView.frame.size.width, 1))
        //topline.backgroundColor = UIColorFromRGB(0x31797D)
        
       // header.contentView.addSubview(topline)
        
        let bottomline = UIView(frame: CGRectMake(0, 30, header.contentView.frame.size.width, 1))
        bottomline.backgroundColor = UIColorFromRGB(0x31797D)
        
        header.contentView.addSubview(bottomline)
    }
    */
    
   // func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!, sender: UIButton!) {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
        self.dismissViewControllerAnimated(true, completion:nil)
        
      /*  let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! CategoryCell
        cell.newcategoryimage.image = chosenimage
        */
        self.newcustomcategoryimage.image = chosenimage

        
        //chosenPicture = chosenimage
        
        
    }

    
   
    
    func chooseimage(sender: UIButton!) {//(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! CategoryCell
        
        let chosenimage = UIImagePickerController()
        chosenimage.delegate = self//self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = false
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
        
    }
    /*
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
        
        return UIImage(named: "restau.png")!
    }
    */
    func contains(values: [String], element: String) -> Bool {
        // Loop over all values in the array.
        for value in values {
            // If a value equals the argument, return true.
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    

    func containscategory(values: [Category], element: Category) -> Bool {
        // Loop over all values in the array.
        for value in values {
            // If a value equals the argument, return true.
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    


    
    func addcustomstocategories(customlist: [Category]) -> [Category] {
        
        //retrievecustomcategories()
        
        catalogcategories.appendContentsOf(customlist)
        
        return catalogcategories
    }
    
    
    
    /*
    func retrievecustomcategories() {
        //DO THE WHOLE STUFF IN PREVIOUS VC
        
        
       // customCatsIds.removeAll(keepCapacity: true)
        //MOST PROBABLY NEED JUST TO CLEAN THE ARRAY HERE
        var query = PFQuery(className:"shopListsCategory")
        query.fromLocalDatastore()
        query.whereKey("CatbelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                 self.customCatsIds.removeAll(keepCapacity: true)
                
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                      
                        var customId = object["categoryUUID"] as! String
                        var customName = object["catname"] as! String
                        var customIs = object["isCustom"] as! Bool
                        var customImagePath = object["imagePath"] as! String
                        var customIsAllowed = object["ShouldShowInCatalog"] as! Bool
                        var customImage = UIImage()
                        //customImage
                        
                        self.loadImageFromLocalStore(customImagePath)
                       // var customImage = UIImage()
                        //image part
                        object["catimage"]!.getDataInBackgroundWithBlock { (data, error) -> Void in
                            if let downloadedImage = UIImage(data: data!) {
                                customImage = downloadedImage
                            }
                            
                        }
                        
                        
                        println("image is \(self.imageToLoad)")
                        self.customCatsIds.append(customId)
                        
                        //var customcategory = Category(catId: customId, catname: customName, catimage: customImage, isCustom: customIs)
                        //self.customcategory = Category(catId: customId, catname: customName, catimage: UIImage(named: "restau.png")!, isCustom: customIs, isAllowed: customIsAllowed)
                        self.customcategory = Category(catId: customId, catname: customName, catimage: self.imageToLoad, isCustom: customIs, isAllowed: customIsAllowed)
                        
                        println(self.customcategory)
                        
                       // if contains(customcategories, customcategory) {
                       //     println("contains")"
                      //  } else {
                            
                      //  }
                        
                        //if self.contains(self.customCatsIds, element: customId) {
                        if self.containscategory(catalogcategories, element: self.customcategory!) {
                            println("contains")
                        } else {
                        
                        customcategories.append(self.customcategory!)
                        }

                       // customcategories.append(self.customcategory!)

                        
                    }
                    
                    
                }
                
               // catalogcategories.extend(customcategories)
                println(customcategories)
                
                self.addcustomstocategories(customcategories)
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        println(customcategories)
        
       // catalogcategories.extend(customcategories)
       // println(customcategories)
        
        //return customcategories//catalogcategories
    }
    */
    
    func addcustomcategory(sender: UIButton!) {
        
        let button = sender as UIButton
        let view = button.superview!
        let cell = view.superview as! CategoryCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let newcatuuid = NSUUID().UUIDString
        let newcatid = "custom\(newcatuuid)"
        
        
        
        var newcategory = Category(catId: newcatid, catname: cell.newcategoryname.text!, catimage: cell.newcategoryimage.image!, isCustom: true, isAllowed: false)
        
        //catalogcategories.append(newcategory)
       // newcategory.addCategory(newcategory, defaultpict: de)
        
        
        //Now I need to store category in Parse
       // var customcategory = PFObject(className:"shopListsCategory")
        
        //var catuuid = NSUUID().UUIDString

       // JSSAlertView().show(self, title: "Added!")
        
        // FADE OUT AND SCROLL
        
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       // var customcell: CategoryCell!
        var catcell: CategoriesCell!
        
            if shouldShowSearchResults == false {
        

            catcell = tableView.dequeueReusableCellWithIdentifier("CatalogCategoryCell", forIndexPath: indexPath) as! CategoriesCell // just return the cell without any changes to show whats designed in storyboard
            
            catcell.catalogCatName.text = catalogcategories[indexPath.row].catname
            catcell.catalogCatImage.image = catalogcategories[indexPath.row].catimage
            
            if catalogcategories[indexPath.row].isCustom == true {
               // catcell.catalogCustom.text = "Custom"
                catcell.catalogcustom.hidden = false
            } else {
               // catcell.catalogCustom.text = ""
                catcell.catalogcustom.hidden = true
            }
            
        
     
            return catcell
     
        
            } else {
                //if search is active
                catcell = tableView.dequeueReusableCellWithIdentifier("CatalogCategoryCell", forIndexPath: indexPath) as! CategoriesCell // just return the cell without any changes to show whats designed in storyboard
                
                catcell.catalogCatName.text = filteredcategories[indexPath.row].catname
                catcell.catalogCatImage.image = filteredcategories[indexPath.row].catimage
                
                if filteredcategories[indexPath.row].isCustom == true {
                   catcell.catalogcustom.hidden = false
                } else {
                    catcell.catalogcustom.hidden = true
                }
        
                
                return catcell
        }
        

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        if indexPath.section == 2 {
        
        }
        */
        
       // chosenitemname = catalogcategories[indexPath.row].catname
       // chosenitemimage = catalogcategories[indexPath.row].catimage
        if shouldShowSearchResults == true {
            
            chosencategory = filteredcategories[indexPath.row]
            
           // chosencategoryname.text = filteredcategories[indexPath.row].catname
            
            
        } else {
        
        chosencategory = catalogcategories[indexPath.row]
        
       // chosencategoryname.text = catalogcategories[indexPath.row].catname
            
        }
        
        /// immediately choose and close window
        if((self.delegate) != nil)
        {

            if chosencategory != nil {
                delegate?.choosecategory(chosencategory!)
            } else {
                chosencategory = catalogcategories[0]
                delegate?.choosecategory(chosencategory!)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }

        ////
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //println(self.shoppingListItemsIds[row])
    }

    //showimagesfromcats
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showimagesfromcats" {
            
            let popoverViewController = segue.destinationViewController as! ImagesCollectionVC//UIViewController
            
            
            popoverViewController.preferredContentSize = CGSize(width: 266, height: 380)
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            
            
            popoverViewController.delegate = self
            
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
