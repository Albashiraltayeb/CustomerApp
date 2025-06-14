//
//  CustomerListView.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

struct CustomerListView: View {
    @StateObject var viewModel: CustomerListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.customers, id: \.id) { customer in
                VStack(alignment: .leading, spacing: 4) {
                    Text(customer.name)
                        .font(.headline)
                    Text(customer.email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.customers.isEmpty {
                    Text("No customers available")
                        .foregroundColor(.gray)
                }
            }
            .refreshable {
                await viewModel.fetchCustomers()
            }
            .navigationTitle("Customers")
            .alert(item: Binding(
                get: {
                    viewModel.errorMessage.map { MessageAlert(message: $0) }
                },
                set: { _ in viewModel.errorMessage = nil }
            )) { alert in
                Alert(title: Text("Notice"), message: Text(alert.message), dismissButton: .default(Text("OK")))
            }

        }
    }
}

// Helper for alert
struct MessageAlert: Identifiable {
    let id = UUID()
    let message: String
}
