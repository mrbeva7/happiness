//
//  DataControllerViewController.swift
//  Airport
//
//  Created by iosdev on 29.4.2016.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import UIKit
import CoreData

class DataControllerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Add Data to Service
    // Services(type) for the airport
    func addDataToService(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newCategory = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext: context) as! NSManagedObject
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
