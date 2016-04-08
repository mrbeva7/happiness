//
//  Passenger+CoreDataProperties.swift
//  Airport
//
//  Created by iosdev on 8.4.2016.
//  Copyright © 2016 W4happiness. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Passenger {

    @NSManaged var boardingTime: NSDate?
    @NSManaged var name: String?
    @NSManaged var position: NSNumber?
    @NSManaged var uid: NSNumber?
    @NSManaged var passengerPos: Location?

}
