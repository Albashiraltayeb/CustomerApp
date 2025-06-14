//
//  CustomerListView.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import SwiftUI

struct CustomerListView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject var viewModel: CustomerListViewModel
    @State private var showingAddCustomer = false

    var body: some View {
        NavigationView {
            List(viewModel.customers, id: \.id) { customer in
                Button {
                    router.navigate(to: .customerDetail(customer))
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(customer.name)
                            .font(.headline)
                            .accessibilityIdentifier("CustomerName_\(customer.id)")
                            .foregroundColor(.black)
                        Text(customer.email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("CustomerEmail_\(customer.id)")
                    }
                }
            }
            .accessibilityIdentifier("CustomerList")
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .accessibilityIdentifier("LoadingView")

                } else if viewModel.customers.isEmpty {
                    Text("No customers available")
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("EmptyStateView")

                }
            }
            .refreshable {
                await viewModel.fetchCustomers()
            }
            .navigationTitle("Customers")
            .task {
                await viewModel.fetchCustomers()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddCustomer = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert(item: Binding(
                get: {
                    viewModel.errorMessage.map { MessageAlert(message: $0) }
                },
                set: { _ in viewModel.errorMessage = nil }
            )) { alert in
                Alert(title: Text("Notice"), message: Text(alert.message), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showingAddCustomer) {
                AddCustomerView(
                    viewModel: AddCustomerViewModel(
                        apiManager: APIManager.shared,
                        onSuccess: {
                            showingAddCustomer = false
                            viewModel.reload() // refresh list
                        }
                    )
                )
            }
        }
    }
}


//#Preview {
//    let viewModel = CustomerListViewModel(apiManager: APIManager(), cacheService: CustomerCacheService())
//  CustomerListView(viewModel: viewModel)
//}
 

// Helper for alert
struct MessageAlert: Identifiable {
    let id = UUID()
    let message: String
}
