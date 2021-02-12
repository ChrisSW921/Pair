//
//  RandomizerController.swift
//  FinalAssessment
//
//  Created by Chris Withers on 2/12/21.
//

import CoreData

class RandomizerController {
    
    //MARK: - Properties
    static var shared = RandomizerController()
    
    var people: [Person] = []
    var sectionedPeople: [[Person]] = []
    
    private lazy var fetchRequest: NSFetchRequest<Person> = {
        let request = NSFetchRequest<Person>(entityName: "Person")
         request.predicate = NSPredicate(value: true)
         return request
     }()
    
    //MARK: - Methods
    func fetchPeople() {
        people = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        randomize()
    }
    
    func addPerson(name: String) {
        Person(name: name)
        CoreDataStack.saveContext()
        fetchPeople()
    }
    
    func deletePerson(person: Person) {
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
        fetchPeople()
    }
    
    func randomize() {
        let randomizedPeople = people.shuffled()
        sectionedPeople = []
        var pair: [Person] = []

        for person in randomizedPeople {
            if pair.count == 2 {
                sectionedPeople.append(pair)
                pair = []
                if person == randomizedPeople.last {
                    pair.append(person)
                    sectionedPeople.append(pair)
                    pair = []
                } else {
                    pair.append(person)
                }
            }else {
                if person == randomizedPeople.last {
                    pair.append(person)
                    sectionedPeople.append(pair)
                    pair = []
                } else {
                    pair.append(person)
                }
            }
        }
        
        if pair.count > 0 {
            sectionedPeople.append(pair)
        }
    } 
}
