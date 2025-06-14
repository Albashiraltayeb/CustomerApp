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

    private let repository: CustomerRepository
    private let apiManager: APIManaging

    init(repository: CustomerRepository, apiManager: APIManaging = APIManager.shared) {
        self.repository = repository
        self.apiManager = apiManager
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
            try await apiManager.delete(endpoint: "/users/\(customer.id)")

            await fetchCustomers()
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
