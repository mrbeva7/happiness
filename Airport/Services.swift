////
////  Services.swift
////  Airport
////
////  Created by iosdev on 30.4.2016.
////  Copyright © 2016 RUBING MAO. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//
//class Services
//{
//    // Variables
//    var name: String            // name of the services
//    var services: [Location]     // all locations in the services
//    
//    init(named: String, includeService: [Location])
//    {
//        name = named
//        services = includeService
//    }
//    
//    //Core data
//    var managedObjectContext : NSManagedObjectContext!
//    var locations:[NSManagedObject]!
//    
//    class func serviceList() -> [Services]
//    {
//        return [self.airportLocations]
//    }
//    
//    // Private methods
//    
//    private class func airportLocations() -> Services {
//    
//        var locations = [Location]()
//        
//        products.append(Product(titled: "Apple Watch", description: "Featuring revolutionary new technologies and a pioneering user interface with a beautiful design that honors the rich tradition of precision watchmaking.", imageName: "apple-watch.png"))
//        
//        let fetchRequest = NSFetchRequest(entityName: "Location")
//        
//        do{
//            let locationObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
//            self.locations = locationObjects as! [NSManagedObject]
//        }catch let error as NSError{
//            print("could not fetch entries \(error), \(error.userInfo)")
//        }
//    
//        return Services(named: "services", includeService: locations)
//    }
//  
//}
//
//
//
//
//
//
//
//
//
//
//
//
