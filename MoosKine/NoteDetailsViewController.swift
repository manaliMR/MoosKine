/iosApps/MoosKine/MoosKine.xcodeproj//
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
        
        // keyboard toolbar configuration
        confifureToolbarItems()
        configureTextViewInoutAccessoryView()
        
        addSaveNotificationObserver()
    }
    
    deinit {
        removeSaveNotificationObserver()
    }
    
    
}

/// MARK: Editing

extension NoteDetailsViewContoller {
    func persentDeletNotebookAlert() {
        let alert = UIAlertController(title: "Delete Note", message: "Do you want to deleete this note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: deleteHandler))
        present(alert, animated: true, completion: nil)
    }
    
    func deleteHandler(alertAction: UIAlertAction) {
        onDelete?()
    }
}

/// MARK: UITextViewDelegate


extension NoteDetailsViewContoller: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note.attributedText = textView.attributedText
        try? dataController.viewContext.save()
    }
    }
    
/// MARK: Toolbar
func makeToolbarItem() -> [UIBarButtonItem] {
    let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector (deleteTapped(sender:)))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil(spaceTappeed(sender:)))
    let bold = UIBarButtonItem(image: <#T##UIImage?#>, style: .plain, target: self, action: #selector(boldTapped(sender:)))
    let red = UIBarButtonItem(title: <#T##String?#>, style: .plain, target: self, action: #selectoe(redTapped(sender:)))

    return [trash, space, bold, red]
    
    /// configure the current toolbar
    func configureToolbarItems() {
        toolbarItems()= makeToolbarItems()
        navigationController?.setToolbarHidden(false, animal: false)
    }
    
    /// configure text View's input
    
    func textViewInputAccessoryView() {

        let toolbar = UIToolbar(frame: <#T##CGRect#>(x: 0, y: 0))
    }
 }
