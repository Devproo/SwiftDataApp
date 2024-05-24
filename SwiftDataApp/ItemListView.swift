//
//  SortedList.swift
//  SwiftDataApp
//
//  Created by ipeerless on 19/05/2024.
//

import SwiftUI
import SwiftData

enum SortOption: String,CaseIterable {
    case asEntered = "As Entered"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case isCompleted = "NotDone"
    
}

struct ItemListView: View {
    let itemCategoryTitle: String?
    
//      @Environment(NavigationContext.self) private var navigationContext
//        @Environment(\.modelContext) private var modelContext
//        @Query private var items: [Item]
//    
//        var sortSelection: SortOption
//        init(sortSelection: SortOption) {
//            self.sortSelection = sortSelection
//    
//            switch sortSelection {
//            case .asEntered: _items = Query()
//            case .alphabetical: _items = Query(sort: \.item, animation: .default)
//            case .chronological: _items = Query(sort: \.dueDate)
//            case .isCompleted: _items = Query(filter: #Predicate { $0.isCompleted == false })
//            }
//        }
//         this is more clear
//    
//        var sortSelection: SortOption
//        init(sortSelection: SortOption) {
//    
//            self.sortSelection  = sortSelection
//            _items = {
//                switch sortSelection {
//                case .asEntered:
//                    return Query()
//                case .alphabetical:
//                    return Query(sort:\.item, animation:  .default)
//                case .chronological:
//                    return Query(sort: \.dueDate)
//                case .isCompleted:
//                    return Query(filter: #Predicate { $0.isCompleted})
//                }
//            }()
//        }
    
    var body: some View {
        //        NavigationStack {
        //            List {
        //                ForEach(items) { item in
        //                    VStack(alignment: .leading) {
        //                        HStack {
        //                            Image(systemName: item.isCompleted ? "checkmark.rectangle" : "rectangle")
        //                                .onTapGesture {
        //                                    item.isCompleted.toggle()
        //                                }
        //
        //                            NavigationLink {
        //                                DetailView(item: item)
        //                            } label: {
        //                                Text(item.item)
        //                            }
        //                        }
        //                        .font(.title2)
        //                        HStack {
        //                            Text(item.dueDate.formatted(date: .abbreviated, time: .shortened))
        //                            if (item.reminderOn) {
        //                                Image(systemName: "calendar.badge.clock")
        //                                    .symbolRenderingMode(.multicolor)
        //                            }
        //                        }
        //
        //                    }
        //                    .swipeActions {
        //                        Button("Delete", role: .destructive) {
        //                            modelContext.delete(item)
        //                        }
        //                    }
        //                }
        //            }
        //            .listStyle(.plain)
        //        }
       
        if let itemCategoryTitle {
            ItemList(itemCategoryTitle: itemCategoryTitle)
        } else {
            ContentUnavailableView("Select Category", systemImage: "sidebar.left")
        }
        
    }
}

struct ItemList: View {
    let itemCategoryTitle: String
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isEditorPresented = false
    
    init(itemCategoryTitle: String) {
        self.itemCategoryTitle = itemCategoryTitle
        let predicate = #Predicate<Item> { item in
            item.category?.title == itemCategoryTitle
            }
        _items = Query(filter:  predicate, sort: \Item.title)
    }
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedItem ) {
            ForEach(items) { item in
                NavigationLink(item.title, value: item)
                
            }
            .onDelete(perform: removeItems)
        }
        .sheet(isPresented: $isEditorPresented, content: {
            ItemEditor(item: nil)
        })
        .overlay {
            if items.isEmpty {
                ContentUnavailableView {
                    Label(" No items", systemImage: "pawprint")
                } description: {
                    AddItemButton(isActive: $isEditorPresented)
                }
            }
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                AddItemButton(isActive: $isEditorPresented)
            }
        })
    }
    private func removeItems(at indexSet: IndexSet) {
        for index in indexSet  {
            let itemsToRemove = items[index]
            if navigationContext.selectedItem?.persistentModelID == itemsToRemove.persistentModelID {
                navigationContext.selectedItem = nil
            }
            modelContext.delete(itemsToRemove)
        }
        
    }
    
}

private struct AddItemButton: View {
    @Binding var isActive: Bool
    var body: some View {
        Button{
            isActive = true
        } label: {
            Label("Add item", systemImage: "plus")
                .help("Add item")
        }
        
    }
}



#Preview("No selected Categories") {
    ModelContainerPreview(ModelContainer.sample)  {
        ItemListView(itemCategoryTitle: nil)
        
    }
}

#Preview("No Items") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemList(itemCategoryTitle: ItemCategory.itemCategory1.title)
            .environment(NavigationContext())
    }
}

#Preview {
    AddItemButton(isActive: .constant(false))
}
