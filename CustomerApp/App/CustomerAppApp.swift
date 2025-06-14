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
    
    init() {
        // Check for UI testing launch arguments
        if CommandLine.arguments.contains("--uitesting-clear-coredata") {
            
           try? CustomerCacheService().clearData() // Implement this function to delete all CDCustomer entities
        }
        if CommandLine.arguments.contains("--uitesting-empty-customers") {
            // You'd need to mock your APIManager or Repository to return empty data
            // This is more complex and often handled by mocking at the network layer directly
            // or using a dedicated test configuration for your repository.
            print("UI Testing: Simulating empty customers.")
        }
        if CommandLine.arguments.contains("--uitesting-simulate-api-error") {
            // Implement a mock for APIManager.shared or CustomerRepository.shared
            // that returns an error when fetchCustomers() is called.
            print("UI Testing: Simulating API error.")
        }
        if CommandLine.arguments.contains("--uitesting-simulate-offline") {
            // Implement a way to force CustomerRepository.shared.isOnline to false
            // (e.g., set a flag in Repository that overrides NWPathMonitor during UI tests)
            print("UI Testing: Simulating offline mode.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            CustomerListView(
                viewModel: CustomerListViewModel(
                    repository:DefaultCustomerRepository(apiManager: APIManager.shared,
                                                          cacheService: CustomerCacheService(),
                                                         reachability: Reachability.shared),
                )
            )
        }
    }
}

