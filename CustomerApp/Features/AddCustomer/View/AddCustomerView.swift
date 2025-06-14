//
//  AddCustomerView.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

struct AddCustomerView: View {
    @ObservedObject var viewModel: AddCustomerViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Customer Info")) {
                    TextField("Name", text: $viewModel.name)
                        .accessibilityIdentifier("NameField")

                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                         .autocapitalization(.none)
                         .autocorrectionDisabled()
                         .overlay(
                             Group {
                                 HStack{
                                     Spacer()
                                     if !viewModel.isEmailValid && !viewModel.email.isEmpty {
                                         Text("Invalid email")
                                             .font(.caption)
                                             .foregroundColor(.red)
                                             .padding(.top, 2)
                                     }
                                 }
                             },
                             alignment: .bottomLeading
                         )
                         .accessibilityIdentifier("EmailField")

                    Picker("Gender", selection: $viewModel.gender) {
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                    }
                    .accessibilityLabel("Gender")

                    Picker("Status", selection: $viewModel.status) {
                        Text("Active").tag("active")
                        Text("Inactive").tag("inactive")
                    }
                    .accessibilityIdentifier("StatusPicker")

                }

                if viewModel.isSubmitting {
                    ProgressView()
                } else {
                    Button("Add Customer") {
                        Task {
                            await viewModel.submit()
                        }
                    }
                    .accessibilityIdentifier("SubmitButton")

                }
            }
            .navigationTitle("Add Customer")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toastView(toast: $viewModel.toast)
    }
}
