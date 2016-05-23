//
//  OpenSettingsController.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 02/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation

class OpenSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    //@IBOutlet var tableView   : UITableView!
   
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var dimmerView: UIView!
    
    
    var items : [NavigationModel]!
    var snapshot : UIView = UIView()
    var transitionOperator = TransitionOperator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        
        dimmerView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        bgImageView.image = UIImage(named: "karaokeattached.png")
        
        let item1 = NavigationModel(title: "SETTINGS", icon: "check.png")
        let item2 = NavigationModel(title: "TO DO LISTS", icon: "plus.png", count: "3")
        let item3 = NavigationModel(title: "SHOPPING LISTS", icon: "imp.png")
        let item4 = NavigationModel(title: "SHOW ALL LISTS", icon: "GrayStar.png")
        let item5 = NavigationModel(title: "ABOUT", icon: "FavStar.png")
        
        items = [item1, item2, item3, item4, item5]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("setcell") as! settingscell
        let item = items[indexPath.row]
        
        cell.settingsname.text = item.title
        cell.countLabel.text = item.count
        cell.settingimage.image = UIImage(named: item.icon)
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.snapshot.removeFromSuperview()
        
        if (indexPath.row % 2 == 0){
            performSegueWithIdentifier("ShowAllLists", sender: self)
        }else{
            performSegueWithIdentifier("ShowAllLists", sender: self)
        }
    }
    
    func finalizeTransitionWithSnapshot(snapshot: UIView){
        self.snapshot = snapshot
        view.addSubview(self.snapshot)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let toViewController = segue.destinationViewController as! UITableViewController
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self.transitionOperator
    }
}

class NavigationModel {
    
    var title : String!
    var icon : String!
    var count : String?
    
    init(title: String, icon : String){
        self.title = title
        self.icon = icon
    }
    
    init(title: String, icon : String, count: String){
        self.title = title
        self.icon = icon
        self.count = count
    }
}
