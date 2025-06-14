//
//  NetworkError.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingError:
            return "Failed to decode data."
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .noData:
            return "No data received."
        }
    }
}

