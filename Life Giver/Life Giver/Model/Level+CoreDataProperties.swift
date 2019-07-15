//
//  Level+CoreDataProperties.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension Level {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Level> {
        return NSFetchRequest<Level>(entityName: "Level")
    }

    @NSManaged public var state: String?
    @NSManaged public var completion: Int16
    @NSManaged public var id: Int16

}
