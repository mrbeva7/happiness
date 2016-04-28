//
//  CheckInViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/21/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//Reference(Core Data) :
// 1)http://code.tutsplus.com/tutorials/core-data-and-swift-relationships-and-more-fetching--cms-25070
// 2)https://www.youtube.com/watch?v=zNM-vBMFsDI
// 3)https://www.youtube.com/watch?v=3IDfgATVqHw

class CheckInViewController : UIViewController, UITextFieldDelegate {

    //Mark : video starts here
    @IBOutlet var webView: UIWebView!
    
    override func viewDidAppear(animated: Bool) {
        webView.allowsInlineMediaPlayback = true
        
        let youtubeUrl = "https://www.youtube.com/embed/J6c8Vhoc38E"
        
        print("\(webView.frame.width), \(webView.frame.height)")
        
        webView.loadHTMLString("<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(youtubeUrl)?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }
    
    
    //Mark :for input passenger info : name, departure time, remaining time
    @IBOutlet weak var PasName: UITextField!
    @IBOutlet weak var pasBoardingT: UITextField!
    
    //Reference(Guide to NSDate) : http://www.appcoda.com/nsdate/
    let dateFormatter = NSDateFormatter()
    var currentDate : NSDate = NSDate()
    var systemTime : NSDate = NSDate()
    
    //Reference(Count down app) : https://www.youtube.com/watch?v=iiHwWPaUrmw
    //Reference(datepicker) :http://blog.apoorvmote.com/change-textfield-input-to-datepicker/s
    //Mark : timer for Remaining time
    @IBOutlet weak var remainingTR: UILabel!
    var remainingTime : NSTimeInterval = NSTimeInterval()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    let userCalender = NSCalendar.currentCalendar()
    
    let requestedComponent: NSCalendarUnit = [
        NSCalendarUnit.Month,
        NSCalendarUnit.Day,
        NSCalendarUnit.Hour,
        NSCalendarUnit.Minute,
        NSCalendarUnit.Second
    ]
    
    
    //Mark : save passenger info data
    @IBAction func savePasInfoBtn(sender: UIButton) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newPassanger = NSEntityDescription.insertNewObjectForEntityForName("Passenger", inManagedObjectContext: context) as! NSManagedObject
        newPassanger.setValue(PasName!.text, forKey: "name")
        print("system time with a save button click\(systemTime)")
        newPassanger.setValue(systemTime, forKey: "boardingTime")
        
        try! context.save()
        print(newPassanger)
        
        //Mark : CountDown Timer
        let countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        
        print("countDownTimer,\(countDownTimer)")
        
    }
    
    //Mark : print time for CountDown Timer
    func printTime(){
        //dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        let startingTime = NSDate()
        let endingTime = systemTime
        
        let timeDifference = userCalender.components(requestedComponent, fromDate: startingTime, toDate: endingTime, options:[])
        
        remainingTR.text = "\(timeDifference.hour): \(timeDifference.minute):\(timeDifference.second)"
        
    }
    
    //Mark : load saved passenger info data
    @IBAction func loadPasInfoBtn(sender: UIButton) {
        closeKB()
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Passenger")
        request.returnsObjectsAsFaults = false;
        
        var results:NSArray
        
        do {
            results = try context.executeFetchRequest(request)
            
            if(results.count > 0){
                for res in results {
                    print(res)
                }
            } else {
                print("0 results returned")
            }
            
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    // MARK : UIDatePicker
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        //Mark : display only times(not Month and day)
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        print("input \(datePickerView)")
        
        datePickerView.addTarget(self, action: #selector(CheckInViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker){
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        pasBoardingT!.text = dateFormatter.stringFromDate(sender.date)
        let dateString = dateFormatter.stringFromDate(sender.date)
        
        print( "sender dateString,\(dateString)")
        print( "sender date,\(sender.date)")
        
        systemTime = sender.date
        remainingTime = systemTime.timeIntervalSinceDate(currentDate)
        print("remainingTime,\(remainingTime)")
        let hours = floor(remainingTime/3600)
        let minutes = floor(remainingTime/60-hours*60)
        let seconds = round(remainingTime - hours*3600 - minutes*60) // It's giving same time! It needs to be fixed
        print("Hours:\(hours) Minute: \(minutes)")
    
    }
    
    
    // MARK: Helper functions
    func closeKB(){
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closeKB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark: Data delegate
        pasBoardingT?.delegate = self
    }
    
//    func setTime(sender: UIDatePicker) {
//        let timeFormatter = NSDateFormatter()
//        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
//        departureTimeLabel.text = timeFormatter.stringFromDate(sender.date)
//    }
//    
//    @IBAction func timePicker(sender: UIDatePicker) {
//        setTime(sender)
    }
    
    //Alert message: ask user to turn on the bluetooth.
    
    //Alert message: ask user to give permission to turn on the camera
    
//}
