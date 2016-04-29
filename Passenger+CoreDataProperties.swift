//
//  Passenger+CoreDataProperties.swift
//  
//
//  Created by iosdev on 29.4.2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Passenger {

    @NSManaged var boardingTime: NSDate?
    @NSManaged var name: String?
    @NSManaged var position: String?
    @NSManaged var uid: NSNumber?
    @NSManaged var passengerLoc: Location?

}
