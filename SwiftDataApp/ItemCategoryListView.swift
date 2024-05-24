//
//  ItemCategoryListView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 23/05/2024.
//

import SwiftUI
import SwiftData

struct ItemCategoryListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ItemCategory.title)  private var itemCategories: [ItemCategory]
    @State private  var isReloadPresented = false
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedItemCategoryTitle) {
#if os(macOS)
            Section(navigationContext.sideBarTitle) {
                ListCategories(itemCategories: itemCategories)
            }
#else
            ListCategories(itemCategories: itemCategories)
#endif
        }
        .alert("Reload", isPresented: $isReloadPresented, actions: {
            Button("Reload", role: .destructive) {
                reloadData()
            }
        }, message: {
            Text("Reload Dataa")
        })
        
        .toolbar {
            Button(action: {
                isReloadPresented = true
            }, label: {
                Label("", systemImage: "arrow.clockwise")
                    .help("Reload Data")
            })
        }
        .task {
            if itemCategories.isEmpty {
                ItemCategory.inserSampleData(modelContext: modelContext)
                
            }
        }
        
    }
    @MainActor
    private func reloadData() {
        navigationContext.selectedItem =  nil
        navigationContext.selectedItemCategoryTitle = nil
        ItemCategory.reloadData(modelContext: modelContext)
    }
}

private struct ListCategories: View {
    var itemCategories: [ItemCategory]
    var body: some View {
        ForEach(itemCategories) { itemCategory in
            NavigationLink(itemCategory.title, value:  itemCategory.title)
            
        }
    }
}

#Preview("ItemCategoryListView") {
    NavigationStack {
        
        ItemCategoryListView()
    }
    .environment(NavigationContext())
}

#Preview("ListCategories", body: {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            List {
                
                ListCategories(itemCategories: [.itemCategory1, .itemCategory2])
            }
        }
        .environment(NavigationContext())
    }
})
