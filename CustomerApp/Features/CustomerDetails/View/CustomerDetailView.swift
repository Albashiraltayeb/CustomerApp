//
//  CustomerDetailView.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

import SwiftUI

struct CustomerDetailView: View {
    @StateObject var viewModel: CustomerDetailViewModel

    var body: some View {
        Form {
            Section(header: Text("Customer Info")) {
                TextField("Name", text: $viewModel.name)
                    .disabled(!viewModel.isEditing)
                    .accessibilityIdentifier("NameTextField_Detail")
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .disabled(!viewModel.isEditing)
                    .accessibilityIdentifier("EmailTextField_Detail")

                Picker("Gender", selection: $viewModel.gender) {
                    Text("Male").tag("male")
                    Text("Female").tag("female")
                }
                .disabled(!viewModel.isEditing)
                .accessibilityIdentifier("GenderPicker_Detail")

                Picker("Status", selection: $viewModel.status) {
                    Text("Active").tag("active")
                    Text("Inactive").tag("inactive")
                }
                .disabled(!viewModel.isEditing)
                .accessibilityIdentifier("StatusPicker_Detail")
            }

        }
        .overlay(content: {
            if viewModel.isSaving {
                ProgressView("Saving...")
                    .accessibilityIdentifier("SavingProgressView")
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
                    .accessibilityIdentifier("SaveButton")
                } else {
                    Button("Edit") {
                        viewModel.isEditing = true
                    }
                    .accessibilityIdentifier("EditButton")
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
