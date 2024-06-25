//
//  SeasonCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension SeasonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeasonCD> {
        return NSFetchRequest<SeasonCD>(entityName: "SeasonCD")
    }

    // Add your @NSManaged properties here
    @NSManaged public var id: Int32
    @NSManaged public var startDate: String?
    @NSManaged public var endDate: String?
    @NSManaged public var currentMatchday: Int32
    @NSManaged public var winner: WinnerCD?

}
