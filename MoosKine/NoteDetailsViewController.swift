//
//  NoteDetailsViewController.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-15.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailsViewContoller: UIViewController {
    /// A text view that displays a note's text
    
    
    /// The note being displayed and edited
    var note: Note!
    
    var dataController:DataController!
    
    var saveObserverToken: Any?
    
    /// A closure that is run when the user asks to delete the current note
    
    var onDelete: (() -> Void)?
    
    /// A date fomatter for the view controller's title text
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    /// The accessory view used when displaying the keyboard
    var keyboardToolbar: UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let creationDate = note.creationDate {
            navigationItem.title = dateFormatter.string(from: creationDate)
        }
        textView.attributedText = note.attributedText
        
    }
}
