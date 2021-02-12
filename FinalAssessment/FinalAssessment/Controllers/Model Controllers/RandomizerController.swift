//
//  RandomizerController.swift
//  FinalAssessment
//
//  Created by Chris Withers on 2/12/21.
//

import CoreData

class RandomizerController {
    
    static var shared = RandomizerViewController()
    
    var people: [Person] = []
    
    private lazy var fetchRequest: NSFetchRequest<Person> = {
        let request = NSFetchRequest<Person>(entityName: "Person")
         request.predicate = NSPredicate(value: true)
         return request
     }()
    
    func fetchPeople() {
        people = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func addPerson(name: String) {
        Person(name: name)
        CoreDataStack.saveContext()
    }
    
    func deletePerson(person: Person) {
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
    }
    
    func randomize() {
        
    }
    
    
    
}
