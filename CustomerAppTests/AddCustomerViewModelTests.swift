//
//  AddCustomerViewModelTests.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import XCTest
@testable import CustomerApp

@MainActor
final class AddCustomerViewModelTests: XCTestCase {
    var viewModel: AddCustomerViewModel!
    var mockAPI: APIManagerMock!
    var successCalled: Bool!

    override func setUp() {
        super.setUp()
        mockAPI = APIManagerMock()
        successCalled = false
        viewModel = AddCustomerViewModel(apiManager: mockAPI, onSuccess: { [weak self] in
            self?.successCalled = true
        })
    }

    func testSubmit_successful() async {
        viewModel.name = "Test User"
        viewModel.email = "test@example.com"
        mockAPI.mockResponse = Customer(id: 1, name: "Test", email: "test@example.com", gender: "male", status: "active")

        await viewModel.submit()

        XCTAssertEqual(mockAPI.lastMethod, "POST")
        XCTAssertTrue(successCalled)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.toast)
        XCTAssertFalse(viewModel.isSubmitting)
    }

    func testSubmit_missingFields() async {
        viewModel.name = ""
        viewModel.email = ""

        await viewModel.submit()

        XCTAssertEqual(viewModel.errorMessage, "Name and email are required.")
        XCTAssertEqual(viewModel.toast?.message, "Name and email are required.")
        XCTAssertNil(mockAPI.lastMethod)
    }

    func testSubmit_invalidEmail() async {
        viewModel.name = "Test"
        viewModel.email = "invalid-email"

        await viewModel.submit()

        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid email address.")
        XCTAssertEqual(viewModel.toast?.message, "Please enter a valid email address.")
        XCTAssertNil(mockAPI.lastMethod) 
    }

    func testSubmit_validationError_fromAPI() async {
        viewModel.name = "Test"
        viewModel.email = "test@example.com"

        let validationData = """
        {
            "message": "Email already exists."
        }
        """.data(using: .utf8)!

        mockAPI.shouldThrow = true
        mockAPI.thrownError = NetworkError.validationFailed(validationData)

        await viewModel.submit()

        XCTAssertEqual(viewModel.toast?.message, "Validation failed. Please check your input.")
        XCTAssertFalse(successCalled)
    }

    func testSubmit_unexpectedNetworkError() async {
        viewModel.name = "Test"
        viewModel.email = "test@example.com"

        mockAPI.shouldThrow = true
        mockAPI.thrownError = NetworkError.internalServerError

        await viewModel.submit()

        XCTAssertEqual(viewModel.toast?.message, NetworkError.internalServerError.userFriendlyMessage)
        XCTAssertFalse(successCalled)
    }
}
