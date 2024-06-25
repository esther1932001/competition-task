//
//  FiltersCD+CoreDataProperties.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension FiltersCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FiltersCD> {
        return NSFetchRequest<FiltersCD>(entityName: "FiltersCD")
    }

    // Add your @NSManaged properties here
    @NSManaged public var season: String?

}
