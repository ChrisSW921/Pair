//
//  Person+Convenience.swift
//  FinalAssessment
//
//  Created by Chris Withers on 2/12/21.
//

import CoreData

extension Person {
    
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
    
}
