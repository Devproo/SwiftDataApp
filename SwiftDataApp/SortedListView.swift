//
//  SortedList.swift
//  SwiftDataApp
//
//  Created by ipeerless on 19/05/2024.
//

import SwiftUI
import SwiftData

struct SortedListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    //    var sortSelection: SortOption
    //    init(sortSelection: SortOption) {
    //        self.sortSelection = sortSelection
    //
    //        switch sortSelection {
    //        case .asEntered: _items = Query()
    //        case .alphabetical: _items = Query(sort: \.item, animation: .default)
    //        case .chronological: _items = Query(sort: \.dueDate)
    //        case .isCompleted: _items = Query(filter: #Predicate { $0.isCompleted == false })
    //        }
    //    }
    //     this is more clear
    var sortSelection: SortOption
    init(sortSelection: SortOption) {
        
        self.sortSelection  = sortSelection
        _items = {
            switch sortSelection {
            case .asEntered:
                return Query()
            case .alphabetical:
                return Query(sort:\.item, animation:  .default)
            case .chronological:
                return Query(sort: \.dueDate)
            case .isCompleted:
                return Query(filter: #Predicate { $0.isCompleted})
            }
        }()
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: item.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                item.isCompleted.toggle()
                            }
                        
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            Text(item.item)
                        }
                    }
                    .font(.title2)
                    HStack {
                        Text(item.dueDate.formatted(date: .abbreviated, time: .shortened))
                        if (item.reminderOn) {
                            Image(systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                    
                }
                .swipeActions {
                    Button("Delete", role: .destructive) {
                        modelContext.delete(item)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        SortedListView(sortSelection: .asEntered)
            .environment(NavigationContext())
    }
    
}


