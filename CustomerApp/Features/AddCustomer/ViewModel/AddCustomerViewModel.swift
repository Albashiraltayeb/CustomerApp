//
//  AddCustomerViewModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AddCustomerViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var gender = "male"
    @Published var status = "active"
    @Published var errorMessage: String?
    @Published var isSubmitting = false
    @Published var isEmailValid: Bool = true
    @Published var toast: Toast? = nil



    private let apiManager: APIManager
    private let onSuccess: () -> Void
    private var cancellables = Set<AnyCancellable>()


    init(apiManager: APIManager, onSuccess: @escaping () -> Void) {
        self.apiManager = apiManager
        self.onSuccess = onSuccess
        
        $email
            .map { Self.isValidEmail($0) }
            .assign(to: &$isEmailValid)
    }
    
    
    
    static func isValidEmail(_ email: String) -> Bool {
        let regex = #"^\S+@\S+\.\S+$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }
    
    func submit() async {
        guard !name.isEmpty, !email.isEmpty else {
            errorMessage = "Name and email are required."
            toast = Toast(style: .error, message: errorMessage ?? "")
            return
        }
        
        guard isEmailValid else {
            errorMessage = "Please enter a valid email address."
            toast = Toast(style: .error, message: errorMessage ?? "")
            return
        }

        isSubmitting = true
        errorMessage = nil

        let newCustomer = CustomerCreateRequest(
            name: name,
            email: email,
            gender: gender,
            status: status
        )

        do {
            let _: Customer = try await apiManager.post(
                endpoint: "/users",
                body: newCustomer
            )
            onSuccess()
        } catch let error as NetworkError {
            if case .validationFailed(let data) = error,
               let message = try? decodeValidationError(from: data) {
                toast = Toast(style: .error, message: message)
            } else {
                errorMessage = error.userFriendlyMessage
                toast = Toast(style: .error, message: errorMessage ?? "")
            }
        } catch {
            errorMessage = error.localizedDescription
            toast = Toast(style: .error, message: errorMessage ?? "")
        }



        isSubmitting = false
    }
}



