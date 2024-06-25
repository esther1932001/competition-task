//
//  PostsCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//
import Foundation
import CoreData

// Ensure you are in the correct context and module where PostsCD is defined
extension PostsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostsCD> {
        return NSFetchRequest<PostsCD>(entityName: "PostsCD")
    }

    @NSManaged public var count: Int32
    @NSManaged public var filters: FiltersCD?
    @NSManaged public var competition: CompetitionCD?
    @NSManaged public var season: SeasonCD?
    @NSManaged public var teams: NSSet?
    @NSManaged public var competitions: NSSet?
}

// MARK: Generated accessors for competitions
extension PostsCD {

    @objc(addCompetitionsObject:)
    @NSManaged public func addToCompetitions(_ value: CompetationDetailsCD)

    @objc(removeCompetitionsObject:)
    @NSManaged public func removeFromCompetitions(_ value: CompetationDetailsCD)

    @objc(addCompetitions:)
    @NSManaged public func addToCompetitions(_ values: NSSet)

    @objc(removeCompetitions:)
    @NSManaged public func removeFromCompetitions(_ values: NSSet)

}

// MARK: Generated accessors for teams
extension PostsCD {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: TeamCD)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: TeamCD)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)

}
