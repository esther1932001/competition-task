//
//  WinnerCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension WinnerCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WinnerCD> {
        return NSFetchRequest<WinnerCD>(entityName: "WinnerCD")
    }

    // Add your @NSManaged properties here
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var shortName: String?
    @NSManaged public var tla: String?
    @NSManaged public var crest: String?
    @NSManaged public var address: String?
    @NSManaged public var website: String?
    @NSManaged public var founded: Int32
    @NSManaged public var clubColors: String?
    @NSManaged public var venue: String?
    @NSManaged public var lastUpdated: Date?

}
