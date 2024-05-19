//
//  ContentView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var sheetIsPresented = false
    @State var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            SortedListView(sortSelection: sortSelection)
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
                    DetailView(item: Item())
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self)
}
