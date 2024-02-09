//
//  SwiftDataAppApp.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
       
    }
}
