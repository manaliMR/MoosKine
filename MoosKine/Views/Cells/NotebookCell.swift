//
//  NotebookCell.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-18.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

internal final class NotebookCell: UITableViewCell, Cell {
    
    // Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        pageCountLabel.text = nil
    }
}
