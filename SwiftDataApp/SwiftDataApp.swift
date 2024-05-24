//
//  SwiftDataApp.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataApp: App {
    var body: some Scene {
        WindowGroup() {
            ContentView()
        }
        .modelContainer(for: ItemCategory.self)
#if os(macOS)
        .commands {
            SidebarCommands()
        }
#endif
    }
}
