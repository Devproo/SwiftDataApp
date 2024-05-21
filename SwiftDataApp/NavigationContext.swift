//
//  NavigationContext.swift
//  SwiftDataApp
//
//  Created by ipeerless on 20/05/2024.
//

import Foundation
import Observation
import SwiftUI

@Observable
class NavigationContext {
    var selectedItem: Item?
    var selectedCategoryName: String?
    var sortedListTitle: String {
        if let selectedCategoryName {
            selectedCategoryName
        } else {
            ""
        }
    }
    init(selectedItem: Item? = nil, selectedCategoryName: String? = nil) {
      
        self.selectedCategoryName = selectedCategoryName
        
        
    }
    
}
