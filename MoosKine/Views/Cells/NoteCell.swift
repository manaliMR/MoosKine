//
//  NoteCell.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-18.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

internal final class NoteCell: UITableViewCell, Cell {
    
    // Outlets
    
    @IBOutlet weak var textPreviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textPreviewLabel.text = nil
        dateLabel.text = nil 
    }
}
