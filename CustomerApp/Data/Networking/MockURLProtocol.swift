//
//  MockURLProtocol.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
import Foundation

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var stubResponseCode: Int = 200

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let url = request.url,
           let client = client {
            let response = HTTPURLResponse(
                url: url,
                statusCode: Self.stubResponseCode,
                httpVersion: nil,
                headerFields: nil
            )!
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = Self.stubResponseData {
                client.urlProtocol(self, didLoad: data)
            }

            client.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}

