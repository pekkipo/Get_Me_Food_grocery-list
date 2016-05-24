//
//  UnitsPopover.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 28/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class UnitsPopover: UIViewController {

    
    var units = ["Kg", "g", "l", "pcs"]
    
    var buttontitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return units[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        buttontitle = units[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        if segue.identifier == "ShowUnits" {
            
             let destinationVC : AddItemViewController = segue.destinationViewController as! AddItemViewController
            
            destinationVC.UnitsButton.setTitle(buttontitle, forState: UIControlState.Normal)
            //here I pass the current lists id to product history tableViewController
            
            
            
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
