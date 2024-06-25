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

// MARK: Generated accessors for area
extension CompetationDetailsCD {

    @objc(addAreaObject:)
    @NSManaged public func addToArea(_ value: AreaCD)

    @objc(removeAreaObject:)
    @NSManaged public func removeFromArea(_ value: AreaCD)

    @objc(addArea:)
    @NSManaged public func addToArea(_ values: NSSet)

    @objc(removeArea:)
    @NSManaged public func removeFromArea(_ values: NSSet)
}

// MARK: Generated accessors for currentSeason
extension CompetationDetailsCD {

    @objc(addCurrentSeasonObject:)
    @NSManaged public func addToCurrentSeason(_ value: SeasonCD)

    @objc(removeCurrentSeasonObject:)
    @NSManaged public func removeFromCurrentSeason(_ value: SeasonCD)

    @objc(addCurrentSeason:)
    @NSManaged public func addToCurrentSeason(_ values: NSSet)

    @objc(removeCurrentSeason:)
    @NSManaged public func removeFromCurrentSeason(_ values: NSSet)
}
