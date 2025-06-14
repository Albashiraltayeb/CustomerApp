//
//  CustomerDetailView.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

struct CustomerDetailView: View {
    @StateObject var viewModel: CustomerDetailViewModel

    var body: some View {
        Form {
            Section(header: Text("Customer Info")) {
                TextField("Name", text: $viewModel.name)
                    .disabled(!viewModel.isEditing)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .disabled(!viewModel.isEditing)

                Picker("Gender", selection: $viewModel.gender) {
                    Text("Male").tag("male")
                    Text("Female").tag("female")
                }
                .disabled(!viewModel.isEditing)

                Picker("Status", selection: $viewModel.status) {
                    Text("Active").tag("active")
                    Text("Inactive").tag("inactive")
                }
                .disabled(!viewModel.isEditing)
            }

        }
        .overlay(content: {
            if viewModel.isSaving {
                ProgressView("Saving...")
            }
        })
        .navigationTitle("Customer Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isEditing {
                    Button("Save") {
                        Task {
                            await viewModel.updateCustomer()
                        }
                    }
                } else {
                    Button("Edit") {
                        viewModel.isEditing = true
                    }
                }
            }
        }
        .toastView(toast: $viewModel.toast)
    }
}


#Preview {
    CustomerDetailView(viewModel: CustomerDetailViewModel(customer: Customer(id: 1,
                                                                             name: "bashir",
                                                                             email: "Bashir@gmail.com",
                                                                             gender: "MALE",
                                                                             status: "Active")))
}
