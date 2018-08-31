//
//  Cell.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-18.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

protocol Cell: class {
    
    // a default resue identifier for the cell class
    
    static var defaultReuseIdentifier: String { get }
    
}

extension Cell {
    
    static var defaultResuseIdentifier: String {
        
        return "\(self)"
    }
}
