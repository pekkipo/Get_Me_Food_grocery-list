//
//  LanguagesVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 11/01/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

var languages : [String] = [
    "English",
    "Русский",
    "Deutsch",
    "Español",
    "Português",
    "Français",
    "中文",
    "Suomi",
    "भारतीय"
]

var flags : [UIImage] = [
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!,
    UIImage(named: "check.png")!

]

class LanguagesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    
    
    
    //// TABLE STUFF
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
    
        return languages.count
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        return nil
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
        
        var cell: LanguageCell!

        cell = tableView.dequeueReusableCellWithIdentifier("languagecell", forIndexPath: indexPath) as! LanguageCell
        
        cell.langname.text = languages[indexPath.row]
        cell.flag.image = flags[indexPath.row]
     
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(languages[indexPath.row])
        
    }
    
    ////

    override func viewDidLoad() {
        super.viewDidLoad()

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
