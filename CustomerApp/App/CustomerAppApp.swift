//
//  CustomerAppApp.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

@main
struct CustomerApp: App {
    let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CustomerListView(
                viewModel: CustomerListViewModel(
                    apiManager: APIManager(),
                    cacheService: CustomerCacheService()
                )
            )
        }
    }
}

