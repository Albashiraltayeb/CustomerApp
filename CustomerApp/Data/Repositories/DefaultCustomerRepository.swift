//
//  DefaultCustomerRepository.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

final class DefaultCustomerRepository: CustomerRepository {
    private let apiManager: APIManager
    private let cacheService: CustomerCacheService
    private let reachability: Reachability

    init(apiManager: APIManager, cacheService: CustomerCacheService, reachability: Reachability = .shared) {
        self.apiManager = apiManager
        self.cacheService = cacheService
        self.reachability = reachability
    }

    func fetchCustomers() async throws -> [Customer] {
        if reachability.isConnected {
            do {
                let remoteCustomers: [Customer] = try await apiManager.request(endpoint: "/users")
                try cacheService.saveCustomers(remoteCustomers)
                return remoteCustomers
            } catch {
                print("API failed. Falling back to cache. Error: \(error)")
                return try cacheService.fetchCustomers()
            }
        } else {
            print("Offline – loading from cache")
            return try cacheService.fetchCustomers()
        }
    }
}
