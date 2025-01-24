//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Anurag on 22/01/25.
//

import SwiftUI
import SwiftData
@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Book.self)
    }
}
