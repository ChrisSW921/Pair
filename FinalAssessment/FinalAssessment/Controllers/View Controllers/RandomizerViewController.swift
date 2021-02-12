//
//  RandomizerViewController.swift
//  FinalAssessment
//
//  Created by Chris Withers on 2/12/21.
//

import UIKit

class RandomizerViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        RandomizerController.shared.fetchPeople()
        tableView.reloadData()
    }
    
    //MARK: - Actions
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

//MARK: - Table View Extension
extension RandomizerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RandomizerController.shared.sectionedPeople.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RandomizerController.shared.sectionedPeople[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == (RandomizerController.shared.sectionedPeople.count - 1) {
            return 60
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == (RandomizerController.shared.sectionedPeople.count - 1) {
            let footerView = UIView()
            footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
               60)
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: footerView.frame.width, height: 50)
            button.setTitle("Randomize", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.backgroundColor = .lightGray
            button.addTarget(self, action: #selector(randomize), for: .touchUpInside)
            footerView.addSubview(button)
            return footerView
        }
        return nil
    }
    
    @objc func randomize() {
        RandomizerController.shared.randomize()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        cell.textLabel?.text = RandomizerController.shared.sectionedPeople[indexPath.section][indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = RandomizerController.shared.sectionedPeople[indexPath.section][indexPath.row]
            RandomizerController.shared.deletePerson(person: personToDelete)
            tableView.reloadData()
            
        }
    }
}
