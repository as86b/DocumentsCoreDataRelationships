//
//Document+CoreDataClass.swift
//  CategoricalDocuments
//
//  Created by Austin Sizemore on 3/1/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, amount: Double, date: Date?) {
        let appDelegate = UIApplication.shared.delegate as?
            AppDelegate
        
        guard let context =
            appDelegate?.persistentContainer.viewContext
            else {
                return nil
        }
        
        self.init(entity: Document.entity(), insertInto: context)
        self.name = name
        self.contents = contents
        self.date = date
        
        func update(title:String?, contents: String?, date:Date?){
            self.title = title
            self.contents = contents
            self.date = date
        }
    }
    
}
