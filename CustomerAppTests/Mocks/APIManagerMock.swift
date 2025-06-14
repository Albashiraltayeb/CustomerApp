//
//  APIManagerMock.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import Foundation

final class APIManagerMock: APIManaging {
    var shouldThrow = false
    var thrownError: Error?

    private(set) var lastEndpoint: String?
    private(set) var lastMethod: String?
    private(set) var lastBody: Data?

    var mockResponse: Any?

    func request<T: Decodable>(
        endpoint: String,
        method: String,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil
    ) async throws -> T {
        lastEndpoint = endpoint
        lastMethod = method
        lastBody = body

        if shouldThrow, let error = thrownError {
            throw error
        }

        guard let response = mockResponse as? T else {
            throw NetworkError.noData
        }

        return response
    }

    func post<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U
    ) async throws -> T {
        let data = try JSONEncoder().encode(body)
        return try await request(endpoint: endpoint, method: "POST", body: data)
    }

    func put<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U
    ) async throws -> T {
        let data = try JSONEncoder().encode(body)
        return try await request(endpoint: endpoint, method: "PUT", body: data)
    }

    func delete(endpoint: String) async throws {
        _ = try await request(endpoint: endpoint, method: "DELETE") as EmptyResponse
    }
}
