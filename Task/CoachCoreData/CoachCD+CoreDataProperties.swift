//
//  CoachCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension CoachCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoachCD> {
        return NSFetchRequest<CoachCD>(entityName: "CoachCD")
    }

    // Add your @NSManaged properties here
    @NSManaged public var id: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var nationality: String?

}
