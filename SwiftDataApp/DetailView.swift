//
//  DetailView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
//    @State  private var item: Item
    var  item: Item?
    @State private var isEditing = false
    @State  private var isDeleting = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(NavigationContext.self) private var navigationContext
    var body: some View {
        
        //        NavigationStack {
        //
        //            List {
        //                TextField("Add item", text: $item.item)
        //                    .font(.title)
        //                    .textFieldStyle(.roundedBorder)
        //                    .padding(.vertical)
        //                    .listRowSeparator(.hidden)
        //
        //                Toggle(isOn: $item.reminderOn, label: {
        //                    Text("Set reminder")
        //                })
        //                .padding(.top)
        //                .listRowSeparator(.hidden)
        //
        //                DatePicker("Date", selection: $item.dueDate)
        //                    .listRowSeparator(.hidden)
        //                    .padding(.bottom)
        //                    .disabled(!item.reminderOn)
        //
        //                Text("notes")
        //                    .padding(.top)
        //                TextField("Notes", text: $item.notes, axis: .vertical)
        //                    .textFieldStyle(.roundedBorder)
        //                    .listRowSeparator(.hidden)
        //
        //                Toggle("Completed", isOn: $item.isCompleted)
        //                    .padding(.top)
        //                    .listRowSeparator(.hidden)
        //            }
        //            .listStyle(.plain)
        //            .toolbar {
        //
        //                ToolbarItem(placement: .topBarLeading) {
        //                    Button("Cancel") {
        //                        dismiss()
        //                    }
        //
        //                }
        //
        //                ToolbarItem(placement: .topBarTrailing) {
        //                    Button("Save") {
        //                        modelContext.insert(item)
        //                        dismiss()
        //                    }
        //                }
        //            }
        //            .navigationBarTitleDisplayMode(.inline)
        //            .navigationBarBackButtonHidden()
        //        }
        if let item {
           ItemContentDetailView(item: item)
                .navigationTitle("\(item.title)")
                .toolbar(content: {
                    Button(action: {isEditing = true}, label: {
                        Label("Edit \(item.title)", systemImage: "pencil").help("Edit item")
                    })
                    Button(action: {isDeleting = true}, label: {
                        Label("Delete \(item.title)", systemImage: "trash").help("Delete item")
                    })
                })
                .sheet(isPresented: $isEditing, content: {
                    ItemEditor(item: item)
                })
                .alert("Delete \(item.title)?", isPresented: $isDeleting) {
                    Button("Delete \(item.title)", role: .destructive) {
                        delete(item)
                    }
                }
            
        } else {
            ContentUnavailableView("Select item", image: "pawprint")
        }
        
    }
    private func delete(_ item: Item) {
        navigationContext.selectedItem = nil
        modelContext.delete(item)
        
    }
}

//// first kind preview
//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//
//        DetailView(item: Item(item: "", reminderOn: false, dueDate: Date(), notes: "", isCompleted: false))
//            .environment(NavigationContext())
//    }
//
//}
//// second  kind preview
//#Preview {
//    ModelContainerPreview {
//        DetailView(item: Item.item1)
//            .environment(NavigationContext())
//    } modelContainer: {
//        try  ModelContainer.sample()
//    }
//
//}
//
//
////third kind preview
//


private struct ItemContentDetailView: View {
    let item: Item
    var body: some View {
        VStack  {
            #if os(macOS)
            Text(item.title)
            #else
            EmptyView()
            #endif
            
            List {
                HStack {
               Text("Categories")
                Spacer()
                Text("\(item.category?.title ?? "")")
            }
                HStack{
                   Text("Criteria")
                    Spacer()
                    Text("\(item.criteria.rawValue)")
                }
               
            }
        }
    }
}
#Preview {

    ModelContainerPreview {
        try ModelContainer.sample()
    } content: {
        DetailView( item: .item1)
            .environment(NavigationContext())

    }
}

