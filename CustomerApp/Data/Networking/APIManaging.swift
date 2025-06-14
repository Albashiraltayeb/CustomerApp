//
//  APIManaging.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import Foundation

protocol APIManaging {
    
    func request<T: Decodable>(
        endpoint: String,
        method: String,
        queryItems: [URLQueryItem]?,
        body: Data?
    ) async throws -> T

    func post<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U
    ) async throws -> T

    func put<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U
    ) async throws -> T

    func delete(endpoint: String) async throws
}
