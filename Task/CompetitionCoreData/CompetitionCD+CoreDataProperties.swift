//
//  CompetitionCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension CompetitionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompetitionCD> {
        return NSFetchRequest<CompetitionCD>(entityName: "CompetitionCD")
    }

    // Add your @NSManaged properties here
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var type: String?
    @NSManaged public var emblem: String?

}
