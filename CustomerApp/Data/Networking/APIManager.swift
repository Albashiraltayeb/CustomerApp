//
//  APIManager.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    private let session: URLSession

     init(session: URLSession = .shared) {
        self.session = session
    }

    init(customSession: URLSession) {
        self.session = customSession
    }
    


    private let baseURL = "https://gorest.co.in/public/v2"
    private let authToken = "Bearer 07ef01fd158d012b8cde6ed8d1165951260332dfddee838b0a6f622f639e6241" // <-- Replace with your token

    private var defaultHeaders: [String: String] {
        [
            "Authorization": authToken,
            "Content-Type": "application/json"
        ]
    }
    // MARK: - GET
    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = defaultHeaders
        request.httpBody = body

        let (data, response) = try await session.data(for: request)

        print(response)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }

        guard !data.isEmpty else {
            throw NetworkError.noData
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    
    
    // MARK: - POST
    func post<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U
    ) async throws -> T {
        let jsonData = try JSONEncoder().encode(body)
        return try await request(endpoint: endpoint, method: "POST", body: jsonData)
    }

    // MARK: - PUT
    func put<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U
    ) async throws -> T {
        let jsonData = try JSONEncoder().encode(body)
        return try await request(endpoint: endpoint, method: "PUT", body: jsonData)
    }
    
    // MARK: - Delete
    func delete(endpoint: String) async throws {
        _ = try await request(endpoint: endpoint, method: "DELETE") as EmptyResponse
    }
}

struct EmptyResponse: Decodable {}


struct Customer: Codable, Identifiable {
    let id: Int
    var name: String
    var email: String
    var gender: String
    var status: String
}
