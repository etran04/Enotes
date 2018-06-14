//
//  SingleNoteViewController.swift
//  Enotes
//
//  Created by Eric Tran on 6/13/18.
//  Copyright © 2018 Eric Tran. All rights reserved.
//

import UIKit
import CoreData

class SingleNoteViewController: UIViewController {
    
    @IBOutlet weak var textbox: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedTopic : Topic? {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Model manipulation methods
    func saveData() {
        do {
            try context.save()
        } catch {
            print("failed to save, \(error)")
        }
    }
    
    func loadData() {
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        do {
            var temp = try context.fetch(request)
            print(temp)
        } catch {
            print("failed to fetch, \(error)")
        }
    }
}
