//
//  NotesListViewController.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-15.
//  Copyright © 2018 Manali Rami. All rights reserved.
//


import UIKit
import CoreData

class NotesListVewController: UIViewController, UITableViewDataSource {
    
    ///  A tableView thet displays a list of notes for a notebook
    
    @IBOutlet weak var tableView: UITableView!
    
    /// The notebook whose notes are being siaplayed
    
    var notebook: Notebook!
    var dataController:DataController!
    
    var fetchedResultsController:NSFetchedResultsController<Note>!
    
    /// A date formatter for data text in note cells
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Note> = Note.fetchRequest()
        let predicate = NSPredicate(format: "notebook == %@", notebook)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(notebook)-notes")
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = notebook.name
        navigationItem.rightBarButtonItem = editButtonItem
        
        setupFetchedResultsController()
        
        updateEditButtonState()
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
    
    @IBAction func addTapped(sender: Any) {
        addNote()
    }
    
    // MARK: Editing
    
    func addNote() {
        let note = Note(context: dataController.viewContext)
        note.creationDate = Date()
        note.notebook = notebook
        try? dataController.viewContext.save()
    }
    
    // Deletes the 'Note' at the specified index path
    
    func deleteNote(at indexPath: IndexPath) {
        let noteToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(noteToDelete)
        try? dataController.viewContext.save()
    }
    
    func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = fetchedResultsController.sections![0].numberOfObjects . 0
    }
    
    override func setEditing(_ editing:Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}


