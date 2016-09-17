//
//  HelpNew.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 09/02/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class HelpNew: UIViewController {
    
   
    
    @IBOutlet var textview: UITextView!
    

    
    var thistext = String()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if thistext == "howcreateshopitemT" {
            
            textview.text = NSLocalizedString("howcreateshopitemT", comment: "")
            
        } else if thistext == "howedititemT" {
            
            textview.text = NSLocalizedString("howedititemT", comment: "")
        } else if thistext == "howcreatetodoitemT" {
            
            textview.text = NSLocalizedString("howcreatetodoitemT", comment: "")
        } else if thistext == "howedittodoitemT" {
            
            textview.text = NSLocalizedString("howedittodoitemT", comment: "")
        } else if thistext == "howquicklyaddT" {
            
            textview.text = NSLocalizedString("howquicklyaddT", comment: "")
        } else if thistext == "howaddmultipleT" {
            
            textview.text = NSLocalizedString("howaddmultipleT", comment: "")
        } else if thistext == "howaddtofavsT" {
            
            textview.text = NSLocalizedString("howaddtofavsT", comment: "")
        } else if thistext == "howreorderT" {
            
            textview.text = NSLocalizedString("howreorderT", comment: "")
        } else if thistext == "howchangeunitsT" {
            
            textview.text = NSLocalizedString("howchangeunitsT", comment: "")
        } else if thistext == "howaddpicturesT" {
            
            textview.text = NSLocalizedString("howaddpicturesT", comment: "")
        } else if thistext == "howdeleteitemsT" {
            
            textview.text = NSLocalizedString("howdeleteitemsT", comment: "")
        } else if thistext == "howcopyT" {
            
            textview.text = NSLocalizedString("howcopyT", comment: "")
        } else if thistext == "howcreatecatsT" {
            
            textview.text = NSLocalizedString("howcreatecatsT", comment: "")
        } else if thistext == "howcreatecatsT" {
            
            textview.text = NSLocalizedString("howcreatecatsT", comment: "")
        } else if thistext == "howaddcontactT" {
            
            textview.text = NSLocalizedString("howaddcontactT", comment: "")
        } else if thistext == "howsendlistsT" {
            
            textview.text = NSLocalizedString("howsendlistsT", comment: "")
        } else if thistext == "howsendbyemailT" {
            
            textview.text = NSLocalizedString("howsendbyemailT", comment: "")
        } else if thistext == "howrenameandnoteT" {
            
            textview.text = NSLocalizedString("howrenameandnoteT", comment: "")
        } else if thistext == "howturnoncatsT" {
            
            textview.text = NSLocalizedString("howturnoncatsT", comment: "")
        } else if thistext == "howchangecurrencyT" {
            
            textview.text = NSLocalizedString("howchangecurrencyT", comment: "")
        } else if thistext == "howsynchronizeT" {
            
            textview.text = NSLocalizedString("howsynchronizeT", comment: "")
        } else if thistext == "howchangeaccountdataT" {
            
            textview.text = NSLocalizedString("howchangeaccountdataT", comment: "")
        } else {
            textview.text = ""
        }
        
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
