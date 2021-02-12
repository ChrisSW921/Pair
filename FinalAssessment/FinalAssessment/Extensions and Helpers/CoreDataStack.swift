//
//  CoreDataStack.swift
//  FinalAssessment
//
//  Created by Chris Withers on 2/12/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalAssessment")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent stores, \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
}
