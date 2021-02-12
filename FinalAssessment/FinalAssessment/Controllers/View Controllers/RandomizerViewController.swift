//
//  RandomizerViewController.swift
//  FinalAssessment
//
//  Created by Chris Withers on 2/12/21.
//

import UIKit

class RandomizerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        RandomizerController.shared.fetchPeople()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        RandomizerController.shared.fetchPeople()
//    }
    
    
    @IBAction func addPerson(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add person", message: "Add someone new to the list", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Add person here"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = alertController.textFields,
                  let personName = textField[0].text, !personName.isEmpty else { return }
            RandomizerController.shared.addPerson(name: personName)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
        
    }
}

extension RandomizerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RandomizerController.shared.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        cell.textLabel?.text = RandomizerController.shared.people[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = RandomizerController.shared.people[indexPath.row]
            RandomizerController.shared.deletePerson(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
}
