//
//  AreaCD+CoreDataProperties.swift
//  Pods
//
//  Created by esterelzek on 23/06/2024.
//

import Foundation
import CoreData

extension AreaCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AreaCD> {
        return NSFetchRequest<AreaCD>(entityName: "AreaCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var flag: String?

}
