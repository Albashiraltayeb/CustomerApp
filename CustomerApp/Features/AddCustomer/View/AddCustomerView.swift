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
                    Picker("Gender", selection: $viewModel.gender) {
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                    }
                    Picker("Status", selection: $viewModel.status) {
                        Text("Active").tag("active")
                        Text("Inactive").tag("inactive")
                    }
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                if viewModel.isSubmitting {
                    ProgressView()
                } else {
                    Button("Add Customer") {
                        Task {
                            await viewModel.submit()
                        }
                    }
                }
            }
            .navigationTitle("Add Customer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
