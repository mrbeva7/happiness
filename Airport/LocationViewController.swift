//
//  LocationViewController.swift
//  Airport
//
//  Created by iosdev on 2.5.2016.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var managedObjectContext: NSManagedObjectContext!
    var locations:[NSManagedObject]!


    @IBOutlet weak var locationListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Service Cell")
        locationListView.delegate = self
        locationListView.dataSource = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        addDataToLocation()
        self.fetchServices()
    }
    
    func fetchServices()
    {
        //let userService: NSString = "Service"
        let fetchRequest = NSFetchRequest(entityName: "Location")
        
        //let moc = self.managedObjectContext
        //print("Entities: \(moc.persistentStoreCoordinator?.managedObjectModel.entitiesByName)")
        //let obj = NSEntityDescription.insertNewObjectForEntityForName("Service", inManagedObjectContext:moc)
        //print(obj)
        
        do{
            // let serviceObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            let locationObjects = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
            self.locations = locationObjects // as! [NSManagedObject]
        }catch let error as NSError{
            print("could not fetch services \(error), \(error.userInfo)")
        }
        self.locationListView.reloadData()
    }

    // MARK: - UITableViewDatasource
    
    // populates locations into table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.locations.count
    }
    
    //indexPath has info of which section and which row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Service Cell", forIndexPath: indexPath)
        
        let service = locations[indexPath.row]
        cell.textLabel?.text = service.valueForKey("name") as? String
        
        return cell
    }
    
    // MARK: Add Data to Location
    // coordinate for the location
    func addDataToLocation(){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        let newLocation1 = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! NSManagedObject
        //TERMINAL : level 1
        newLocation1.setValue(9, forKey: "locationID")
        newLocation1.setValue(1, forKey: "locationLevel")
        newLocation1.setValue("terminal 1", forKey: "name")
        newLocation1.setValue(7, forKey: "x")
        newLocation1.setValue(4, forKey: "y")
        
        let newLocation2 = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! NSManagedObject
        //RESTAURANT : level 2
        newLocation2.setValue(10, forKey: "locationID")
        newLocation2.setValue(2, forKey: "locationLevel")
        newLocation2.setValue("hesburger", forKey: "name")
        newLocation2.setValue(2, forKey: "x")
        newLocation2.setValue(3, forKey: "y")
        
        
        //SHOP : level 3
        let newLocation3 = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! NSManagedObject
        newLocation3.setValue(11, forKey: "locationID")
        newLocation3.setValue(3, forKey: "locationLevel")
        newLocation3.setValue("moonin shop", forKey: "name")
        newLocation3.setValue(4, forKey: "x")
        newLocation3.setValue(5, forKey: "y")
        
        //GATE : level 4
        let newLocation4 = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! NSManagedObject
        newLocation4.setValue(12, forKey: "locationID")
        newLocation4.setValue(4, forKey: "locationLevel")
        newLocation4.setValue("Gate1", forKey: "name")
        newLocation4.setValue(5, forKey: "x")
        newLocation4.setValue(7, forKey: "y")
        
        try! context.save()
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

}
