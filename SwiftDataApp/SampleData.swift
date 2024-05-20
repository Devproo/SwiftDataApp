//
//  SampleData.swift
//  SwiftDataApp
//
//  Created by ipeerless on 20/05/2024.
//

import Foundation
import SwiftData

extension  Item {
    static let item1 = Item(item: "Sample item", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false)
    
    static let item2 = Item(item: "Sample item", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false)
    
    static  let item3 = Item(item: "Call mom", reminderOn: true, dueDate: Date())
    
    static  let item4 = Item(item: "Sample item", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false)
    
    static func inserSampleData(modelContext: ModelContext) {
        
        modelContext.insert(item1)
        modelContext.insert( item2)
        modelContext.insert( item3)
        modelContext.insert( item4)
       
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
