//
//  ViewController.swift
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
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: )
        navigationItem.rightBarButtonItem = editButtonItem
        
        setupFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFetchedResultsController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
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
            alert.addTextField { textField in
                textField.placeholder = "Name"
                NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: .main) { notif in
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
        func deleteNotebook(at indexPath: IndexPath) {
            let notebookToDelete = fetchResultController.object(at: indexPath)
            dataController.viewContext.delete(notebookToDelete)
            try? dataController.viewContext.save()
            
        }
        
        func updateEditButtonState() {
            if let sections = fetchedResultsController.sections {
                navigationItem.rightBarButtonItem?.isEnabled = sections[0].numberOfObjects > 0
            }
        }
        
        override func setEdtiting(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            tableView.setEditing(editing, animated: animated)
        }
        
        // MARK: tableView data source
        
        func numberOfSections(in: UITableView) -> Int {
            return fetchedResultsController.sections?.count ?? 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        }
        
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
                let aNotebook = fetchedResultsController.object(at: indexPath)
                let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCell.defaultResueIdentifier, for: indexPath) as! NotebookCell
                
                // configure cell
                cell.nameLabel.text = aNotebook.name
                
                if let count = aNotebook.notes?.count {
                    let pageString = count == 1 ? "page" : "pages"
                    cell.pageCountLabel.text = "\(count) \(pageString)"
                }
                return cell
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            
            switch editingStyle {
            case .delete: deleteNotebook(at: indexPath)
            default: () // Unsupported
            }
        }
        //MARK: Navigation
        
        override func prepare(for segue: UIStroryboardSegue, sender: Any?) {
            
            // If this is a NotesListViewController, we'll configure its 'Notebook'
            
            if let vc = segue.destination as? NotesListViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.notebook = fetchedResultsController.object(at: indexPath)
                    vc.dataController = dataController
                }
            }
        }
    }
    
    extension NotebooksListViewController:NSFetchedResultsControllerDelegate {
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
                break
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
                break
            case .update:
                tableCiew.reloadRows(at: [indexPath!], with: .fade)
            case .move:
                tableView.moveRow(at: indexPath1, to: newIndexPath!)
            }
        }
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didCHange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultChangeType) {
            let indexSet = IndexSet(integer: sectionIndex)
            switch type {
            case .insert: tableView.insertSections(indexSet, with: .fade)
            case .delete: tableView.deleteSections(indexSet, with: .fade)
            case .update, .move:
                fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be psssible.")
            }
        }
        
        func controllerWillChnageContent(_ controller:
            NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.beginUpdates()
        }
        
        func controllerDidChangeContent(_ cintroller:
            NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
        }
}


