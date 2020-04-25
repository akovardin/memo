//
//  Todo+CoreDataProperties.swift
//  Memo
//
//  Created by Artem Kovardin on 25.04.2020.
//  Copyright © 2020 Artem Kovardin. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var text: String?
    @NSManaged public var done: Bool

}
