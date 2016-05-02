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
    //let dateFormatter = NSDateFormatter()
    var currentDate : NSDate = NSDate()
    var systemTime : NSDate = NSDate()
    var remainTime : NSTimeInterval = NSTimeInterval()
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
    
    //Reference(init vs viewDidLoad) http://stackoverflow.com/questions/14722300/init-method-vs-a-viewdidload-type-method
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        currentDetailViewController = UIViewController()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Let's see we're getting a data in init")
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        print("we are in convenience init")
    }
    
    required init(coder aDecoder: NSCoder) {
        currentDetailViewController = UIViewController()
        super.init(coder:aDecoder)!
        print("we are in required init")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.ServiceListTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Service Cell")
        ServiceListTable.delegate = self
        ServiceListTable.dataSource = self
        
        //self.title = "Airport"
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        //print("managedObjectContext",managedObjectContext)
        //print("managedObjectContext.persistentStoreCoordinator?.managedObjectModel.entities", managedObjectContext.persistentStoreCoordinator?.managedObjectModel.entities)
        //print("printing services.count",services.count)
        //addDataToService()
        //addDataToArea()
        addDataToServiceAndArea()
        addDataToBeacon()
        self.fetchServices()
        
        
        //Mark : CountDown Timer
        let countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        
        print("countDownTimer,\(countDownTimer)")
    }
    
    //Mark : print time for CountDown Timer
    func printTime(){
        //dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        
        let startingTime = NSDate()
        let endingTime = systemTime
        //let endingTime = fetchBoardingTime()
        
        let timeDifference = userCalender.components(requestedComponent, fromDate: startingTime, toDate: endingTime, options:[])
        
        remainingTime.text = "\(timeDifference.hour): \(timeDifference.minute):\(timeDifference.second)"
        
    }
    
    //Reference(viewDidLoad vs viewWillAppear) :http://stackoverflow.com/questions/17362095/about-viewcontrollers-viewdidload-and-viewwillappear-methods
    
//    override func viewWillAppear(animated: Bool)
//    {
//        super.viewWillAppear(animated)
//    }
//    func fetchBoardingTime() -> NSDate
//    {
//        //let userService: NSString = "Service"
//        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        var context:NSManagedObjectContext = appDel.managedObjectContext
//        //request.predicate = NSPredicate(You have to set some format here)
//        let fetchRequest = NSFetchRequest(entityName: "Passenger")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//        fetchRequest.fetchLimit = 1
//        
//        //let moc = self.managedObjectContext
//        //print("Entities: \(moc.persistentStoreCoordinator?.managedObjectModel.entitiesByName)")
//        //let obj = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext:moc)
//        //print(obj)
//        
//        do{
//            // let passengerObject = try managedObjectContext.executeFetchRequest(fetchRequest)
//            // you could try this code : let  result = (try! self.manageContext.executeFetchRequest(FetchRequest)) as! [NSManageObjectClass]
//            let passengerObject = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
//            self.passengerWithBT = passengerObject as! [NSManagedObject]
//        }catch let error as NSError{
//            print("could not fetch boarding time \(error), \(error.userInfo)")
//        }
//        return self.passengerWithBT
//    }
    
    func fetchServices()
        {
        //let userService: NSString = "Service"
        let fetchRequest = NSFetchRequest(entityName: "Service")
            
            //let moc = self.managedObjectContext
            //print("Entities: \(moc.persistentStoreCoordinator?.managedObjectModel.entitiesByName)")
            //let obj = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext:moc)
            //print(obj)
        
        do{
            // let serviceObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            let serviceObjects = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
            self.services = serviceObjects // as! [NSManagedObject]
        }catch let error as NSError{
            print("could not fetch services \(error), \(error.userInfo)")
        }
        self.ServiceListTable.reloadData()
    }
    
