//
//  CatalogTableViewController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 19/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation
import Parse

class CatalogTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!

    
    var shoplistdelegate : RefreshListDelegate?
    var shoplistoptinsdelegate : RefreshAddWithOptions?
    
    var currentcataloglist = String()
    
    var tappedcategory : Category?
   // var tappedcategory : String?
    var tappedcategoryindex = Int()
    
    //RESTRAIN ARRAY ONLY FOR DEFAULT CATALOG CATEGORIES
    
    var newcatalogcategories = [Category]()
    
    var filteredcategories = [Category]()
    var shouldShowSearchResults = false
    
    ////// SEARCH STUFF 
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    @IBAction func showsearch(sender: AnyObject) {
        
        configureCustomSearchController()
    }
    
    
    func configureCustomSearchController() {
      customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 40.0), searchBarFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!, searchBarTextColor: UIColorFromRGB(0x61C791), searchBarTintColor: UIColorFromRGB(0x2A2F36))
        
        customSearchController.customSearchBar.placeholder = NSLocalizedString("Search1", comment: "Search")
        tableView.tableHeaderView = customSearchController.customSearchBar
        customSearchController.customDelegate = self
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = NSLocalizedString("Search2", comment: "Search")
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
        shouldShowSearchResults = true
        filteredcategories.appendContentsOf(newcatalogcategories)
        tableView.reloadData()
        // println(filteredcategoryitems)
       // tableView.reloadData() // AT LEAST NOW IT DOESNT'T DISAPPEAR IMMEDIATELY
        // }
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            // println(filteredcategoryitems)
            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        // println(filteredcategoryitems)
        tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredcategories.removeAll(keepCapacity: true)
        
        filteredcategories = newcatalogcategories.filter({ (category:Category) -> Bool in
            let catText: NSString = category.catname
            
            return (catText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
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
        /*
        if searchString.isEmpty == true {
            shouldShowSearchResults = false
            // tableView.reloadData()
        } else {
          */
            
            // Filter the data array and get only those countries that match the search text.
            
            
            filteredcategories = newcatalogcategories.filter({ (category:Category) -> Bool in
                
                let catText: NSString = category.catname
                
                
                return (catText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
            })
            
            // Reload the tableview.
            tableView.reloadData()
        //}
    }
    
    //// END OF SEARCH STUFF

    
    
    
    
    
    func onlydefaults() { /// AND CUSTOMS ALLOWED TO BE SHOWN
        
        for category in catalogcategories {
            if (category.catId as NSString).containsString("Default")  || (category.isAllowed != nil && category.isAllowed == true) {//(category.isAllowed != nil) &&(category.isAllowed == true)
                //&& !(category.catId as NSString).containsString("custom") { //ADD HERE CONDITION THAT custom cat shouldshowincat == true
                
                newcatalogcategories.append(category)
                
            } else {
                print("This is custom category!")
            }
        
        }
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        
        if segue.identifier == "showsubcatalog" {
            
            //let subcatalogNav = segue.destinationViewController as! UINavigationController
            
            //let subcatalogVC = subcatalogNav.viewControllers.first as! SubCatalogTableViewController
            
            let subcatalogVC = segue.destinationViewController as! SubCatalogTableViewController
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                
               // destinationVC.activeList = ListsIds[indexPath.row]
                
                if shouldShowSearchResults == false {
            
            subcatalogVC.currentcategory = newcatalogcategories[indexPath.row]//catalogcategories[indexPath.row]
            subcatalogVC.currentsubcataloglist = currentcataloglist
                } else {
                subcatalogVC.currentcategory = filteredcategories[indexPath.row]
                subcatalogVC.currentsubcataloglist = currentcataloglist
                }
           // subcatalogVC.currentcategoryindex = tappedcategoryindex
            
            }
            
            subcatalogVC.shopdelegate = shoplistdelegate
            subcatalogVC.withoptionsdelegete = shoplistoptinsdelegate
        }
    
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //// LOAD FUNCTION THAT GETS ALL CUSTOM CATEGORIES HERE!
        
        onlydefaults()
        
       // configureCustomSearchController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        //TRY TO RESTRAIN THE ARRAY ONLY TO DEFAULT ITEMS
        
        if shouldShowSearchResults {
            
            return filteredcategories.count
            
        } else {
        
        return newcatalogcategories.count
        }
        //return catalogcategories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("catalogcell", forIndexPath: indexPath) as! CatalogCell
        
       // cell.catalogcategoryimage.image = catalogcategories[indexPath.row].catimage
        // cell.categoryname.text = catalogcategories[indexPath.row].catname
        
        if shouldShowSearchResults == false {

         cell.catalogcategoryimage.image = newcatalogcategories[indexPath.row].catimage
         cell.categoryname.text = newcatalogcategories[indexPath.row].catname
        } else {
            cell.catalogcategoryimage.image = filteredcategories[indexPath.row].catimage
            cell.categoryname.text = filteredcategories[indexPath.row].catname
        }
        // Configure the cell...

        return cell
    }
/*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tappedcategory = catalogcategories[indexPath.row]
        //tappedcategory = catalogcategories[indexPath.row].catId
        tappedcategoryindex = indexPath.row
    }
*/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
