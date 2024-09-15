//
//  User+CoreDataProperties.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 01.09.2024.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension UserCD : Identifiable {

}
