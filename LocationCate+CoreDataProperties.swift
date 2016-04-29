//
//  LocationCate+CoreDataProperties.swift
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

extension LocationCate {

    @NSManaged var level: String?
    @NSManaged var locationCateID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var locationLevel: NSSet?

}
