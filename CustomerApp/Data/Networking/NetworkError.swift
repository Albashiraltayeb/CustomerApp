//
//  NetworkError.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case noData
    case decodingError
    case unauthorized           // 401
    case forbidden              // 403
    case notFound               // 404
    case methodNotAllowed       // 405
    case unsupportedMediaType   // 415
    case validationFailed(Data) // 422 with error body
    case tooManyRequests        // 429
    case internalServerError    // 500
    case badRequest             // 400

}

extension NetworkError {
    var userFriendlyMessage: String {
        switch self {
        case .unauthorized:
            return "Unauthorized. Please check your token."
        case .forbidden:
            return "Forbidden. You are not allowed to do this."
        case .tooManyRequests:
            return "Too many requests. Please wait a moment and try again."
        case .internalServerError:
            return "Server error. Please try again later."
        case .badRequest:
            return "Bad request. Please check your data."
        case .notFound:
            return "The resource was not found."
        case .methodNotAllowed:
            return "Method not allowed."
        case .unsupportedMediaType:
            return "Unsupported media type."
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .noData:
            return "No data received."
        case .decodingError:
            return "Something went wrong while reading the server response."
        case .serverError(let code):
            return "Server returned an error (code: \(code))."
        case .validationFailed(let data):
            // Fallback if not decoded
            return "Validation failed. Please check your input."
        }
    }
}
