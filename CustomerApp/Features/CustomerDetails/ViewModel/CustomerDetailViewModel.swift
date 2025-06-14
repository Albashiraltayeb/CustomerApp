//
//  CustomerDetailViewModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

@MainActor
final class CustomerDetailViewModel: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var gender: String
    @Published var status: String
    @Published var isEditing = false
    @Published var isSaving = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var toast: Toast? = nil

    let customer: Customer
    
    init(customer: Customer) {
        self.customer = customer
        self.name = customer.name
        self.email = customer.email
        self.gender = customer.gender
        self.status = customer.status
    }
    
    func updateCustomer() async {
        guard !name.isEmpty, !email.isEmpty else {
            errorMessage = "Name and email are required."
            toast = Toast(style: .error, message: errorMessage ?? "")
            return
        }

        isSaving = true
        errorMessage = nil
        successMessage = nil

        let updatedCustomer = CustomerCreateRequest(name: name, email: email, gender: gender, status: status)

        do {
            let _: Customer = try await APIManager.shared.put(endpoint: "/users/\(customer.id)", body: updatedCustomer)
            successMessage = "Customer updated successfully!"
            toast = Toast(style: .success, message: successMessage ?? "")

            isEditing = false
        } catch let error as NetworkError {
            if case .validationFailed(let data) = error,
               let message = try? decodeValidationError(from: data) {
                errorMessage = message
                toast = Toast(style: .error, message: errorMessage ?? "")

            } else {
                errorMessage = error.userFriendlyMessage
                toast = Toast(style: .error, message: errorMessage ?? "")

            }
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
            toast = Toast(style: .error, message: errorMessage ?? "")

        }

        isSaving = false
    }
}

