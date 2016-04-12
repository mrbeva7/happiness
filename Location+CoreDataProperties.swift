//
//  Location+CoreDataProperties.swift
//  Airport
//
//  Created by iosdev on 12.4.2016.
//  Copyright © 2016 W4happiness. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var locationID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var x: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var y: UNKNOWN_TYPE
    @NSManaged var locationLevel: UNKNOWN_TYPE
    @NSManaged var airportName: UNKNOWN_TYPE
    @NSManaged var locationPas: NSSet?
    @NSManaged var locationType: Category?
    @NSManaged var locationCateLevel: LocationCategory?

}
