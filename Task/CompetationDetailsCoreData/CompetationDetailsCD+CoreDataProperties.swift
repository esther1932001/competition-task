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
    @NSManaged public var teams: NSSet?      // Assume this relationship exists
    @NSManaged public var matches: NSSet?    // Assume this relationship exists
}

// MARK: Generated accessors for teams
extension CompetationDetailsCD {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: TeamCD)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: TeamCD)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)
}

// MARK: Generated accessors for matches
extension CompetationDetailsCD {

    @objc(addMatchesObject:)
    @NSManaged public func addToSeasons(_ value: SeasonCD)

    @objc(removeMatchesObject:)
    @NSManaged public func removeFromSeasons(_ value: SeasonCD)

    @objc(addMatches:)
    @NSManaged public func addToSeasons(_ values: NSSet)

    @objc(removeMatches:)
    @NSManaged public func removeFromSeasons(_ values: NSSet)
}
