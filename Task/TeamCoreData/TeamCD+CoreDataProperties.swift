//
//  TeamCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//


import Foundation
import CoreData


extension  TeamCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamCD> {
        return NSFetchRequest<TeamCD>(entityName: "TeamCD")
    }

    // Attributes
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var tla: String?
    @NSManaged public var shortName: String?
    @NSManaged public var address: String?
    @NSManaged public var website: String?
    @NSManaged public var founded: Int32
    @NSManaged public var clubColors: String?
    @NSManaged public var venue: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var crest: String?

    // Relationships
    @NSManaged public var runningCompetitions: NSSet?
    @NSManaged public var coach: CoachCD?
    @NSManaged public var squad: Set<SquadCD>?
    @NSManaged public var area: AreaCD?
    
    
    // addToSquad method
    @objc(addToSquadObject:)
    @NSManaged public func addToSquad(_ value: SquadCD)

    @objc(removeFromSquadObject:)
    @NSManaged public func removeFromSquad(_ value: SquadCD)

    @objc(addToSquad:)
    @NSManaged public func addToSquad(_ values: NSSet)

    @objc(removeFromSquad:)
    @NSManaged public func removeFromSquad(_ values: NSSet)
}
