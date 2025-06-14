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
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil
    ) async throws -> T {
        guard var components = URLComponents(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }


        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = defaultHeaders
        request.httpBody = body

        let (data, response) = try await session.data(for: request)

        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON:\n\(jsonString)")
        } else {
            print("Failed to convert response data to string")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            switch httpResponse.statusCode {
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 405:
                throw NetworkError.methodNotAllowed
            case 415:
                throw NetworkError.unsupportedMediaType
            case 422:
                throw NetworkError.validationFailed(data)
            case 429:
                throw NetworkError.tooManyRequests
            case 500:
                throw NetworkError.internalServerError
            default:
                throw NetworkError.serverError(httpResponse.statusCode)
            }
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



