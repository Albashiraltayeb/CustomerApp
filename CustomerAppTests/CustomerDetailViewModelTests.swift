//
//  CustomerDetailViewModelTests.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import XCTest
@testable import CustomerApp

@MainActor
final class CustomerDetailViewModelTests: XCTestCase {
    var viewModel: CustomerDetailViewModel!
    var mockAPI: APIManagerMock!
    var testCustomer: Customer!

    override func setUp() {
        super.setUp()
        mockAPI = APIManagerMock()
        testCustomer = Customer(id: 1, name: "John Doe", email: "john@example.com", gender: "male", status: "active")
        viewModel = CustomerDetailViewModel(customer: testCustomer, apiManager: mockAPI)
    }

    func testUpdateCustomer_success() async {
        viewModel.name = "Updated Name"
        viewModel.email = "updated@example.com"
        mockAPI.mockResponse = testCustomer 

        await viewModel.updateCustomer()

        XCTAssertEqual(mockAPI.lastMethod, "PUT")
        XCTAssertEqual(mockAPI.lastEndpoint, "/users/\(testCustomer.id)")
        XCTAssertEqual(viewModel.toast?.message, "Customer updated successfully!")
        XCTAssertFalse(viewModel.isEditing)
        XCTAssertFalse(viewModel.isSaving)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testUpdateCustomer_missingFields() async {
        viewModel.name = ""
        viewModel.email = ""

        await viewModel.updateCustomer()

        XCTAssertEqual(viewModel.errorMessage, "Name and email are required.")
        XCTAssertEqual(viewModel.toast?.message, "Name and email are required.")
        XCTAssertNil(mockAPI.lastMethod)
    }

    func testUpdateCustomer_validationError() async {
        viewModel.name = "John"
        viewModel.email = "invalid@example.com"

        let validationData = """
        {
            "message": "Email already taken."
        }
        """.data(using: .utf8)!

        mockAPI.shouldThrow = true
        mockAPI.thrownError = NetworkError.validationFailed(validationData)

        await viewModel.updateCustomer()

        XCTAssertEqual(viewModel.toast?.message, "Validation failed. Please check your input.")
        XCTAssertEqual(viewModel.errorMessage, "Validation failed. Please check your input.")
        XCTAssertFalse(viewModel.isSaving)
    }

    func testUpdateCustomer_unexpectedNetworkError() async {
        viewModel.name = "John"
        viewModel.email = "john@example.com"

        mockAPI.shouldThrow = true
        mockAPI.thrownError = NetworkError.internalServerError

        await viewModel.updateCustomer()

        // Assert
        XCTAssertEqual(viewModel.toast?.message, NetworkError.internalServerError.userFriendlyMessage)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.internalServerError.userFriendlyMessage)
        XCTAssertFalse(viewModel.isSaving)
    }
}
