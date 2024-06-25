//
//  CompetationDetailsCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension CompetationDetailsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompetationDetailsCD> {
        return NSFetchRequest<CompetationDetailsCD>(entityName: "CompetationDetailsCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var type: String?
    @NSManaged public var emblem: String?
    @NSManaged public var lastUpdated: Date?
    
    // Relationships
    @NSManaged public var area: AreaCD?
    @NSManaged public var currentSeason: SeasonCD?
}
