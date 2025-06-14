//
//  CustomerListViewModelTests.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import XCTest
@testable import CustomerApp

@MainActor
final class CustomerListViewModelTests: XCTestCase {
    var viewModel: CustomerListViewModel!
    var mockRepository: MockCustomerRepository!
    var mocApiManager: APIManagerMock!
    override func setUp() {
        super.setUp()
        mockRepository = MockCustomerRepository()
        mocApiManager = APIManagerMock()
        viewModel = CustomerListViewModel(repository: mockRepository, apiManager: mocApiManager)
    }

    func testFetchCustomers_success() async {
        mockRepository.customersToReturn = [Customer(id: 1, name: "Test", email: "test@example.com", gender: "male", status: "active")]

        await viewModel.fetchCustomers()

        XCTAssertEqual(viewModel.customers.count, 1)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchCustomers_failure() async {
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.internalServerError

        await viewModel.fetchCustomers()

        XCTAssertEqual(viewModel.customers.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to load customers.")
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchCustomers_offline() async {
        Reachability.shared.isConnected = false
        await viewModel.fetchCustomers()

        XCTAssertTrue(viewModel.isOffline)
        XCTAssertEqual(viewModel.toast?.message, "Offline Mode")
    }
    
    func testDeleteCustomer_success() async {
        
        mocApiManager.mockResponse = EmptyResponse()
        mockRepository.customersToReturn = [
            Customer(id: 2, name: "Jane", email: "jane@example.com", gender: "female", status: "active")
        ]

        let customerToDelete = Customer(id: 1, name: "John", email: "john@example.com", gender: "male", status: "active")

        await viewModel.deleteCustomer(customerToDelete)

        XCTAssertEqual(mocApiManager.lastEndpoint, "/users/1")
        XCTAssertEqual(viewModel.toast?.message, "Customer deleted successfully.")
        XCTAssertEqual(viewModel.customers.count, 1)
        XCTAssertEqual(viewModel.customers.first?.name, "Jane") // Ensure it fetched correctly
    }


}
