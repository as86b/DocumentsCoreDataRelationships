//
//Document+CoreDataProperties.swift
//  CategoricalDocuments
//
//  Created by Austin Sizemore on 3/1/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var category: Category?

}
