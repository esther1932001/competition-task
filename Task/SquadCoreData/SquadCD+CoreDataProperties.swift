//
//  SquadCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 26/06/2024.
//

import Foundation
import CoreData

@objc(SquadCD)
public class SquadCD: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SquadCD> {
        return NSFetchRequest<SquadCD>(entityName: "SquadCD")
    }

    // Attributes
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var position: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var nationality: String?

    // Relationship to TeamCD
    @NSManaged public var team: TeamCD?

}
