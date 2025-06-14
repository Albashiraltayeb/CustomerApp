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
    @Published var isOffline: Bool = false

    let repository: CustomerRepository

    init(repository: CustomerRepository) {
        self.repository = repository
    }


    func fetchCustomers() async {
        isLoading = true
        errorMessage = nil
        isOffline = !Reachability.shared.isConnected
        customers.removeAll()
        do {
            customers = try await repository.fetchCustomers()
        } catch {
            customers = []
            errorMessage = "Unable to load customers."
        }

        isLoading = false
    }
    
    func reload() {
        Task {
            await fetchCustomers()
        }
    }
}
