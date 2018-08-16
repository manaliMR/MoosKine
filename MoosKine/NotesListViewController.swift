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
    }
}
