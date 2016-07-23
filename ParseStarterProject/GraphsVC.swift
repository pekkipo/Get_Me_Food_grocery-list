//
//  GraphsVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 09/07/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit
import Graphs
import Charts


class GraphsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // OUTLETS
    
    @IBOutlet var graphView: UIView!
    

    
    @IBOutlet var graylinetop: UIView!
    
    @IBOutlet var barButtonOutlet: UIButton!
    @IBOutlet var lineButtonOutlet: UIButton!
    @IBOutlet var pieButtonOutlet: UIButton!
    

    
    @IBOutlet var slidingView: UIView!
    
    @IBAction func chooseTimePeriod(sender: AnyObject) {
        
    }
    
    @IBAction func chooseTimeStep(sender: AnyObject) {
        
    }
    
    // MARK: - Handling data for charts
    
    struct Price {
    
        var step: String
        var price: Double
      //  var fromdate: NSDate
      //  var duedate: NSDate
        
    }
    
    func handledata(fromdate: NSDate, duedate: NSDate) -> [Price] {
        
        var prices = [Price]()
        
        // grab the lists that satisfy the condition
        for list in UserLists {
            if list.listtype == "Shop" {
                
            }
        }
        
        return prices
    }
    
    var chartprices = [Price]()
    
    enum charttype {
        case bar
        case line
        case pie
    }
    
    var chosenbartype : charttype = charttype.bar
    
    var computedarray = [Double]()
    
    // Test data
    var steps: [String]!
    var prices: [Double]!
    
    var barchart : BarChartView = BarChartView()
    
    
   // func setChart(barchart: BarChartView, dataPoints: [String], values: [Double]) {
    func setChart(barchart: BarChartView, prices: [Price]) {
        
        //Appearance customization
        
        barchart.noDataText = "You need to provide data for the chart."
        barchart.descriptionText = "Monthly test data"
        barchart.xAxis.labelPosition = .Bottom
        barchart.xAxis.setLabelsToSkip(0)
        barchart.scaleYEnabled = false
        barchart.scaleXEnabled = false
        barchart.pinchZoomEnabled = false
        barchart.doubleTapToZoomEnabled = false
        barchart.highlighter = nil // might use later, shows description when tap the bar
        barchart.rightAxis.enabled = false
        barchart.xAxis.drawGridLinesEnabled = false
        
        barchart.animate(yAxisDuration: 1.0, easingOption: .EaseInOutQuart)
        

        var dataEntries = [BarChartDataEntry]()
        var stepsEntries = [String]()
        
        for i in 0..<prices.count {
            let dataEntry = BarChartDataEntry(value: prices[i].price, xIndex: i)
            dataEntries.append(dataEntry)
            
            stepsEntries.append(prices[i].step)
        }
        
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Prices per Month")
        let chartData = BarChartData(xVals: stepsEntries, dataSet: chartDataSet)
        barchart.data = chartData
        
        chartDataSet.colors = [
            UIColorFromHex(0x31797D, alpha: 1),
            UIColorFromHex(0x1EB2BB, alpha: 1),
            UIColorFromHex(0x7FC2C6, alpha: 1),
            UIColorFromHex(0x61C791, alpha: 1),
            UIColorFromHex(0xA2AF36, alpha: 1),
            UIColorFromHex(0xE88996, alpha: 1),
        ]
        
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        barchart.descriptionText = ""
        
    }
    
    
    @IBOutlet var barView: BarChartView!
    
    // CHARTS REALM
    func choosebartype(type: charttype) {
        
       // graphView.subviews.forEach({ $0.removeFromSuperview() })
        graphView.subviews.forEach({ $0.hidden = true })
        
        if type == charttype.bar {
            
            barView.hidden = false
            
            //define data
            let _fromdate = NSDate()
            let _duedate = NSDate()

            setChart(barView, prices: handledata(_fromdate, duedate: _duedate))

            
        }
        
    }
    /* GRAPHS
    func choosebartype(type: charttype) {
        
        computedarray = [8.0, 12.0, 20.0, 10.0, 6.0, 20.0, 11.0, 9.0, 12.0, 16.0, 10.0, 6.0, 20.0]
        
        graphView.subviews.forEach({ $0.removeFromSuperview() })
        
        if type == charttype.bar {
        
        let view = computedarray.barGraph(GraphRange(min: 0, max: 25)).view(graphView.bounds).barGraphConfiguration({ BarGraphViewConfig(barColor: UIColor(hex: "#31797D"), barWidthScale: 0.8) })
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        graphView.addSubview(view)
        
        } else if type == charttype.line {
            
            let view = computedarray.lineGraph().view(graphView.bounds).lineGraphConfiguration({ LineGraphViewConfig(lineColor: UIColor(hex: "#1EB2BB"), contentInsets: UIEdgeInsets(top: 32.0, left: 32.0, bottom: 32.0, right: 32.0)) })
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            graphView.addSubview(view)
            
            
        } else if type == charttype.pie {
            
            //let view = [8, 12, 20, -10, 6, 20, -11, 9, 12, 16, -10, 6, 20, -12].pieGraph().view(graphView.bounds).lineGraphConfiguration({ LineGraphViewConfig(lineColor: UIColor(hex: "#ff6699"), contentInsets: UIEdgeInsets(top: 32.0, left: 32.0, bottom: 32.0, right: 32.0)) })
            let view = computedarray.pieGraph(){ (u, t) -> String? in String(format: "%.0f%%", (Float(u.value) / Float(t)))}.view(graphView.bounds).pieGraphConfiguration({ PieGraphViewConfig(textFont: UIFont(name: "DINCondensed-Bold", size: 14.0), isDounut: true, contentInsets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)) })
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            graphView.addSubview(view)
            
            
        }
        
    }
    */
    @IBAction func barAction(sender: AnyObject) {
        
        choosebartype(charttype.bar)
        
    }
    
    @IBAction func lineAction(sender: AnyObject) {
        
        choosebartype(charttype.line)
    }
    
    
    @IBAction func pieAction(sender: AnyObject) {
        
        choosebartype(charttype.pie)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

 
        
        //months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
       // prices = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        tblExpandable.registerNib(UINib(nibName: "choosedatescell", bundle: nil), forCellReuseIdentifier: "choosedates")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var tblExpandable: UITableView!
    
    // MARK: UITableView Delegate and Datasource Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            if pickerexpanded {
            return 2
            } else {
                return 1
            }
        }
        return 1
    }
    
    
    func tableView(tableView: UITableView,
                   willDisplayCell cell: UITableViewCell,
                                   forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
 
    
    let identifiers : [String] = ["weekcell", "monthcell","yearcell", "choosecell", "choosedates"]
    
    
    let timeperiods : [String] = ["week", "month", "year", "custom"]
    
    let timesteps : [String] = ["days", "weeks", "months", "years"]
    
    var totalsum : Double = Double()
    
    var totallistscount : Double = Double()
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var identifier = String()
        if indexPath.section == 1 {
        identifier = identifiers[0]
        } else if indexPath.section == 2 {
        identifier = identifiers[1]
        } else if indexPath.section == 3 {
            identifier = identifiers[2]
        } else if indexPath.section == 0 {
            if indexPath.row == 0 {
            identifier = identifiers[3]
            } else {
            identifier = identifiers[4]
            }
            
            
            // assign actions
            
            
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! choosedatescell
        
        if indexPath.section == 0 {
            /*
            cell.frombutton.addTarget(self, action: #selector(GraphsVC.choosefromdate(_:)), forControlEvents: .TouchUpInside)
 */
            if indexPath.row == 0 {
            cell.frombutton.addTarget(self, action: "choosefromdate:", forControlEvents: .TouchUpInside)
            
            
            cell.duebutton.addTarget(self, action: "chooseduedate:", forControlEvents: .TouchUpInside)
            
            }
            if indexPath.row == 1 {
            cell.datepicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
                
            cell.donebutton.addTarget(self, action: "donebuttontapped:", forControlEvents: .TouchUpInside)
                
            }
        }
        
        
        return cell
    }
    
    
    var pickerexpanded : Bool = false
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            return 260
            
        }
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 74
            
        }
        
    return 44
    }
    
    func donebuttontapped(sender: UIButton) {
        
        pickerexpanded = false
        //tblExpandable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
        
        tblExpandable.reloadData()
        
        let indexs = NSIndexPath(forRow: 0, inSection: 0)
        let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
        
        if cell.fromdate.text == "" {
             cell.fromdateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
             cell.fromdate.textColor = UIColorFromHex(0xE0E0E0, alpha: 1)
        } else {
            cell.fromdateline.backgroundColor = UIColorFromHex(0x31797D, alpha: 1)
            cell.fromdate.textColor = UIColorFromHex(0x31797D, alpha: 1)
        }
        
        if cell.duedate.text == "" {
            cell.duedateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
            cell.duedate.textColor = UIColorFromHex(0xE0E0E0, alpha: 1)
        } else {
            cell.duedateline.backgroundColor = UIColorFromHex(0x31797D, alpha: 1)
            cell.duedate.textColor = UIColorFromHex(0x31797D, alpha: 1)
        }
       
        
    }
    
    func expand(indexPath: NSIndexPath) {
        
        if !pickerexpanded {
            
            pickerexpanded = true
            
        } else {
            pickerexpanded = false
        }
        
        tblExpandable.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
       // tblExpandable.reloadData()
    }
    
    var fromdate : Bool = true
    
    func choosefromdate(sender: UIButton!) {
        
        fromdate = true
        

        
        let indexs = NSIndexPath(forRow: 0, inSection: 0)
        let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
        
        cell.fromdateline.backgroundColor = UIColorFromHex(0x31797D, alpha: 1)
        cell.duedateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
      
        if !pickerexpanded {
        expand(indexs)
        }

        

    }
    
    func chooseduedate(sender: UIButton!) {
        
        fromdate = false
        

        
       // let indexPath = tblExpandable.indexPathForCell(cell)
         let indexs = NSIndexPath(forRow: 0, inSection: 0)
         let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
        
        cell.duedateline.backgroundColor = UIColorFromHex(0x31797D, alpha: 1)
        cell.fromdateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
        
        if !pickerexpanded {
        expand(indexs)
        }
        
        
       
        
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        
        let picker = datePicker as UIDatePicker
        let view = picker.superview!
        //let cell = view.superview as! choosedatescell
        
        var indexs = NSIndexPath(forRow: 0, inSection: 0)
        //let celll = tblExpandable.dequeueReusableCellWithIdentifier("choosecell", forIndexPath: indexs) as! choosedatescell
        
        let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
        
        
        var dateFormatter = NSDateFormatter()
        
        //dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
       // dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        if fromdate {
        cell.fromdate.text = strDate
        } else {
        cell.duedate.text = strDate
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //var selectedRowIndex: NSIndexPath = NSIndexPath(forRow: 0, inSection: 3)
        /*
        if indexPath.section == 0 {
            if indexPath.row == 0 {
            
            if !pickerexpanded {
                
                pickerexpanded = true

            } else {
                pickerexpanded = false
            }
            
            tblExpandable.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None) //UITableViewRowAnimation.Fade)
            }
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
