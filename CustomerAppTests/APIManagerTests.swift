//
//  CustomerAppTests.swift
//  CustomerAppTests
//
//  Created by mac air on 14/06/2025.
//

import XCTest
@testable import CustomerApp

final class APIManagerTests: XCTestCase {
    var apiManager: APIManager!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        apiManager = APIManager(customSession: session)
    }

    func testGetCustomersSuccess() async throws {
        let sampleJSON = """
        [
            {
                "id": 1,
                "name": "Test User",
                "email": "test@example.com",
                "gender": "male",
                "status": "active"
            }
        ]
        """.data(using: .utf8)!

        MockURLProtocol.stubResponseData = sampleJSON
        MockURLProtocol.stubResponseCode = 200

        do {
            let customers: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTAssertEqual(customers.count, 1)
            XCTAssertEqual(customers.first?.name, "Test User")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func testGetCustomersDecodingError() async {
        let invalidJSON = """
        { "invalid": "json" }
        """.data(using: .utf8)!

        MockURLProtocol.stubResponseData = invalidJSON
        MockURLProtocol.stubResponseCode = 200

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected decoding error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .decodingError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testServerError() async throws {
        MockURLProtocol.stubResponseData = Data()
        MockURLProtocol.stubResponseCode = 500

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected server error but got success.")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .internalServerError)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testBadRequestError() async throws {
        MockURLProtocol.stubResponseCode = 400
        MockURLProtocol.stubResponseData = Data()

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected bad request error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .badRequest)
        }
    }

    func testUnauthorizedError() async throws {
        MockURLProtocol.stubResponseData = Data()
        MockURLProtocol.stubResponseCode = 401

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected unauthorized error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .unauthorized)
        }
    }
    
    func testForbiddenError() async throws {
        MockURLProtocol.stubResponseCode = 403
        MockURLProtocol.stubResponseData = Data()

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected forbidden error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .forbidden)
        }
    }
    
    func testNotFoundError() async throws {
        MockURLProtocol.stubResponseCode = 404
        MockURLProtocol.stubResponseData = Data()

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected not found error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .notFound)
        }
    }
    
    func testMethodNotAllowedError() async throws {
        MockURLProtocol.stubResponseCode = 405
        MockURLProtocol.stubResponseData = Data()

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected method not allowed error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .methodNotAllowed)
        }
    }
    
    func testUnsupportedMediaTypeError() async throws {
        MockURLProtocol.stubResponseCode = 415
        MockURLProtocol.stubResponseData = Data()

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected unsupported media type error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .unsupportedMediaType)
        }
    }


    func testValidationFailedError() async throws {
        let errorBody = """
        [{"field":"email","message":"has already been taken"}]
        """.data(using: .utf8)!
        
        MockURLProtocol.stubResponseData = errorBody
        MockURLProtocol.stubResponseCode = 422

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected validation error")
        } catch let error as NetworkError {
            switch error {
            case .validationFailed(let data):
                XCTAssertEqual(data, errorBody)
            default:
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
    
    func testTooManyRequestsError() async throws {
        MockURLProtocol.stubResponseCode = 429
        MockURLProtocol.stubResponseData = Data()

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected too many requests error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .tooManyRequests)
        }
    }


}
