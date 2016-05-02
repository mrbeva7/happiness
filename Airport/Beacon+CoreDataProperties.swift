//
//  Beacon+CoreDataProperties.swift
//  
//
//  Created by iosdev on 1.5.2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beacon {

    @NSManaged var beaconID: NSNumber?
    @NSManaged var major: NSNumber?
    @NSManaged var minor: NSNumber?
    @NSManaged var uuid: String?
    @NSManaged var beaconLoc: Location?

}
