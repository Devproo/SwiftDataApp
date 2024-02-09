//
//  ContentView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import SwiftUI
import SwiftData

enum SortOption: String,CaseIterable{
    
    
    case asEntered = "As Entered"
    case alphabetical = "A - Z"
    case chronological = "Date"
    case isCompleted = "Not Done"
}
struct SortedList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch sortSelection {
        case .asEntered: _items = Query()
        case .alphabetical: _items = Query(sort: \.item, animation: .default)
        case .chronological: _items = Query(sort: \.dueDate)
        case .isCompleted: _items = Query(filter: #Predicate { $0.isCompleted == false })
        }
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
                            DetailView(item: Item())
                        } label: {
                            Text(item.item)
                        }
                    }
                    .font(.title2)
                    HStack {
                        Text(item.dueDate.formatted(date: .abbreviated, time: .shortened))
                        if (item.reminderIOn) {
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

struct ContentView: View {
    @State private var sheetIsPresented = false
    @State var sortSelection: SortOption = .asEntered
    var body: some View {
        NavigationStack {
            SortedList(sortSelection: sortSelection)
                .navigationTitle("To Do List")
                .navigationBarTitleDisplayMode(.automatic)
            
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            sheetIsPresented.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Picker("", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .sheet(isPresented: $sheetIsPresented) {
                    NavigationStack {
                        DetailView(item: Item())
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self)
}
