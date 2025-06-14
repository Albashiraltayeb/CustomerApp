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

    func testServerError() async {
        MockURLProtocol.stubResponseData = Data()
        MockURLProtocol.stubResponseCode = 500

        do {
            let _: [Customer] = try await apiManager.request(endpoint: "/users")
            XCTFail("Expected server error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .serverError(500))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
