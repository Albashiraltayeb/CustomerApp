//
//  MockCustomerRepository.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import Foundation


class MockCustomerRepository: CustomerRepository {
    var customersToReturn: [Customer] = []
    var shouldThrowError = false
    var errorToThrow: Error?

    func fetchCustomers() async throws -> [Customer] {
        if shouldThrowError {
            throw errorToThrow ?? NetworkError.serverError(500)
        }
        return customersToReturn
    }
}
