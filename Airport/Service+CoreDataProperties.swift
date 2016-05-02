//
//  Service+CoreDataProperties.swift
//  
//
//  Created by iosdev on 2.5.2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Service {

    @NSManaged var name: String?
    @NSManaged var serviceID: NSNumber?
    @NSManaged var serviceLoc: NSSet?

}
