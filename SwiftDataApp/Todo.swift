//
//  Item.swift
//  SwiftDataApp
//
//  Created by ipeerless on 24/08/2023.
//

import Foundation
import SwiftData

@Model
final class Todo {
    
    @Attribute(.unique)
    var CreationDate: Date
    var name: String
    var isDone: Bool
    var priority: Int
    
    @Attribute(.externalStorage)
    var image: Data?
    var tags: [Tag]?
    
    init( name: String, isDone: Bool = false, priority: Int = 0) {
        self.CreationDate = Date()
        self.name = name
        self.isDone = isDone
        self.priority = priority
        
    }
}

@Model
final class Tag {
    
    var name: String
    var todos: [Todo]?
    init(name: String) {
        self.name = name
    }
}
