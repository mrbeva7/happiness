//
//  ViewController.swift
//  Airport
//
//  Created by iosdev on 6.4.2016.
//  Copyright © 2016 W4happiness. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
     let moc = DataController().managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetch(){
        let passengerFetch = NSFetchRequest(entityName: "Passenger")
        
        do{
            let fetchedPassenger = try moc.executeFetchRequest(passengerFetch) as! [Passenger]
            print(fetchedPassenger.first!.name!)
        }catch{
            fatalError("bad things happened \(error)")
        }
    }
    
    func seedPassenger(){

    let entity = NSEntityDescription.insertNewObjectForEntityForName("Passenger", inManagedObjectContext: moc) as! Passenger
        
        entity.setValue("1", forKey: "uid")
        entity.setValue("Chuong", forKey:"name")
        entity.setValue("1,2", forKey:"position")
        entity.setValue("15:39", forKey:"boardingTime")
    
    do{
        try moc.save()
    }catch{
        fatalError("failure to save context: \(error)")
    }
  }
}

