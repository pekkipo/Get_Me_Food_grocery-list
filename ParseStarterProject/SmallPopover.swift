//
//  SmallPopover.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 21/11/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit


protocol SmallPopupDelegate
{
    func getinfofrompop(unit: String, quantity: String)
}

class SmallPopover: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
     var delegate : SmallPopupDelegate?
    /*
     var units : [[String]] = [["Units","un"],["pieces","pcs"],["Dozens","dz"],["kilograms","Kg"], ["grams","g"], ["liters","L"], ["milliliters","ml"],["fluid ounces","fl oz"], ["ounces","oz"], ["pounds","lb"],["gallons","gal"],["meters","m"],["centimeters","cm"],["inches","\""]]
*/
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
    
    var buttontitle = String()
    
    var doublenumber = Double()
    
    
    @IBOutlet var minusoutlet: UIButton!
    
    @IBOutlet var plusoutlet: UIButton!
    
    
    @IBOutlet var unitlabel: UILabel!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    @IBAction func decrement(sender: AnyObject) {
        
        var getvalue: Double {
            // get {return Qfield.text.toInt()!}
           // get {return (qtyfield.text! as NSString).doubleValue}
            get {return qtyfield.text!.doubleConverter}
        }
        
        doublenumber = getvalue
        
        doublenumber -= 1
        //qtyfield.text = String(format: "%.2f", (stringInterpolationSegment: doublenumber))
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        qtyfield.text = formatter.stringFromNumber(doublenumber)
        
    }
    
    @IBAction func increment(sender: AnyObject) {
        
        var getvalue: Double {
            // get {return Qfield.text.toInt()!}
            //get {return (qtyfield.text! as NSString).doubleValue}
            get {return qtyfield.text!.doubleConverter}
        }
        
        doublenumber = getvalue
        
        doublenumber += 1
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        qtyfield.text = formatter.stringFromNumber(doublenumber)//String(format: "%.2f", (stringInterpolationSegment: doublenumber))

    }
    
    
    @IBOutlet var qtyfield: UITextField!
    
  
    
    @IBAction func save(sender: AnyObject) {
        
        if((self.delegate) != nil) {
            delegate?.getinfofrompop(buttontitle, quantity: qtyfield.text!)
        } else {
            print("wtf")
        }
        
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
   
    @IBOutlet var picker: UIPickerView!
    
    /// Text field stuff
    
    
    
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
    //myTextField.delegate = self
    ///
    
    func closenumberpad(sender: UIButton) {
         qtyfield.resignFirstResponder()
    }
    
var closepadimage = UIImage(named: "ClosePad")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let toolFrame = CGRectMake(0, 0, self.view.frame.size.width, 46);
        let toolView: UIView = UIView(frame: toolFrame);
        
        let closepadframe: CGRect = CGRectMake(self.view.frame.size.width - 66, 1, 56, 42); //size & position of the button as placed on the toolView
        
        //Create the cancel button & set its title
        let closepad: UIButton = UIButton(frame: closepadframe);
        // closepad.setTitle("Close", forState: UIControlState.Normal);
        //closepad.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        closepad.setImage(closepadimage, forState: UIControlState.Normal)
        toolView.addSubview(closepad); //add it to the toolView
        
        //Add the target - target, function to call, the event witch will trigger the function call
        closepad.addTarget(self, action: "closenumberpad:", forControlEvents: UIControlEvents.TouchDown);
        
        qtyfield.inputAccessoryView = toolView
        
        

        qtyfield.text = ""
        
        qtyfield.delegate = self

        // Do any additional setup after loading the view.
        self.picker.delegate = self
        self.picker.dataSource = self
        
        view.backgroundColor = UIColorFromRGB(0xFAFAFA)
       // view.layer.borderWidth = 1
       // view.layer.borderColor = UIColorFromRGB(0x2A2F36).CGColor
        
        
        minusoutlet.layer.borderWidth = 1
        minusoutlet.layer.borderColor = UIColorFromRGB(0x9A9A9A).CGColor
        
        plusoutlet.layer.borderWidth = 1
        plusoutlet.layer.borderColor = UIColorFromRGB(0x9A9A9A).CGColor
        
        unitlabel.layer.borderWidth = 1
        unitlabel.layer.borderColor = UIColorFromRGB(0x9A9A9A).CGColor
        
        qtyfield.layer.borderWidth = 1
        qtyfield.layer.borderColor = UIColorFromRGB(0x9A9A9A).CGColor
        
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
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns number of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return units.count
    }
    
    
    
    // Return the title of each row in your picker ... In my case that will be the profile name or the username string
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {

        return units[row][0]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            buttontitle = units[row][1]
            //unitsbuttonoutlet.setTitle(buttontitle, forState: UIControlState.Normal)
        
        unitlabel.text = units[row][1]

    }
    
    ///// END ALERT CODE


}
