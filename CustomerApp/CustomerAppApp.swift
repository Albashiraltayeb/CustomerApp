//
//  CustomerAppApp.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

@main
struct CustomerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
