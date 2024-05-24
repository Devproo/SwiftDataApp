//
//  NavigationContext.swift
//  SwiftDataApp
//
//  Created by ipeerless on 20/05/2024.
//


import SwiftUI

@Observable
class NavigationContext {
    var selectedItem: Item?
    var selectedItemCategoryTitle: String?
    var columnVisibility: NavigationSplitViewVisibility
    var sideBarTitle = "Categories"
    var ContentListTitle: String {
        if let selectedItemCategoryTitle {
            selectedItemCategoryTitle
        } else {
            ""
        }
    }
    init(selectedItem: Item? = nil, selectedItemCategoryTitle: String? = nil, columnVisibility: NavigationSplitViewVisibility = .automatic) {
        self.selectedItem = selectedItem
        self.selectedItemCategoryTitle = selectedItemCategoryTitle
        self.columnVisibility = columnVisibility
      
    }
    
}
