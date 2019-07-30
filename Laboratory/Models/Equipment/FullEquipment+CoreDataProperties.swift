//
//  FullEquipment+CoreDataProperties.swift
//  
//
//  Created by Developers on 7/30/19.
//
//

import Foundation
import CoreData


extension FullEquipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FullEquipment> {
        return NSFetchRequest<FullEquipment>(entityName: "FullEquipment")
    }

    @NSManaged public var name: String?
    @NSManaged public var available: Int32
    @NSManaged public var equipmentDescription: String?
    @NSManaged public var location: String?
    @NSManaged public var imageUrl: String?

}
