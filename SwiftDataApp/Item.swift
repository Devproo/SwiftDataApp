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
    @Attribute(.unique)  var title = ""
    var reminderOn = false
    var dueDate = Date.now + (60*60*24)
    var notes = ""
    var isCompleted = false
    var category: ItemCategory?
    var criteria: Criteria
    
    init(title: String = "", reminderOn: Bool = false, dueDate: Date = Date.now + (60*60*24), notes: String = "", isCompleted: Bool = false, category: ItemCategory? = nil, criteria: Criteria) {
        self.title = title
        self.reminderOn = reminderOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
        self.category = category
        self.criteria = criteria
    }

    }


extension  Item {
    enum Criteria: String, CaseIterable, Codable {
        case criteria1 = " Criteria1"
        case criteria2 =  "Criteria2"
       case criteria3 = " Criteria3"
    }
}