//    // MARK: - Target action
//    
//    @IBAction func composeDidClick(sender: AnyObject)
//    {
//        self.performSegueWithIdentifier("Show Composer", sender: nil)
//    }
    
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
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete{
//            let service = self.services[indexPath.row]
//            self.managedObjectContext.deleteObject(service)
//            self.services.removeAtIndex(indexPath.row)
//            
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            
//            do{
//                try self.managedObjectContext.save()
//            }catch let error as NSError{
//                print("Cannot delete object: \(error), \(error.localizedDescription)")
//            }
//        }
//    }
    
     //MARK: - Navigation
    
    //give the compose vc its entry
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "serviceToBoarding" {
            let locationViewcontroller = segue.destinationViewController as! LocationViewController
                locationViewcontroller.locations = sender as? [NSManagedObject]
        }
    }
    
    // Core Data
    // MARK: Add Data to Service
    // Services(type) for the airport
    func addDataToServiceAndArea(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
    
        
        //var servicesList = [NSManagedObject]()
        let newService1 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService1.setValue(1, forKey: "serviceID")
        newService1.setValue("Restaurants", forKey: "name")
        
        let newService2 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService2.setValue(2, forKey: "serviceID")
        newService2.setValue("Shops", forKey: "name")
        
        let newService3 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService3.setValue(3, forKey: "serviceID")
        newService3.setValue("Toilet", forKey: "name")
        
        let newService4 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService4.setValue(4, forKey: "serviceID")
        newService4.setValue("SmokingArea", forKey: "name")
        
        let newService5 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService5.setValue(5, forKey: "serviceID")
        newService5.setValue("Playground", forKey: "name")
        
        let newService6 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService6.setValue(6, forKey: "serviceID")
        newService6.setValue("Powerstation", forKey: "name")
        
        let newService7 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService7.setValue(7, forKey: "serviceID")
        newService7.setValue("CurrencyExchanges", forKey: "name")
        
        let newService8 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService8.setValue(8, forKey: "serviceID")
        newService8.setValue("Info", forKey: "name")

        
        let newService9 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService9.setValue(9, forKey: "serviceID")
        newService9.setValue("Location", forKey: "name")
        //servicesList.append(newService9)
        
        let newService10 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService10.setValue(10, forKey: "serviceID")
        newService10.setValue("Terminal", forKey: "name")
        //servicesList.append(newService10)
        
        let newService11 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService11.setValue(11, forKey: "serviceID")
        newService11.setValue("Gate", forKey: "name")
        //servicesList.append(newService11)
        
        // MARK: Add Data to AREA
        // Level for the places in the airport
        
      
        
         //Restaurant
//        createNewLocation(1, name: "Hesburger", x: 1, y: 2, area:newArea2, type: newService1, context: context)
//        createNewLocation(2, name: "KFC", x: 2, y: 3, area:newArea2, type: newService1, context: context)
//        createNewLocation(3, name: "Robert Coffee Shop", x: 4, y: 5, area:newArea3, type: newService1, context: context)
//        
//        //Store
//        createNewLocation(4, name: "Alepa", x: 4, y: 5, area:newArea2, type: newService2, context: context)
//        createNewLocation(5, name: "Apteekki", x: 4, y: 5, area:newArea3, type: newService2, context: context)
//        createNewLocation(6, name: "Duty Free Store", x: 4, y: 5, area:newArea3, type: newService2, context: context)
//        
//        //Terminal
//        createNewLocation(7, name: "Terminal 1", x: 4, y: 5, area:newArea1, type: newService10, context: context)
//        createNewLocation(8, name: "Terminal 2", x: 4, y: 5, area:newArea1, type: newService10, context: context)
        
        try! context.save()
        
    }
    

    func addDataToArea(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        let newArea1 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: context)
        newArea1.setValue(1, forKey: "areaID")
        newArea1.setValue("1", forKey: "area")
    
        let newArea2 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: context)
        newArea2.setValue(2, forKey: "areaID")
        newArea2.setValue("2", forKey: "area")
    
        let newArea3 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: context)
        newArea3.setValue(3, forKey: "areaID")
        newArea3.setValue("3", forKey: "area")
    
        let newArea4 = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: context)
        newArea4.setValue(4, forKey: "areaID")
        newArea4.setValue("4", forKey: "area")
        try! context.save()
   }
    
//    private func createNewLocation(locationId: NSNumber, name: String, x: NSNumber, y: NSNumber, area: Area, type: Service, context: NSManagedObjectContext){
//        
//        let newLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! Location
//        newLocation.name = name
//        newLocation.locationID = locationId
//        newLocation.x = x
//        newLocation.y = y
//        newLocation.locationAreaLevel = area
//        newLocation.locationService = type
//    }
    
    
    // MARK: Add Data to BEACON
    
    func addDataToBeacon(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newBeacon = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: context) as! NSManagedObject
        
        //ICE
        newBeacon.setValue(1, forKey: "beaconID")
        newBeacon.setValue(46880, forKey: "major")
        newBeacon.setValue(36104, forKey: "minor")
        newBeacon.setValue("B9407F30-F5F8-466E-AFF9-25556B57FE6D", forKey: "uuid")
        
        //BLUEBERRY
        newBeacon.setValue(2, forKey: "beaconID")
        newBeacon.setValue(57832, forKey: "major")
        newBeacon.setValue(7199, forKey: "minor")
        newBeacon.setValue("B9407F30-F5F8-466E-AFF9-25556B57FE6D", forKey: "uuid")
        
        //MINT
        newBeacon.setValue(3, forKey: "beaconID")
        newBeacon.setValue(911, forKey: "major")
        newBeacon.setValue(912, forKey: "minor")
        newBeacon.setValue("B9407F30-F5F8-466E-AFF9-25556B57FE6D", forKey: "uuid")
        
        //        newBeacon.setValue(4, forKey: "beaconID")
        //        newBeacon.setValue(12, forKey: "major")
        //        newBeacon.setValue(23, forKey: "minor")
        //        newBeacon.setValue(B9407F30-F5F8-466E-AFF9-25556B57FE6D, forKey: "uuid")
        
        try! context.save()
        print(newBeacon)
        
    }

}