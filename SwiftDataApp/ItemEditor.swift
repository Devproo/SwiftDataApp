//
//  ItemEditor.swift
//  SwiftDataApp
//
//  Created by ipeerless on 23/05/2024.
//

import SwiftUI
import SwiftData
struct ItemEditor: View {
    let  item: Item?
   @State private var title = ""
    
    private var editorTitle: String {
        item == nil ? "Add Item" : "Edit Item"
    }
    @State private var selectedCtegory: ItemCategory?
    @State private var  selectedCriteria = Item.Criteria.criteria1
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ItemCategory.title) private  var categories: [ItemCategory]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                Picker("Category", selection: $selectedCtegory) {
                    Text("Select Category").tag(nil as ItemCategory?)
                    ForEach(categories) { category in
                        Text(category.title).tag(category as ItemCategory?)
                        
                    }
                }
                Picker("Criteria", selection: $selectedCriteria) {
                    ForEach(Item.Criteria.allCases, id: \.self) { criteria in
                        Text(criteria.rawValue).tag(criteria)
                        
                    }
                }
                .toolbar(content: {
                    
                    ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            save()
                            dismiss()
                        }
                        .disabled($selectedCtegory.wrappedValue == nil)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                })
                .onAppear(perform: {
                    if  let item {
                        title = item.title
                        selectedCriteria  = item.criteria
                        selectedCtegory = item.category
                    }
                })
                #if os(macOS)
                .padding()
                #endif
                
            }
        }
    }
    
    private func save() {
        if let item  {
            item.title = title
            item.category = selectedCtegory
            item.criteria = selectedCriteria
        } else {
         let newItem = Item(title: title ,criteria: selectedCriteria)
            newItem.category = selectedCtegory
            modelContext.insert(newItem)
        }
    }
}

#Preview("Add Item") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemEditor(item: nil)
    }
    
}

#Preview("Edit Item") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemEditor(item: .item1)
    }
}
