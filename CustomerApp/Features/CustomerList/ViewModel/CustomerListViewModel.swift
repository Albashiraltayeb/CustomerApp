//
//  CustomerListViewModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation
import Combine

@MainActor
class CustomerListViewModel: ObservableObject {
    @Published var customers: [Customer] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    let apiManager: APIManager
    let cacheService: CustomerCacheService

    init(apiManager: APIManager, cacheService: CustomerCacheService) {
        self.apiManager = apiManager
        self.cacheService = cacheService
    }

    func fetchCustomers() async {
        isLoading = true
        errorMessage = nil

        do {
            let remoteCustomers: [Customer] = try await apiManager.request(endpoint: "/users")
            customers = remoteCustomers
            try cacheService.saveCustomers(remoteCustomers)
        } catch {
            print("Failed to fetch remote: \(error.localizedDescription)")
            errorMessage = "Couldn't fetch online. Showing cached data."

            do {
                customers = try cacheService.fetchCustomers()
            } catch {
                customers = []
                errorMessage = "No data available offline."
            }
        }

        isLoading = false
    }

    func reload() {
        Task {
            await fetchCustomers()
        }
    }
}
