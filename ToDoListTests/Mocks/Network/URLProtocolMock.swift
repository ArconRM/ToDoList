//
//  URLProtocolMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 05.06.2025.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var testData: Data?
    static var testError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = URLProtocolMock.testError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else if let data = URLProtocolMock.testData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
