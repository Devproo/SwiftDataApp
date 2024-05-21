//
//  ItemCategory.swift
//  SwiftDataApp
//
//  Created by ipeerless on 20/05/2024.
//

import Foundation
import SwiftData

@Model
final class ItemCategory {
    @Attribute(.unique)  var name: String
    @Relationship(deleteRule: .cascade, inverse: \Item.category) var  items = [Item]()
    
    init(name: String) {
        self.name = name
      
    }
}

