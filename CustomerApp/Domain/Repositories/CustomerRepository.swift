//
//  CustomerRepository.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

protocol CustomerRepository {
    func fetchCustomers() async throws -> [Customer]
}
