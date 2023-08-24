//
//  SwiftDataAppApp.swift
//  SwiftDataApp
//
//  Created by ipeerless on 24/08/2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataAppApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self)
    }
}
