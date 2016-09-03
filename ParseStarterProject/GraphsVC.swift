//
//  GraphsVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 09/07/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit
//import Graphs
import Charts



/// This stuff so that I can use Subperiod struct in a dictionary
struct Subperiod {
    var left: NSDate
    var right: NSDate
}

// MARK: Hashable

extension Subperiod: Hashable {
    var hashValue: Int {
        return left.hashValue ^ right.hashValue
    }
}

func ==(lhs: Subperiod, rhs: Subperiod) -> Bool {
    return lhs.left == rhs.left && lhs.right == rhs.right
}

func >(lhs: Subperiod, rhs: Subperiod) -> Bool {
    return lhs.left.timeIntervalSince1970 > rhs.left.timeIntervalSince1970 && lhs.right.timeIntervalSince1970 > rhs.right.timeIntervalSince1970
}

enum Errors: ErrorType {
    case ErrorWeek
    case ErrorMonth
    case ErrorYear
    case Default
}


var statsymbol = String()
var statcode = String()

class GraphsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var senderVC = String()
    
    
    // CHOSEN PARAMETERS
    
    var chosenfromdate = NSDate()
    var chosenduedate = NSDate()
    var timeperiodtype = TimePeriodType.custom
    var chosentimestep = TimeStep.weeks
    
    
    // OUTLETS
    
    @IBOutlet var graphView: UIView!
    

    @IBOutlet var periodlabel: UILabel!
    
    @IBOutlet var steplabel: UILabel!
    
    
    @IBOutlet var graylinetop: UIView!
    
    @IBOutlet var barButtonOutlet: UIButton!
    @IBOutlet var lineButtonOutlet: UIButton!
    @IBOutlet var pieButtonOutlet: UIButton!
    

    @IBOutlet var listsSumLabel: UILabel!
    
    @IBOutlet var listsCountLabel: UILabel!
    
    
    @IBOutlet var slideSteps: UIView!
    
    @IBOutlet var slideStepsConstraint: NSLayoutConstraint! // 0 or -340
    
    @IBOutlet var slidingView: UIView!
    @IBOutlet var slidingbottomconstraint: NSLayoutConstraint! // 0 or -450
    
    
    @IBAction func cancelSteps(sender: AnyObject) {
        
        slide(-340, view: "Steps")
        
    }
    
    @IBOutlet var timeperiodbuttonoutlet: UIButton!
    
    @IBOutlet var timestepbuttonoutlet: UIButton!
    
    
    
    @IBAction func confirmSteps(sender: AnyObject) {
        
        //timeperiodtype = TimePeriodType.custom
        
       
       setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: timeperiodtype))
        
        
        if chosentimestep == TimeStep.days {
        steplabel.text = NSLocalizedString("days", comment: "")
        } else if chosentimestep == TimeStep.weeks {
            steplabel.text = NSLocalizedString("weeks", comment: "")
        } else if chosentimestep == TimeStep.months {
           steplabel.text = NSLocalizedString("months", comment: "")
        } else if chosentimestep == TimeStep.years {
            steplabel.text = NSLocalizedString("years", comment: "")
        }
        
        slide(-340, view: "Steps")
    }
    
    
    @IBOutlet var stepsTbl: UITableView!
    
    
    func slide(value: CGFloat, view: String) {
        
        if view == "Period" {
        slidingbottomconstraint.constant = value
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        } else if view == "Steps" {
            slideStepsConstraint.constant = value
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
        }
    }
    
    @IBAction func closesliding(sender: AnyObject) {
        
        slide(-450, view: "Period")

    }
    
    @IBAction func confirmtimeperiod(sender: AnyObject) {
        
    //timeperiodtype = TimePeriodType.custom
    
     setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: timeperiodtype))
        
        if timeperiodtype == TimePeriodType.custom {
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let leftdate: String = dateFormatter.stringFromDate(chosenfromdate)
            let rightdate: String = dateFormatter.stringFromDate(chosenduedate)
            let stringdate : String = "\(leftdate) - \(rightdate)"
            
            periodlabel.text = stringdate
        } else if timeperiodtype == TimePeriodType.week {
            periodlabel.text = NSLocalizedString("oneweek", comment: "")
            steplabel.text = NSLocalizedString("days", comment: "")
        } else if timeperiodtype == TimePeriodType.month {
           periodlabel.text = NSLocalizedString("onemonth", comment: "")
            steplabel.text = NSLocalizedString("weeks", comment: "")
        } else if timeperiodtype == TimePeriodType.year {
            periodlabel.text = NSLocalizedString("oneyear", comment: "")
            steplabel.text = NSLocalizedString("months", comment: "")
        }
    
        
        
      slide(-450, view: "Period")

        
    }
    
    
    
    @IBAction func chooseTimePeriod(sender: AnyObject) {

        slide(0, view: "Period")

    }
    
    @IBAction func chooseTimeStep(sender: AnyObject) {
        slide(0, view: "Steps")
    }
    
    @IBOutlet var loadingview: UIView!
    
    func loading_simple(show: Bool) {
        
        /*
        let viewframe = CGRectMake(self.view.frame.width / 2 - 50, self.view.frame.height / 2 - 50, 100, 100)
        let loadingview: UIView = UIView(frame: viewframe);
        loadingview.backgroundColor = UIColor.whiteColor()
        loadingview.layer.cornerRadius = 12
        */
        let indicator : NVActivityIndicatorView =  NVActivityIndicatorView(frame: CGRectMake(20, 20, 60, 60), type: NVActivityIndicatorType.BallClipRotate, color: UIColorFromHex(0x1EB2BB))
        
        
        loadingview.addSubview(indicator)
        
        //loadingview.tag = 945
        
        
        
        if show == true {
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            //self.graphView.addSubview(loadingview)
           // self.graphView.bringSubviewToFront(loadingview)
            loadingview.hidden = false
        
            indicator.startAnimation()
            
        } else if show == false {
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            /*
            if let viewWithTag = self.view.viewWithTag(945) {
                viewWithTag.removeFromSuperview()
            }
            */
            loadingview.hidden = true
        }
        
    }

    
    
    
    // MARK: - Handling data for charts
    
    struct Price {
    
        var step: String
        var price: Double
        var date: NSDate
        
    }
    
    enum TimePeriodType {
        
        case week
        case month
        case year
        case custom
    }
    
    enum TimeStep {
        case days
        case weeks
        case months
        case years
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "4SentFail")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xFFFFFF, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Dark)
        alertview.addCancelAction(closeCallback)
    }
    
    func closeCallback() {
        
        print("JUST CLOSED")
        
    }
    
    
   // let timeperiods : [String] = ["week", "month", "year", "custom"]
    
    let timesteps : [String] = ["days", "weeks", "months", "years"]
    
    var totalsum : Double = Double()
    
    var totallistscount : Double = Double()
    
    

    
    var sections = Dictionary<String, Array<UserList>>()
    var sortedLists = [String]()
    
  
    
    
    var weekssections = Dictionary<Subperiod, Array<UserList>>()
    var sortedListsbyDate = [Subperiod]()
    
    func sortlists(lists: [UserList], timestep: TimeStep, from: NSDate?, due: NSDate?) throws {
        
        
        
        sections.removeAll(keepCapacity: true)
        sortedLists.removeAll(keepCapacity: true)
        
        weekssections.removeAll(keepCapacity: true)
        sortedListsbyDate.removeAll(keepCapacity: true)
        
       
        
        if timestep == TimeStep.days {
            
            for ( var i = 0; i < lists.count; i++ ) {
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                
                let commondate: String = dateFormatter.stringFromDate(lists[i].listcreationdate)

            if self.sections.indexForKey(commondate) == nil {
                self.sections[commondate] = [lists[i]]
            }
            else {
                self.sections[commondate]?.append(lists[i])
            }
            
            //we are storing our sections in dictionary, so we need to sort it
          //  self.sortedLists = self.sections.keys.elements.sort(<)
                
                
        }
        self.sortedLists = self.sections.keys.elements.sort(<)

            
        } else if timestep == TimeStep.weeks {
            
            /*
            guard let numberofdays : Int = dividetimeperiod(timestep, from: from!, due: due!) else {
                throw Errors.Error
            }
 */
            do {
            let numberofdays = try dividetimeperiod(timestep, from: from!, due: due!)
            let numberofweeks = numberofdays / 7
                
                print("Number of weeks: \(numberofweeks)")
           
                guard numberofweeks >= 1 else {
                     throw Errors.ErrorWeek
                }
            
            for ( var i = 0; i < lists.count; i++ ) {
                
                
                for j in (1..<numberofweeks+1) { //+1 not sure
                    
                    var leftborderweek = NSDate()
                    var rightborderweek = NSDate()
                    
                    if j == 1 {
                        
                        leftborderweek = from!
                        rightborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Day,
                            value: 7,
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                        
                        
                    } else {
                        let intnumber1 : Int = 7*(j-1)
                        let intnumber2 : Int = 7*j
                        
                    leftborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Day,
                            value: intnumber1,
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                    rightborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                        .Day,
                        value: intnumber2,
                        toDate: from!,
                        options: NSCalendarOptions.MatchStrictly)!

                    }
                    
                    if (lists[i].listcreationdate.timeIntervalSince1970 >= leftborderweek.timeIntervalSince1970) && (lists[i].listcreationdate.timeIntervalSince1970 <= rightborderweek.timeIntervalSince1970) {
                        
                       /*
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "dd MMM"
                        
                        let leftdate: String = dateFormatter.stringFromDate(leftborderweek)
                        let rightdate: String = dateFormatter.stringFromDate(rightborderweek)
                        
                        let commondate : String = "\(leftdate) - \(rightdate)"
                        */
                        let commondate : Subperiod = Subperiod(left: leftborderweek, right: rightborderweek)
                        //"\(leftdate) - \(rightdate)"
                        
                        if self.weekssections.indexForKey(commondate) == nil {
                            self.weekssections[commondate] = [lists[i]]
                        }
                        else {
                            self.weekssections[commondate]?.append(lists[i])
                        }
                        
                        
                        
                        //self.sortedLists = self.sections.keys.elements.sort(<)
                        
                        
                        
                        
                    }
                
                }
                /*
                self.sortedListsbyDate = self.weekssections.keys.elements.sort({
                    return $0.0 > $0.1
                })
                */
                //self.sortedLists = self.sections.keys.elements.sort(<)
                
                /*
                self.sortedLists = self.sections.keys.elements.sort({
                    return ($0.componentsSeparatedByString(" -")[0]) > ($1.componentsSeparatedByString(" -")[0])
                    
                })
                */
                

               // var str = "str.str"
               // str = str.componentsSeparatedByString(".")[0]
              
                
                /// HAVE TO SORT THIS BITCH SOMEHOW
              /*  sortedLists.sortInPlace({
                    return ($0.componentsSeparatedByString(" -")[0]) > ($1.componentsSeparatedByString(" -")[0])
                    
                })
                */
                /*
                var sortedArray = sortedLists.sort({
                    let dict = self.sections.keys.elements
                    return dict[$0] > dict[$1]
                })
                */
                
            }
            
            } catch Errors.ErrorWeek {
                print("WeekError")
            } catch {
                print("JustError")
            }
        
            self.sortedListsbyDate = self.weekssections.keys.elements.sort({
                //return $0.0.left.timeIntervalSince1970 > $1.0.left.timeIntervalSince1970
                return $0.left.timeIntervalSince1970 > $1.left.timeIntervalSince1970
            })
            
            self.weekssections.keys.elements.sort({
                return $0.left.timeIntervalSince1970 > $1.left.timeIntervalSince1970
            })

            
        } else if timestep == TimeStep.months {
            
            var calendar: NSCalendar = NSCalendar.currentCalendar()
            let date1 = calendar.startOfDayForDate(from!)
            let date2 = calendar.startOfDayForDate(due!)
            
            let flags = NSCalendarUnit.Month
            let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
            
          
        
           var numberofmonths = components.month
            
            guard numberofmonths >= 1 else {
                throw Errors.ErrorMonth
            }
            
            for ( var i = 0; i < lists.count; i++ ) {
                
                
                for j in (1..<numberofmonths+1) { //+1 might be needed
                    
                    var leftborderweek = NSDate()
                    var rightborderweek = NSDate()
                    
                    if j == 1 {
                        
                        leftborderweek = from!
                        rightborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Month,
                            value: 1,
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                        
                        
                    } else {
                        leftborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Month,
                            value: (j-1),
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                        rightborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Month,
                            value: j,
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                    }
                    
                    if (lists[i].listcreationdate.timeIntervalSince1970 >= leftborderweek.timeIntervalSince1970) && (lists[i].listcreationdate.timeIntervalSince1970 <= rightborderweek.timeIntervalSince1970) {
                        

                        let commondate : Subperiod = Subperiod(left: leftborderweek, right: rightborderweek)

                        if self.weekssections.indexForKey(commondate) == nil {
                            self.weekssections[commondate] = [lists[i]]
                        }
                        else {
                            self.weekssections[commondate]?.append(lists[i])
                        }

                    }
                    
                }

                
            }
            
        
        
            self.sortedListsbyDate = self.weekssections.keys.elements.sort({
                //return $0.0.left.timeIntervalSince1970 > $1.0.left.timeIntervalSince1970
                return $0.left.timeIntervalSince1970 > $1.left.timeIntervalSince1970
            })
            
            self.weekssections.keys.elements.sort({
                return $0.left.timeIntervalSince1970 > $1.left.timeIntervalSince1970
            })

            
            
        } else if timestep == TimeStep.years {
            
            var calendar: NSCalendar = NSCalendar.currentCalendar()
            let date1 = calendar.startOfDayForDate(from!)
            let date2 = calendar.startOfDayForDate(due!)
            
            let flags = NSCalendarUnit.Year
            let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
            
            
            
            var numberofyears = components.year
            
            guard numberofyears >= 1 else {
                throw Errors.ErrorYear
            }
            
            for ( var i = 0; i < lists.count; i++ ) {
                
                
                for j in (1..<numberofyears+1) {
                    
                    var leftborderweek = NSDate()
                    var rightborderweek = NSDate()
                    
                    if j == 1 {
                        
                        leftborderweek = from!
                        rightborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Year,
                            value: 1,
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                        
                        
                    } else {
                        leftborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Year,
                            value: (j-1),
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                        rightborderweek = NSCalendar.currentCalendar().dateByAddingUnit(
                            .Year,
                            value: j,
                            toDate: from!,
                            options: NSCalendarOptions.MatchStrictly)!
                        
                    }
                    
                    if (lists[i].listcreationdate.timeIntervalSince1970 >= leftborderweek.timeIntervalSince1970) && (lists[i].listcreationdate.timeIntervalSince1970 <= rightborderweek.timeIntervalSince1970) {
                        
                        
                        let commondate : Subperiod = Subperiod(left: leftborderweek, right: rightborderweek)
                        
                        if self.weekssections.indexForKey(commondate) == nil {
                            self.weekssections[commondate] = [lists[i]]
                        }
                        else {
                            self.weekssections[commondate]?.append(lists[i])
                        }
                        
                    }
                    
                }
                
                
            }
            
            self.sortedListsbyDate = self.weekssections.keys.elements.sort({
                //return $0.0.left.timeIntervalSince1970 > $1.0.left.timeIntervalSince1970
                return $0.left.timeIntervalSince1970 > $1.left.timeIntervalSince1970
            })
            
            self.weekssections.keys.elements.sort({
                return $0.left.timeIntervalSince1970 > $1.left.timeIntervalSince1970
            })

            
        }
    
        print("Sections are: \(weekssections)")
        print("SortedLists are: \(sortedListsbyDate)")
        
    }
    
    
    
    
    func dividetimeperiod(step: TimeStep, from: NSDate, due: NSDate?) throws -> Int {
        
        var numberofsubperiods = Int()
        
      
            var calendar: NSCalendar = NSCalendar.currentCalendar()
            let date1 = calendar.startOfDayForDate(from)
            let date2 = calendar.startOfDayForDate(due!)
            
            let flags = NSCalendarUnit.Day
            let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
            
            numberofsubperiods = components.day
        
       guard numberofsubperiods > 1 else {
            throw Errors.ErrorWeek
        }

        
        return numberofsubperiods
    }
    
    func sumpricesofoldstylelists(listid: String) -> Double {
        
        var totalsum = Double()
        
        return totalsum
    }
    
    func sumliststotalsums(lists: [UserList]) -> Double {
        
        var totalsum = Double()
        var array = [Double]()
        
        for list in lists {
            if list.listtotalsum != nil {
            var doublevalue = list.listtotalsum!.doubleConverter
            array.append(doublevalue)
            } else {
            //array.append(0.0)
            //array.append(Double(arc4random_uniform(2000))) //FOR TESTING
            }
        }
        
        totalsum = array.reduce(0, combine: +)
        
        return totalsum
        
    }

    
    func handledata(fromdate: NSDate?, duedate: NSDate?, timestep: TimeStep, timeperiodtype: TimePeriodType) -> [Price] {
        
        
        var chosenlists = [UserList]()
        var prices = [Price]()
        
        loading_simple(true)
        
        //if timeperiodtype == TimePeriodType.custom {
            
        // STEP 1 - Grab all list for the given TIME PERIOD
        for list in UserLists {
            if list.listtype == "Shop" {
                
                if (list.listcreationdate.timeIntervalSince1970 >= fromdate?.timeIntervalSince1970) && (list.listcreationdate.timeIntervalSince1970 <= duedate?.timeIntervalSince1970) {
                    
                    // LATER I WILL ADD AN OPPORTUNITY TO CHANGE THE CURRENCY
                    // now check if the symbol of lists currency is equal to symbol var
                    //if let cur = list.listcurrency as! [String] {
                    if ((list.listcurrency as! [String])[0] == statcode)
                   // if cur[0] == code
                    {
                    chosenlists.append(list)
                    } else {
                        print("wrong currency")
                    }
                    
                
                }
                
            }
        }
        
        print("lists are: \(chosenlists)")
            
        // STEP 2 - Sort the chosenlistsarray
        
        
        do {
        try sortlists(chosenlists, timestep: timestep, from: fromdate, due: duedate)
        } catch Errors.ErrorWeek {
            print("WeekError")
        } catch Errors.ErrorMonth {
            print("MonthError")
        } catch Errors.ErrorYear {
            print("YearError")
            
        } catch {
            
        }
        
        
            
            
            
        // STEP 3 - Sum all lists in subperiods
            if timestep == TimeStep.days {
                for (date, lists) in sections {
                print("date: \(date)")
                //sumliststotalsums(lists)
            
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    let formatdate = dateFormatter.dateFromString(date)
            
                    var dayName = String()
            
                        if formatdate != nil {
                            dayName = "\(formatdate!.dayOfTheWeek()!)\n\(date)"
                        } else {
                            dayName = date
                        }
            
                    let price = Price(step: dayName, price: sumliststotalsums(lists), date: formatdate!)
                        prices.append(price)
                }
                
                prices.sortInPlace({ $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 })
                
            } else if timestep == TimeStep.weeks {
               /*
                for (date, lists) in sections {
                    let price = Price(step: date, price: sumliststotalsums(lists))
                    prices.append(price)
                }
                */
                
                for (date, lists) in weekssections {

                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM"
                    
                    let leftdate: String = dateFormatter.stringFromDate(date.left)
                    let rightdate: String = dateFormatter.stringFromDate(date.right)
                    
                    let stringdate : String = "\(leftdate) - \(rightdate)"

                    let price = Price(step: stringdate, price: sumliststotalsums(lists), date: date.left)
                    prices.append(price)
                }
                
                prices.sortInPlace({ $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 })
                
            } else if timestep == TimeStep.months {

                
                for (date, lists) in weekssections {
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM"
                    
                    let leftdate: String = dateFormatter.stringFromDate(date.left)
                    let rightdate: String = dateFormatter.stringFromDate(date.right)
                    
                    let stringdate : String = "\(leftdate) - \(rightdate)"
                    
                    let price = Price(step: stringdate, price: sumliststotalsums(lists), date: date.left)
                    prices.append(price)
                }
                
                prices.sortInPlace({ $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 })
                
            } else if timestep == TimeStep.years {
                
                
                for (date, lists) in weekssections {
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy"
                    
                    let leftdate: String = dateFormatter.stringFromDate(date.left)
                    let rightdate: String = dateFormatter.stringFromDate(date.right)
                    
                    let stringdate : String = "\(leftdate) - \(rightdate)"
                    
                    let price = Price(step: stringdate, price: sumliststotalsums(lists), date: date.left)
                    prices.append(price)
                }
                
                prices.sortInPlace({ $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 })
                
            }
            
            print(prices)

            
            // STEP 4 - sum all lists from given period to show
            sumliststotalsums(chosenlists)
            
            var formatter = NSNumberFormatter()
            formatter.maximumFractionDigits = 4
            formatter.usesSignificantDigits = false
            formatter.minimumSignificantDigits = 1
            formatter.maximumSignificantDigits = 9
            
            
            
            var sum : String = formatter.stringFromNumber(sumliststotalsums(chosenlists))!
            
            listsSumLabel.text = "\(sum) \(statsymbol)"
            listsCountLabel.text = "\(chosenlists.count)"
        
            
        
           
            
      
      
            
            
            // STEP 2 - Create an array of arrays of lists 
            // Number of arrays is the number of days (in case days timeperiod) between fromdate and duedate
            
        // At this point I have all lists from the chosen period
            
            
        /*
        for list in chosenlists {
            
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: list.listcreationdate)
            let year =  components.year
            let month = components.month
            let day = components.day
            var stepname = String()
            let weekName = ""
            let monthName = NSDateFormatter().monthSymbols[month - 1]
            let dayName = list.listcreationdate.dayOfTheWeek()
            let yearName = list.listcreationdate.pickyear()
            var sum = Double()

            if timestep == TimeStep.days {
            stepname = dayName!
                
                
             let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
                    .Day,
                    value: 1,
                    toDate: list.listcreationdate,
                    options: NSCalendarOptions.MatchStrictly)
                
                
            } else if timestep == TimeStep.weeks {
            stepname = weekName
                
            } else if timestep == TimeStep.months {
            stepname = monthName
            } else if timestep == TimeStep.years {
            stepname = yearName!
            }
            
            if list.listtotalsum != nil {
                
                sum = summationfortheschosenperiod()
            } else {
                sum = Double(arc4random_uniform(2000))
            }
            

            let price = Price(step: stepname, price: sum)
            prices.append(price)

        }
        */
            
        loading_simple(false)
        
       
    
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
    func setChart(barchart: BarChartView, linechart: LineChartView, piechart: PieChartView, prices: [Price]) {
        
        //Appearance customization
        
        barchart.legend.enabled = false
        //barchart.legend.direction = .LeftToRight
        barchart.extraBottomOffset = 15
        
        // BARCHART
        barchart.noDataText = "You need to provide data for the chart."
        barchart.descriptionText = ""
        barchart.xAxis.labelPosition = .Bottom
        barchart.xAxis.setLabelsToSkip(0)
        barchart.scaleYEnabled = false
        barchart.scaleXEnabled = false
        barchart.pinchZoomEnabled = false
        barchart.doubleTapToZoomEnabled = false
        barchart.highlighter = nil // might use later, shows description when tap the bar
        barchart.rightAxis.enabled = false
        barchart.leftAxis.enabled = false
        barchart.xAxis.drawGridLinesEnabled = false
        barchart.xAxis.labelFont = UIFont(name: "AvenirNext-Regular", size: 8)!
        barchart.xAxis.labelTextColor = UIColorFromHex(0x898989)
        barchart.xAxis.wordWrapEnabled = true
        //barchart.xAxis.labelHeight = 50

        barchart.backgroundColor = UIColorFromHex(0xFAFAFA, alpha: 1)
        
        barchart.xAxis.axisLineColor = UIColorFromHex(0xFAFAFA)

        barchart.animate(yAxisDuration: 1.0, easingOption: .EaseInOutQuart)
        
        // LINECHART
        linechart.legend.enabled = false
        linechart.noDataText = "You need to provide data for the chart."
        linechart.descriptionText = ""
        linechart.xAxis.labelPosition = .Bottom
        linechart.xAxis.setLabelsToSkip(0)
        linechart.scaleYEnabled = false
        linechart.scaleXEnabled = false
        linechart.pinchZoomEnabled = false
        linechart.doubleTapToZoomEnabled = false
        linechart.highlighter = nil // might use later, shows description when tap the bar
        linechart.rightAxis.enabled = false
        linechart.leftAxis.enabled = false
        linechart.xAxis.drawGridLinesEnabled = false
        linechart.drawGridBackgroundEnabled = false
        linechart.xAxis.labelFont = UIFont(name: "AvenirNext-Regular", size: 9)!
        linechart.xAxis.labelTextColor = UIColorFromHex(0x898989)
        linechart.xAxis.wordWrapEnabled = true
        //barchart.xAxis.labelHeight = 50
        linechart.extraLeftOffset = 30
        linechart.extraRightOffset = 30
        linechart.extraBottomOffset = 15
        
        linechart.backgroundColor = UIColorFromHex(0xFAFAFA, alpha: 1)
        
        linechart.animate(yAxisDuration: 1.0, easingOption: .EaseInOutQuart)
        
        linechart.xAxis.axisLineColor = UIColorFromHex(0xFAFAFA)
        
        // PIECHART
        piechart.noDataText = "You need to provide data for the chart."
        
        piechart.highlighter = nil // might use later, shows description when tap the bar

        //barchart.xAxis.labelHeight = 50
        
        piechart.backgroundColor = UIColorFromHex(0xFAFAFA, alpha: 1)
        
        piechart.legend.enabled = false
        
        //piechart.style
        
        //piechart.infoFont = UIFont(name: "AvenirNext-Regular", size: 8)!
        
        piechart.animate(yAxisDuration: 1.0, easingOption: .EaseInOutQuart)

      //  piechart.descriptionFont = UIFont(name: "AvenirNext-Regular", size: 8)!
        
        piechart.descriptionText = ""
        
        
        piechart.holeRadiusPercent = 0
        piechart.transparentCircleRadiusPercent = 0
       // piechart.label
        /*
        let stringAttributes = [
            NSFontAttributeName : UIFont(name: "AvenirNext-Regular", size: 8.0)!,
            NSUnderlineStyleAttributeName : 1,
            NSForegroundColorAttributeName : UIColorFromHex(0xFAFAFA),
            NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
            NSStrokeWidthAttributeName : 2.0]
        */
      //  piechart.usePercentValuesEnabled = true
        

        var dataEntries = [BarChartDataEntry]() // for bar
        var dataEntriesline = [ChartDataEntry]() // for line and pie
        var stepsEntries = [String]()
        
        for i in 0..<prices.count {
            let dataEntry = BarChartDataEntry(value: prices[i].price, xIndex: i)
            let dataEntrylineandpie = ChartDataEntry(value: prices[i].price, xIndex: i)
            
            
            dataEntries.append(dataEntry)
            
            dataEntriesline.append(dataEntrylineandpie)
            
            stepsEntries.append(prices[i].step)
        }
        
        // bar
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: nil)
        let chartData = BarChartData(xVals: stepsEntries, dataSet: chartDataSet)
        barchart.data = chartData
        
        chartData.setValueFont(UIFont(name: "AvenirNext-Regular", size: 9)!)
        
        chartData.setValueTextColor(UIColorFromHex(0x898989))
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        chartDataSet.valueFormatter = formatter
        
        //line and pie
        let pieChartDataSet = PieChartDataSet(yVals: dataEntriesline, label: nil)
        let pieChartData = PieChartData(xVals: stepsEntries, dataSet: pieChartDataSet)
        pieView.data = pieChartData
        
        pieChartData.setValueFont(UIFont(name: "AvenirNext-Regular", size: 7)!)
        
        pieChartData.setValueTextColor(UIColorFromHex(0xFAFAFA))
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntriesline, label: nil)
        let lineChartData = LineChartData(xVals: stepsEntries, dataSet: lineChartDataSet)
        lineView.data = lineChartData
        
        lineChartData.setValueFont(UIFont(name: "AvenirNext-Regular", size: 9)!)
        
        lineChartData.setValueTextColor(UIColorFromHex(0x898989))
        
        
        chartDataSet.colors = [
            UIColorFromHex(0x31797D, alpha: 1),
            UIColorFromHex(0x1EB2BB, alpha: 1),
            UIColorFromHex(0x7FC2C6, alpha: 1),
            UIColorFromHex(0x61C791, alpha: 1),
            UIColorFromHex(0xA2AF36, alpha: 1),
            UIColorFromHex(0xE88996, alpha: 1),
        ]
        
        lineChartDataSet.colors = [
            UIColorFromHex(0x31797D, alpha: 1),
            UIColorFromHex(0x1EB2BB, alpha: 1),
            UIColorFromHex(0x7FC2C6, alpha: 1),
            UIColorFromHex(0x61C791, alpha: 1),
            UIColorFromHex(0xA2AF36, alpha: 1),
            UIColorFromHex(0xE88996, alpha: 1),
        ]
        
        pieChartDataSet.colors = [
            UIColorFromHex(0x31797D, alpha: 1),
            UIColorFromHex(0x1EB2BB, alpha: 1),
            UIColorFromHex(0x7FC2C6, alpha: 1),
            UIColorFromHex(0x61C791, alpha: 1),
            UIColorFromHex(0xA2AF36, alpha: 1),
            UIColorFromHex(0xE88996, alpha: 1),
        ]
        
        //chartDataSet.colors = ChartColorTemplates.joyful()
        
     
        
       // linechart.descriptionText = ""
    }
    
    
    @IBOutlet var barView: BarChartView!
    
    @IBOutlet var lineView: LineChartView!
    
    @IBOutlet var pieView: PieChartView!
    
    
    @IBOutlet var barline: UIView!

    @IBOutlet var lineline: UIView!
    
    @IBOutlet var pieline: UIView!
    
    
    func changebuttontint(type: charttype) {
        
        if type == charttype.bar {
            
            barButtonOutlet.tintColor = UIColorFromHex(0x31797D)
            lineButtonOutlet.tintColor = UIColorFromHex(0x979797)
            pieButtonOutlet.tintColor = UIColorFromHex(0x979797)
            
            barButtonOutlet.backgroundColor = UIColorFromHex(0xFFFFFF)
            lineButtonOutlet.backgroundColor = UIColorFromHex(0xFAFAFA)
            pieButtonOutlet.backgroundColor = UIColorFromHex(0xFAFAFA)
            
            barline.backgroundColor = UIColorFromHex(0xFFFFFF)
            lineline.backgroundColor = UIColorFromHex(0xE0E0E0)
            pieline.backgroundColor = UIColorFromHex(0xE0E0E0)
            
        } else if type == charttype.line { // now for test
            barButtonOutlet.tintColor = UIColorFromHex(0x979797)
            lineButtonOutlet.tintColor = UIColorFromHex(0x31797D)
            pieButtonOutlet.tintColor = UIColorFromHex(0x979797)
            
            barButtonOutlet.backgroundColor = UIColorFromHex(0xFAFAFA)
            lineButtonOutlet.backgroundColor = UIColorFromHex(0xFFFFFF)
            pieButtonOutlet.backgroundColor = UIColorFromHex(0xFAFAFA)
            
            barline.backgroundColor = UIColorFromHex(0xE0E0E0)
            lineline.backgroundColor = UIColorFromHex(0xFFFFFF)
            pieline.backgroundColor = UIColorFromHex(0xE0E0E0)

            
        } else if type == charttype.pie { // now for test
            
            barButtonOutlet.tintColor = UIColorFromHex(0x979797)
            lineButtonOutlet.tintColor = UIColorFromHex(0x979797)
            pieButtonOutlet.tintColor = UIColorFromHex(0x31797D)
            
            barButtonOutlet.backgroundColor = UIColorFromHex(0xFAFAFA)
            lineButtonOutlet.backgroundColor = UIColorFromHex(0xFAFAFA)
            pieButtonOutlet.backgroundColor = UIColorFromHex(0xFFFFFF)
            
            barline.backgroundColor = UIColorFromHex(0xE0E0E0)
            lineline.backgroundColor = UIColorFromHex(0xE0E0E0)
            pieline.backgroundColor = UIColorFromHex(0xFFFFFF)

        }
        
    }
    
    // CHARTS REALM
    func choosebartype(type: charttype) {
        
        changebuttontint(type)
        
       // graphView.subviews.forEach({ $0.removeFromSuperview() })
        graphView.subviews.forEach({ $0.hidden = true })
        
        if type == charttype.bar {
            
            barView.hidden = false
            
            
           // setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: TimePeriodType.custom))

            
        } else if type == charttype.line { // now for test
            
            lineView.hidden = false
            
         //setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: TimePeriodType.custom))
            
        } else if type == charttype.pie { // now for test
            
            pieView.hidden = false
            
           // setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: TimePeriodType.custom))
            
        }
        
    }

    @IBAction func barAction(sender: AnyObject) {
        
        
        
        choosebartype(charttype.bar)
        
    }
    
    @IBAction func lineAction(sender: AnyObject) {
        
        choosebartype(charttype.line) //line)
    }
    
    
    @IBAction func pieAction(sender: AnyObject) {
        
        choosebartype(charttype.pie)
    }
    
    
   
    
    @IBAction func donebutton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBOutlet var openMenu: UIBarButtonItem!
    
    
    
    override func viewDidAppear(animated: Bool) {
        //setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: timeperiodtype))
        choosebartype(charttype.bar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let local = NSLocale.currentLocale()
        statsymbol = local.objectForKey(NSLocaleCurrencySymbol) as! String

        if let currencyCode = NSLocale.currentLocale().objectForKey(NSLocaleCurrencyCode) as? String {
            statcode = currencyCode

        }
        
        loadingview.backgroundColor = UIColor.whiteColor()
        loadingview.layer.cornerRadius = 12
      
        // set defaults 
        timeperiodtype = TimePeriodType.week
        chosentimestep = TimeStep.days
        
        chosenduedate = NSDate()
        chosenfromdate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: -7,
            toDate: chosenduedate,
            options: NSCalendarOptions.MatchStrictly)!
        
        
        //setChart(barView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: timeperiodtype))
        // MOVED TO DID APPEAR
        
        setChart(barView, linechart: lineView, piechart: pieView, prices: handledata(chosenfromdate, duedate: chosenduedate, timestep: chosentimestep, timeperiodtype: timeperiodtype))
      //  choosebartype(charttype.bar)
       
        //

            steplabel.text = NSLocalizedString("days", comment: "")
        
           periodlabel.text = NSLocalizedString("oneweek", comment: "")
        
        //
       
        openMenu.target = self.revealViewController()
        openMenu.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            

        
        tblExpandable.registerNib(UINib(nibName: "choosedatescell", bundle: nil), forCellReuseIdentifier: "choosedates")
        // Do any additional setup after loading the view.
        
        tblExpandable.tableFooterView = UIView()
        stepsTbl.tableFooterView = UIView()
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

        if tableView == tblExpandable {
        
        if section == 0 {
            if pickerexpanded {
            return 2
            } else {
                return 1
            }
        }
    
        return 1
        
        } else if tableView == stepsTbl {
            return 1
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
    
    let stepidentifiers : [String] = ["daysstep", "weeksstep", "monthsstep", "yearsstep"]
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         if tableView == tblExpandable {
        
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

        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! choosedatescell
        
        if indexPath.section == 0 {

            if indexPath.row == 0 {
            cell.frombutton.addTarget(self, action: "choosefromdate:", forControlEvents: .TouchUpInside)
            
            
            cell.duebutton.addTarget(self, action: "chooseduedate:", forControlEvents: .TouchUpInside)
            
            }
            if indexPath.row == 1 {
            cell.datepicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
                
            cell.donebutton.addTarget(self, action: "donebuttontapped:", forControlEvents: .TouchUpInside)
                
            }
        }
        
            if timeperiodtype == TimePeriodType.custom {
                
                    cell.accessoryType = .None
                
            } else if timeperiodtype == TimePeriodType.week {
                if indexPath.section == 1 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            } else if timeperiodtype == TimePeriodType.month {
                if indexPath.section == 2 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            } else if timeperiodtype == TimePeriodType.year {
                if indexPath.section == 3 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
        
        
        return cell
        
    } else {
            
            var identifier = String()
            if indexPath.section == 0 {
                identifier = stepidentifiers[0]
            } else if indexPath.section == 1 {
                identifier = stepidentifiers[1]
            } else if indexPath.section == 2 {
                identifier = stepidentifiers[2]
            } else if indexPath.section == 3 {
                identifier = stepidentifiers[3]
                
            }

             let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! choosedatescell
            
            if chosentimestep == TimeStep.days {
                if indexPath.section == 0 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            } else if chosentimestep == TimeStep.weeks {
                if indexPath.section == 1 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            } else if chosentimestep == TimeStep.months {
                if indexPath.section == 2 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            } else if chosentimestep == TimeStep.years {
                if indexPath.section == 3 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
            
            
            return cell
    
    }
    
    
    }
    
    
    var pickerexpanded : Bool = false
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == tblExpandable {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            return 260
            
        }
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 74
            
        }
        
    return 44
        } else {
            return 44
        }
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
        
       // tblExpandable.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
        tblExpandable.reloadData()
    }
    
    var isfromdate : Bool = true
    
    func choosefromdate(sender: UIButton!) {
        
        isfromdate = true
        

        
        let indexs = NSIndexPath(forRow: 0, inSection: 0)
        let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
        
        cell.fromdateline.backgroundColor = UIColorFromHex(0x31797D, alpha: 1)
        cell.duedateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
      
        if !pickerexpanded {
        expand(indexs)
        }

        

    }
    
    func chooseduedate(sender: UIButton!) {
        
        isfromdate = false
        

        
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

        
        var indexs = NSIndexPath(forRow: 0, inSection: 0)

        
        let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
        
        
        var dateFormatter = NSDateFormatter()
        var dateFormatter1 = NSDateFormatter()

        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        if isfromdate {
            
        chosenfromdate = datePicker.date
        cell.fromdate.text = strDate
        } else {
        chosenduedate = datePicker.date
        cell.duedate.text = strDate
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == tblExpandable {
            
            let cell = tblExpandable.cellForRowAtIndexPath(indexPath) as! choosedatescell
           
            
            if indexPath.section == 1 {
                
                cell.accessoryType = .Checkmark
                
                let today = NSDate()
                let seconddate = NSCalendar.currentCalendar().dateByAddingUnit(
                    .Day,
                    value: -7,
                    toDate: today,
                    options: NSCalendarOptions.MatchStrictly)!
                
                chosenfromdate = seconddate
                chosenduedate = today
                
                timeperiodtype = TimePeriodType.week
                chosentimestep = TimeStep.days
                
                let indexs = NSIndexPath(forRow: 0, inSection: 0)
                let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
                
                cell.fromdate.text = ""
                cell.duedate.text = ""
                cell.duedateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
                cell.fromdateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)


                
            } else if indexPath.section == 2 {
                
                cell.accessoryType = .Checkmark
                
                let today = NSDate()
                let seconddate = NSCalendar.currentCalendar().dateByAddingUnit(
                    .Month,
                    value: -1,
                    toDate: today,
                    options: NSCalendarOptions.MatchStrictly)!
                
                chosenfromdate = seconddate
                chosenduedate = today
                
                timeperiodtype = TimePeriodType.month
                chosentimestep = TimeStep.weeks
                
                let indexs = NSIndexPath(forRow: 0, inSection: 0)
                let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
                
                cell.fromdate.text = ""
                cell.duedate.text = ""
                cell.duedateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
                cell.fromdateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
                
                let index2 = NSIndexPath(forRow: 0, inSection: 0)
                let cel2 = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell


                
            } else if indexPath.section == 3 {
                
                cell.accessoryType = .Checkmark
                
                let today = NSDate()
                let seconddate = NSCalendar.currentCalendar().dateByAddingUnit(
                    .Year,
                    value: -1,
                    toDate: today,
                    options: NSCalendarOptions.MatchStrictly)!
                
                chosenfromdate = seconddate
                chosenduedate = today
                
                timeperiodtype = TimePeriodType.year
                chosentimestep = TimeStep.months
                
                let indexs = NSIndexPath(forRow: 0, inSection: 0)
                let cell = tblExpandable.cellForRowAtIndexPath(indexs) as! choosedatescell
                
                cell.fromdate.text = ""
                cell.duedate.text = ""
                cell.duedateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
                cell.fromdateline.backgroundColor = UIColorFromHex(0xE0E0E0, alpha: 1)
                
            }
            
            tblExpandable.reloadData()
            stepsTbl.reloadData()
            
        } else {
            
                
                let cell = stepsTbl.cellForRowAtIndexPath(indexPath) as! choosedatescell
                
                if indexPath.section == 0 {
                    
                    cell.accessoryType = .Checkmark

                    chosentimestep = TimeStep.days
                } else if indexPath.section == 1 {
                    
                    cell.accessoryType = .Checkmark
                    
                    chosentimestep = TimeStep.weeks
                } else if indexPath.section == 2 {
                    
                    cell.accessoryType = .Checkmark
                    
                    chosentimestep = TimeStep.months
                } else if indexPath.section == 3 {
                    
                    cell.accessoryType = .Checkmark
                    
                    chosentimestep = TimeStep.years
            }
            
            stepsTbl.reloadData()
        }
        
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
