//
//  Location+CoreDataProperties.swift
//  
//
//  Created by iosdev on 30.4.2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var locationID: NSNumber?
    @NSManaged var locationLevel: NSNumber?
    @NSManaged var name: String?
    @NSManaged var x: NSNumber?
    @NSManaged var y: NSNumber?
    @NSManaged var locationAirport: Airport?
    @NSManaged var locationAreaLevel: Area?
    @NSManaged var locationBeacon: Beacon?
    @NSManaged var locationPas: Passenger?
    @NSManaged var locationService: Service?

}
