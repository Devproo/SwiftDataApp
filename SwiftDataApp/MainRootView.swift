//
//  MainRootView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 23/05/2024.
//

import SwiftUI
import SwiftData

struct MainRootView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationContext.self) private var navigationContext
    var body: some View {
       @Bindable var navigationContext = navigationContext
        
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            ItemCategoryListView()
                .navigationTitle(navigationContext.sideBarTitle)
        } content: {
            ItemListView(itemCategoryTitle: navigationContext.selectedItemCategoryTitle)
                .navigationTitle(navigationContext.ContentListTitle)
        } detail: {
            DetailView(item: navigationContext.selectedItem)
                
        }

    
   

    }
}

#Preview {
    MainRootView()
}

