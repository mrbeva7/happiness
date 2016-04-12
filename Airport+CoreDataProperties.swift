//
//  Airport+CoreDataProperties.swift
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

extension Airport {

    @NSManaged var airportID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var location: String?

}
