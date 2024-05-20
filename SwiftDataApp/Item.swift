//
//  Item.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    @Attribute(.unique)  var item = ""
    var reminderOn = false
    var dueDate = Date.now + (60*60*24)
    var notes = ""
    var isCompleted = false
    
    init(item: String = "", reminderOn: Bool = false, dueDate: Date = Date.now + (60*60*24), notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderOn = reminderOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}


