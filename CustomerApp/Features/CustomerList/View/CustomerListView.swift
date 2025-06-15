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
    @State private var customerToDelete: Customer?
    @State private var showingDeleteAlert = false

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
                .swipeActions {
                    Button(role: .destructive) {
                        Task {
                            await viewModel.deleteCustomer(customer)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .accessibilityLabel("Delete") 
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
                    .accessibilityIdentifier("Add Customer")
                }
            }
            .sheet(isPresented: $showingAddCustomer) {
                AddCustomerView(
                    viewModel: AddCustomerViewModel(
                        onSuccess: {
                            showingAddCustomer = false
                            viewModel.reload() // refresh list
                        }
                    )
                )
            }
            
        }
        .toastView(toast: $viewModel.toast)

    }
}


//#Preview {
//    let viewModel = CustomerListViewModel(apiManager: APIManager(), cacheService: CustomerCacheService())
//  CustomerListView(viewModel: viewModel)
//}
 
