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
    var currentDetailViewController: UIViewController
    @IBOutlet weak var ServiceListTable: UITableView!
    
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
        addDataToService()
        addDataToArea()
        addDataToBeacon()
        addDataToLocation()
        self.fetchServices()
    }
    
    //Reference(viewDidLoad vs viewWillAppear) :http://stackoverflow.com/questions/17362095/about-viewcontrollers-viewdidload-and-viewwillappear-methods
    
//    override func viewWillAppear(animated: Bool)
//    {
//        super.viewWillAppear(animated)
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
            let serviceObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            self.services = serviceObjects as! [NSManagedObject]
        }catch let error as NSError{
            print("could not fetch entries \(error), \(error.userInfo)")
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
    
    // 11 Populated services into table view
    
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
//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let service = self.services[indexPath.row]
//        self.performSegueWithIdentifier("Show Composer", sender: service)
//    }
//    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
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
//    
//     13 - give the compose vc its entry
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if segue.identifier == "serviceToBoarding" {
//            let locationTableViewController = segue.destinationViewController as! LocationTableViewController
//                locationTableViewController. = sender as? NSManagedObject
//        }
//    }
    
    // Core Data
    // MARK: Add Data to Service
    // Services(type) for the airport
    func addDataToService(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
    
        
        //var servicesList = [NSManagedObject]()
        let newService1 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        
        newService1.setValue(1, forKey: "serviceID")
        newService1.setValue("Restaurants", forKey: "name")
        //try! context.save()
        //servicesList.append(newService1)
        
         let newService2 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService2.setValue(2, forKey: "serviceID")
        newService2.setValue("Shops", forKey: "name")
        //try! context.save()
        //servicesList.append(newService2)
        
        let newService3 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService3.setValue(3, forKey: "serviceID")
        newService3.setValue("Toilet", forKey: "name")
        //servicesList.append(newService3)
        
        
        let newService4 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService4.setValue(4, forKey: "serviceID")
        newService4.setValue("SmokingArea", forKey: "name")
        //servicesList.append(newService4)
        
        let newService5 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService5.setValue(5, forKey: "serviceID")
        newService5.setValue("Playground", forKey: "name")
        //servicesList.append(newService5)
        
        let newService6 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService6.setValue(6, forKey: "serviceID")
        newService6.setValue("Powerstation", forKey: "name")
        //servicesList.append(newService6)
        
        let newService7 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService7.setValue(7, forKey: "serviceID")
        newService7.setValue("CurrencyExchanges", forKey: "name")
        //servicesList.append(newService7)
        
        let newService8 = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext)
        newService8.setValue(8, forKey: "serviceID")
        newService8.setValue("Info", forKey: "name")
        //servicesList.append(newService8)
        
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
        
        try! context.save()
        
    }
    
    // MARK: Add Data to AREA
    // Level for the places in the airport
    func addDataToArea(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newLocationCate = NSEntityDescription.insertNewObjectForEntityForName("Area", inManagedObjectContext: context) as! NSManagedObject
        
        newLocationCate.setValue(1, forKey: "areaID")
        newLocationCate.setValue("1", forKey: "area")
        
        newLocationCate.setValue(2, forKey: "areaID")
        newLocationCate.setValue("2", forKey: "area")
        
        newLocationCate.setValue(3, forKey: "areaID")
        newLocationCate.setValue("3", forKey: "area")
        
        newLocationCate.setValue(4, forKey: "areaID")
        newLocationCate.setValue("4", forKey: "area")
        
        
        try! context.save()
        print(newLocationCate)
        
    }
    
    
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
    
    
    // MARK: Add Data to Location
    // coordinate for the location
    func addDataToLocation(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! NSManagedObject
        //TERMINAL : level 1
        newLocation.setValue(2, forKey: "locationID")
        newLocation.setValue(1, forKey: "locationLevel")
        newLocation.setValue("terminal 1", forKey: "name")
        newLocation.setValue(7, forKey: "x")
        newLocation.setValue(4, forKey: "y")
        
        //RESTAURANT : level 2
        newLocation.setValue(1, forKey: "locationID")
        newLocation.setValue(2, forKey: "locationLevel")
        newLocation.setValue("hesburger", forKey: "name")
        newLocation.setValue(2, forKey: "x")
        newLocation.setValue(3, forKey: "y")
        
        
        //SHOP : level 3
        newLocation.setValue(3, forKey: "locationID")
        newLocation.setValue(3, forKey: "locationLevel")
        newLocation.setValue("moonin shop", forKey: "name")
        newLocation.setValue(4, forKey: "x")
        newLocation.setValue(5, forKey: "y")
        
        //GATE : level 4
        newLocation.setValue(4, forKey: "locationID")
        newLocation.setValue(4, forKey: "locationLevel")
        newLocation.setValue("Gate1", forKey: "name")
        newLocation.setValue(5, forKey: "x")
        newLocation.setValue(7, forKey: "y")
        
        try! context.save()
        print(newLocation)
        
    }

}