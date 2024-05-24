//
//  SampleData.swift
//  SwiftDataApp
//
//  Created by ipeerless on 20/05/2024.
//

import Foundation
import SwiftData

extension  ItemCategory {
    static let itemCategory1 = ItemCategory(title: "ItemCategory1")
    static let itemCategory2 = ItemCategory(title: "ItemCategory2")
    static let itemCategory3 = ItemCategory(title: "ItemCategory3")
    static let itemCategory4 = ItemCategory(title: "ItemCategory4")
    
    static func inserSampleData(modelContext: ModelContext) {
//        insert categories
        modelContext.insert(itemCategory1)
        modelContext.insert(itemCategory2)
        modelContext.insert(itemCategory3)
        modelContext.insert(itemCategory4)
        
//        insert items
        modelContext.insert( Item.item1)
        modelContext.insert( Item.item2)
        modelContext.insert( Item.item3)
        modelContext.insert( Item.item2)
        
// set category for every item
        
        Item.item1.category = itemCategory1
        Item.item2.category = itemCategory2
        Item.item3.category = itemCategory3
        Item.item4.category = itemCategory4
    }
    
    static func reloadData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Item.self)
            inserSampleData(modelContext: modelContext)
            
        } catch {
            fatalError(error.localizedDescription)
            
        }
    }
    
}


extension Item {
    
    static let item1 = Item(title: "Sample item", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false, criteria: .criteria1)

    static let item2 = Item(title: "Sample item", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false,  criteria: .criteria2)
    
    static  let item3 = Item(title: "Call mom", reminderOn: true, dueDate: Date(), criteria: .criteria3)
    
    static  let item4 = Item(title: "Sample item", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false, criteria: .criteria3)
    
}

