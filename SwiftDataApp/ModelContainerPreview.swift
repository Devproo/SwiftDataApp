//
//  ModelContainerPreview.swift
//  SwiftDataApp
//
//  Created by ipeerless on 20/05/2024.
//

import SwiftUI
import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Item.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        
        Task { @MainActor in

            Item.inserSampleData(modelContext: container.mainContext)
        }
        return container
    }
}

struct ModelContainerPreview<Content: View>: View {
    var content: () -> Content
    let container: ModelContainer
    
    init ( @ViewBuilder content: @escaping () -> Content, modelContainer: @escaping () throws ->  ModelContainer) {
        self.content = content
        do {
            self.container = try MainActor.assumeIsolated(modelContainer)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    init(_ modelcontainer: @escaping () throws -> ModelContainer, @ViewBuilder content: @escaping() -> Content) {
        self.init(content: content, modelContainer: modelcontainer)

    }
    
    
    var body: some View {
        content()
            .modelContainer(container)
    }
}

