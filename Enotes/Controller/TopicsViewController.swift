//
//  NotesViewController.swift
//  Enotes
//
//  Created by Eric Tran on 6/13/18.
//  Copyright © 2018 Eric Tran. All rights reserved.
//

import UIKit
import CoreData

class TopicsViewController: UITableViewController {
    
    var topics = [Topic]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCustomCell", for: indexPath)
        cell.textLabel?.text = topics[indexPath.row].title
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNote", sender: self)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Topic", message: "Add a topic", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTopic = Topic(context: self.context)
            newTopic.title = textField.text!
            self.topics.append(newTopic)
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Topic"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data manipulation method
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("failed to save, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<Topic> = Topic.fetchRequest()
        do {
            topics = try context.fetch(request)
        } catch {
            print("failed to fetch, \(error)")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var newView = segue.destination as! SingleNoteViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            newView.selectedTopic = topics[indexPath.row]
        }
    }

}
