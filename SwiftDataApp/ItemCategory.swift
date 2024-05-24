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
    @Attribute(.unique)  var title: String
    @Relationship(deleteRule: .cascade, inverse: \Item.category) var  items = [Item]()
    
    init(title: String) {
        self.title = title
       
    }
}

