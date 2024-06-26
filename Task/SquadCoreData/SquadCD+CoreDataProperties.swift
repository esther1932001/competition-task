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

//    // Convenience initializer
//    convenience init(id: Int32, name: String?, position: String?, dateOfBirth: String?, nationality: String?) {
//        self.init(context: CoreDataManager.shared.context())
//        self.id = id
//        self.name = name
//        self.position = position
//        self.dateOfBirth = dateOfBirth
//        self.nationality = nationality
//    }
}
