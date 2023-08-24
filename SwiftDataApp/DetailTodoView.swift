//
//  DetailTodoView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 24/08/2023.
//

import SwiftUI

struct DetailTodoView: View {
    @Bindable var  todo: Todo
    
    var body: some View {
        VStack {
            TextField("new todo", text: $todo.name)
                .textFieldStyle(.roundedBorder)
            
            Toggle(todo.isDone ? "Done" : "Open", isOn: $todo.isDone)
            
            HStack {
                Text("Tags")
                ForEach(todo.tags?.sorted(by: {$0.name > $1.name}) ?? []) {
                    tag in
                    Text(tag.name)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.red, lineWidth: 2)
                        }
                        .onTapGesture {
                            if let index = todo.tags? .firstIndex(where: { $0 == tag }) {
                                todo.tags?.remove(at: index)
                            }
                        }
                }
            }
            
            Button(action: {
                let tag = Tag(name: "dummy tag" )
                todo.tags?.append(tag)
            }, label: {
                Text("Add tag")
            })
        }
        .padding()
    }
}


/*
 #Preview {
 DetailTodoView()
 }
 */
