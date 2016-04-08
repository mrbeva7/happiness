//
//  Location+CoreDataProperties.swift
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

extension Location {

    @NSManaged var locationID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var position: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var locationPas: NSSet?
    @NSManaged var locationCor: Coordinate?
    @NSManaged var locationType: Category?

}
