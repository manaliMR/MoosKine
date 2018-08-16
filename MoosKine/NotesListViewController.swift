//
//  NotesListViewController.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-15.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit
import CoreData

class NotebooksListViewController: UIViewController, UITableViewDataSource {
    
     //  Table View that displays a list of Notebooks
    
    
    
    var dataController:DataController!
    
    var fetchedResultsController:NSFetchedResultsController<Notebook>!
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Notebook> = Notebook.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "notebooks")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch cou;d not be performed: \(error.localizedDescription)")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: )
        navigationItem.rightBarButtonItem = editButtonItem
        
        setupFetchedResultsController()
    }
    
    overide func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchResultController()
        if let indexpath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            fetchedResultsController = nil
        }
        
        // MARK: Actions
        
        // MARK: Editing
        
        
        //Display an alert prompting the user to name a new notebook. Calls
        //addNotebook(name:)
        
        func presentNewNotebookAlert() {
            let alert = UIAlertController(title: "New Notebook", message: "Enter a name for this notebook", preferredStyle: .alert)
            
            // Create actions
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
                if let name = alert.textFields?.first?.text {
                    self?.addNotebook(name: name)
                 }
            }
            saveAction.isEnabled = false
            
            // add a text field
            alert.addTextField { textField in textField.placeholder = "Name"
                NotificationCentre.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: . main) { notif in
                    if let text = textField.text, !text.isEmpty {
                        saveAction.isEnabled = true
                    } else {
                        saveAction.isEnabled = false
                    }
                }
            }
            alert.addAction(cancelAction)
            alert.addAction(saveAction)
            present(alert, animated: true, completion: nil)
        }
        
        // MARK: add a new Notebook to the end of the 'notbooks' array
        
        func addNotebook(name: String ) {
            let notebook = Notebook(context: dataController.viewContext)
            
            notebook.name = name
            notebook.creationDate = Date()
            try? dataController.viewContext.save()
        }
        // MARK: delets the notebook at the specified index path
        
        
            
            
        
    
        

}
