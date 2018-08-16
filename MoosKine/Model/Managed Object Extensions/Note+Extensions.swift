//
//  Note+Extensions.swift
//  MoosKine
//
//  Created by Manali Rami on 2018-08-15.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import Foundation
import CoreData
extension Note {
    public ovveride func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}