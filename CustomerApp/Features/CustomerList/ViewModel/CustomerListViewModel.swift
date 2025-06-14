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
    @Published var toast: Toast? = nil

    let repository: CustomerRepository

    init(repository: CustomerRepository) {
        self.repository = repository
    }


    func fetchCustomers() async {
        isLoading = true
        errorMessage = nil
        isOffline = !Reachability.shared.isConnected
        customers.removeAll()
        if isOffline {
            toast = Toast(style: .error, message: "Offline Mode")
        }
        do {
            customers = try await repository.fetchCustomers()
        } catch {
            customers = []
            errorMessage = "Unable to load customers."
            toast = Toast(style: .error, message: errorMessage ?? "")
        }

        isLoading = false
    }
    
    @MainActor
    func deleteCustomer(_ customer: Customer) async {
        do {
            try await APIManager.shared.delete(endpoint: "/users/\(customer.id)")

            // Refetch after deletion
            await fetchCustomers()

            // Show success toast
            toast = Toast(style: .success, message: "Customer deleted successfully.")
        } catch let error as NetworkError {
            let message = error.userFriendlyMessage
            errorMessage = message
            toast = Toast(style: .error, message: message)
        } catch {
            let message = "Unexpected error: \(error.localizedDescription)"
            errorMessage = message
            toast = Toast(style: .error, message: message)
        }
    }

    func reload() {
        Task {
            await fetchCustomers()
        }
    }
}
