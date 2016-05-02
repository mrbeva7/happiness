//
//  serviceViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/25/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AVFoundation


//Reference (UIViewController vs UITableView) :
//1) http://stackoverflow.com/questions/9375903/how-to-interact-with-uitableview-in-uiviewcontroller
//2) http://stackoverflow.com/questions/27372595/issues-adding-uitableview-inside-a-uiviewcontroller-in-swift

class ServiceViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var managedObjectContext : NSManagedObjectContext!
    var services:[NSManagedObject]!
    var passengerWithBT: [NSManagedObject]!
    var currentDetailViewController: UIViewController
    
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var ServiceListTable: UITableView!
    
    //Mark : timer for Remaining time
    var currentDate : NSDate = NSDate()
    var systemTime : NSDate = NSDate()
    var remainTime : NSTimeInterval = NSTimeInterval()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    let userCalender = NSCalendar.currentCalendar()
    let dateFormatter = NSDateFormatter()
    var boardingT : NSDate = NSDate()
    
    let requestedComponent: NSCalendarUnit = [
        NSCalendarUnit.Month,
        NSCalendarUnit.Day,
        NSCalendarUnit.Hour,
        NSCalendarUnit.Minute,
        NSCalendarUnit.Second
    ]
    
    //Mark : Music variables
    @IBOutlet var PausePlay: UIButton!
    var BackgroundAudio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Nhumo_Mind-Body-and-Soul", ofType: "mp3")!)
    var BackgroundAudioPlayer: AVAudioPlayer!
    
   
    //Reference(init vs viewDidLoad) http://stackoverflow.com/questions/14722300/init-method-vs-a-viewdidload-type-method
    //Try to figure out preventing from populating data twice in every swipe with using init 
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        currentDetailViewController = UIViewController()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        currentDetailViewController = UIViewController()
        super.init(coder:aDecoder)!
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Mark : set for the TableView
        self.ServiceListTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Service Cell")
        ServiceListTable.delegate = self
        ServiceListTable.dataSource = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
 
        //Mark : add the data to core data
        addDataToCoreData()
        
        //Mark : fetch the Service data and boarding time data from Passenger entity
        self.fetchServices()
        self.fetchBoardingTime()
        
        
        //Mark : CountDown Timer
        let countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        print("countDownTimer,\(countDownTimer)")
        
        //Mark : Set Music Player
        do {
            try BackgroundAudioPlayer = AVAudioPlayer(contentsOfURL: BackgroundAudio)
            BackgroundAudioPlayer.play()
        } catch {
            print("error")
        }
    }
    
     //Reference(viewDidLoad vs viewWillAppear) :http://stackoverflow.com/questions/17362095/about-viewcontrollers-viewdidload-and-viewwillappear-methods
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        BackgroundAudioPlayer.stop()
    }
    
    //Mark : print time for CountDown Timer
    func printTime(){
        
        let startingTime = NSDate()
        let endingTime = boardingT
        let timeDifference = userCalender.components(requestedComponent, fromDate: startingTime, toDate: endingTime, options:[])
        
        remainingTime.text = "\(timeDifference.hour): \(timeDifference.minute):\(timeDifference.second)"
        
    }
    
    @IBAction func PausePlay(sender: AnyObject) {
        
        if (BackgroundAudioPlayer.playing == true){
            BackgroundAudioPlayer.stop()
            PausePlay.setImage(UIImage(named: "play"), forState: .Normal)
        } else {
            BackgroundAudioPlayer.play()
            PausePlay.setImage(UIImage(named: "pause"), forState: .Normal)
        }
        
    }
    
    func fetchBoardingTime()
    {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Passenger")

        do{
            let passengerObjects = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
            let index = passengerObjects.count-1
            let object = passengerObjects[index]
            print("Boarding time: \(object.valueForKey("boardingTime"))")
            boardingT = object.valueForKey("boardingTime") as! NSDate
            print("formattedBoardingTime: \(boardingT)")
        }catch let error as NSError{
            print("could not fetch boarding time \(error), \(error.userInfo)")
        }
    }
    
    func fetchServices()
        {
        let fetchRequest = NSFetchRequest(entityName: "Service")
        do{
            let serviceObjects = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
            self.services = serviceObjects
        }catch let error as NSError{
            print("could not fetch services \(error), \(error.userInfo)")
        }
        self.ServiceListTable.reloadData()
    }
    
    
    // MARK: - UITableViewDatasource
    // Populates services into table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.services.count
    }
    
    //indexPath has info of which section and which row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Service Cell", forIndexPath: indexPath)
        
        let service = services[indexPath.row]
        cell.textLabel?.text = service.valueForKey("name") as? String
        
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.ServiceListTable.deselectRowAtIndexPath(indexPath, animated: true)
        let service = self.services[indexPath.row]
        self.performSegueWithIdentifier("serviceToBoarding", sender: service)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    var lableName: [NSManagedObject]!
    
   //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "serviceToBoarding" {
            let locationViewcontroller = segue.destinationViewController as! LocationViewController
                locationViewcontroller.locations = sender as? [NSManagedObject]
                lableName = locationViewcontroller.locations
            
            print("print sender: \(sender)")
        }
    }
    
    // Core Data
    // MARK: Add Data to Service
    func addDataToCoreData(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
    
        
        // Mark : Add Services 
        let newService1 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService1.name = "Restaurant"
        newService1.serviceID = 1
        
        let newService2 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService2.name = "Shop"
        newService2.serviceID = 2
        
        
        let newService3 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService3.name = "Toilet"
        newService3.serviceID = 3
        
        
        let newService4 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService4.name = "Smoking Area"
        newService4.serviceID = 4
        
        
        let newService5 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService5.name = "Playground"
        newService5.serviceID = 5
        
        
        let newService6 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService6.name = "Power Station"
        newService6.serviceID = 6
        
        
        let newService7 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService7.name = "Currency Exchange"
        newService7.serviceID = 7
        
        
        let newService8 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService8.name = "Info"
        newService8.serviceID = 8
        
        
        let newService10 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService10.name = "Terminal"
        newService10.serviceID = 9
        
        
        let newService11 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! Service
        
        newService11.name = "Gate"
        newService11.serviceID = 10
        
        
        // MARK: Add Area
        
        let newArea = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: self.managedObjectContext) as! Area
        
        newArea.areaID = 1
        newArea.area = "Area 1"
        
        let newArea2 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: self.managedObjectContext) as! Area
        
        newArea2.areaID = 2
        newArea2.area = "Area 2"
        
        let newArea3 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: self.managedObjectContext) as! Area
        
        newArea.areaID = 3
        newArea.area = "Area 3"
        
        let newArea4 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: self.managedObjectContext) as! Area
        
        newArea.areaID = 4
        newArea.area = "Area 4"
        
        
        // MARK: Add Beacon
        
        let newBeacon = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: self.managedObjectContext) as! Beacon
        newBeacon.beaconID = 1
        newBeacon.major = 46880
        newBeacon.minor = 36104
        newBeacon.uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        
        //BLUEBERRY
        
        let newBeacon2 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: self.managedObjectContext) as! Beacon
        newBeacon2.beaconID = 2
        newBeacon2.major = 57832
        newBeacon2.minor = 7199
        newBeacon2.uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        
        //MINT
        
        let newBeacon3 = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: self.managedObjectContext) as! Beacon
        newBeacon3.beaconID = 3
        newBeacon3.major = 911
        newBeacon3.minor = 912
        newBeacon3.uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        
        
        //MARK: Add new location
        
         //Restaurant
        createNewLocation(1, name: "Hesburger", x: 1, y: 2, area:newArea2, type: newService1, context: context)
        createNewLocation(2, name: "KFC", x: 2, y: 3, area:newArea2, type: newService1, context: context)
        createNewLocation(3, name: "Robert Coffee Shop", x: 4, y: 5, area:newArea3, type: newService1, context: context)
        
        //Store
        createNewLocation(4, name: "Alepa", x: 4, y: 5, area:newArea2, type: newService2, context: context)
        createNewLocation(5, name: "Apteekki", x: 4, y: 5, area:newArea3, type: newService2, context: context)
        createNewLocation(6, name: "Duty Free Store", x: 4, y: 5, area:newArea3, type: newService2, context: context)
        
        //Terminal
        createNewLocation(7, name: "Terminal 1", x: 4, y: 5, area:newArea, type: newService10, context: context)
        createNewLocation(8, name: "Terminal 2", x: 4, y: 5, area:newArea, type: newService10, context: context)
        
        try! context.save()
        
    }

    //Mark : add the location with relationship with area and service
    private func createNewLocation(locationId: NSNumber, name: String, x: NSNumber, y: NSNumber, area: Area, type: Service, context: NSManagedObjectContext){
        
        let newLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! Location
        newLocation.name = name
        newLocation.locationID = locationId
        newLocation.x = x
        newLocation.y = y
        newLocation.locationAreaLevel = area
        newLocation.locationService = type
    }
    
}