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
        
        //Mark : set for the TableView
        self.locationListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Service Cell")
        locationListView.delegate = self
        locationListView.dataSource = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
        // Mark : call the fetchLocations method
        self.fetchLocations()
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
    
    
    func fetchLocations()
    {
        let fetchRequest = NSFetchRequest(entityName: "Location")
        
        do{
            let locationObjects = (try! self.managedObjectContext.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
            self.locations = locationObjects as! [NSManagedObject]
        }catch let error as NSError{
            print("could not fetch services \(error), \(error.userInfo)")
        }
        self.locationListView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
