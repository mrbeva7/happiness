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
    @IBOutlet weak var ServiceListTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.ServiceListTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Service Cell")
        ServiceListTable.delegate = self
        ServiceListTable.dataSource = self
        
        //self.title = "Airport"
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        print("managedObjectContext",managedObjectContext)
        print("managedObjectContext.persistentStoreCoordinator?.managedObjectModel.entities", managedObjectContext.persistentStoreCoordinator?.managedObjectModel.entities)
        //self.fetchServices()
        addDataToService()
        addDataToArea()
        addDataToBeacon()
        addDataToLocation()
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.fetchServices()
    }
    
    
    func fetchServices()
        {
        //let userService: NSString = "Service"
        let fetchRequest = NSFetchRequest(entityName: "Service")
            
            let moc = self.managedObjectContext
            print("Entities: \(moc.persistentStoreCoordinator?.managedObjectModel.entitiesByName)")
            let obj = NSEntityDescription.insertNewObjectForEntityForName("Service",
                                                                          inManagedObjectContext:moc)
            print(obj)
        
        do{
            let entryObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            self.services = entryObjects as! [NSManagedObject]
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
        print("context", context)
        print("managedObjectContet", managedObjectContext)
        print("appDel.managedObjectContet", appDel.managedObjectContext)
        
        //inManagedObjectContext: context
        
        var newCategory = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: self.managedObjectContext) as! NSManagedObject
        
        newCategory.setValue(1, forKey: "serviceID")
        newCategory.setValue("Restaurants", forKey: "name")
        
        newCategory.setValue(2, forKey: "serviceID")
        newCategory.setValue("Shops", forKey: "name")
        
        newCategory.setValue(3, forKey: "serviceID")
        newCategory.setValue("Toilet", forKey: "name")
        
        newCategory.setValue(4, forKey: "serviceID")
        newCategory.setValue("SmokingArea", forKey: "name")
        
        newCategory.setValue(5, forKey: "serviceID")
        newCategory.setValue("Playground", forKey: "name")
        
        newCategory.setValue(6, forKey: "serviceID")
        newCategory.setValue("Powerstation", forKey: "name")
        
        newCategory.setValue(7, forKey: "serviceID")
        newCategory.setValue("CurrencyExchange", forKey: "name")
        
        newCategory.setValue(8, forKey: "serviceID")
        newCategory.setValue("Info", forKey: "name")
        
        newCategory.setValue(9, forKey: "serviceID")
        newCategory.setValue("Location", forKey: "name")
        
        newCategory.setValue(10, forKey: "serviceID")
        newCategory.setValue("Terminal", forKey: "name")
        
        newCategory.setValue(11, forKey: "serviceID")
        newCategory.setValue("Gate", forKey: "name")
        
        try! context.save()
        print(newCategory)
        
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

    
    //    @IBOutlet weak var departureTimeTextField: UITextField!
    
    //    @IBOutlet weak var departureTimeTextField: UITextField!
    
    // Handle the text field’s user input through delegate callbacks.
    //        departureTimeTextField.delegate = self


//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        // Hide the keyboard.
//        textField.resignFirstResponder()
//        return true
//    }
//
//    func textFieldDidEndEditing(textField: UITextField) {
//        departureTimeLabel.text = textField.text
//    }

}