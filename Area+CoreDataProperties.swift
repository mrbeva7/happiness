//
//  Area+CoreDataProperties.swift
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

extension Area {

    @NSManaged var area: String?
    @NSManaged var areaID: NSNumber?
    @NSManaged var locationLevel: NSSet?

}
