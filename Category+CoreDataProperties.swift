//
//  Category+CoreDataProperties.swift
//  Airport
//
//  Created by iosdev on 28.4.2016.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var categoryID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var cateLoc: NSSet?

}