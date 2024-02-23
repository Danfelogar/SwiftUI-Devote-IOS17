//
//  SwiftUI_Devote_IOS17App.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI

@main
struct SwiftUI_Devote_IOS17App: App {
    let persistenceController = PersistenceController.shared

    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
