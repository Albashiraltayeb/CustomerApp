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
            Section(header: Text("Basic Info")) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(viewModel.customer.name)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Email")
                    Spacer()
                    Text(viewModel.customer.email)
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Details")) {
                HStack {
                    Text("Gender")
                    Spacer()
                    Text(viewModel.customer.gender.capitalized)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Status")
                    Spacer()
                    Text(viewModel.customer.status.capitalized)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Customer Details")
    }
}


#Preview {
    CustomerDetailView(viewModel: CustomerDetailViewModel(customer: Customer(id: 1,
                                                                             name: "bashir",
                                                                             email: "Bashir@gmail.com",
                                                                             gender: "MALE",
                                                                             status: "Active")))
}
