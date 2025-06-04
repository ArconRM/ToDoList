//
//  NetworkServiceUnitTests.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 05.06.2025.
//

import Foundation
import XCTest
@testable import ToDoList

final class NetworkServiceUnitTests: XCTestCase {

    var urlSource: ToDoUrlSource!
    var session: URLSession!
    var service: ToDoNetworkService!

    override func setUp() {
        super.setUp()

        urlSource = ToDoUrlSource()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        session = URLSession(configuration: config)

        service = ToDoNetworkService(urlSource: urlSource, session: session)
    }

    func test_fetchAllToDos_success() {
        let expectedToDos = ToDoDTO.mocks
        let listDTO = ToDoListDTO(todos: expectedToDos, total: 7, skip: 0, limit: 0)
        let data = try! JSONEncoder().encode(listDTO)

        URLProtocolMock.testData = data
        URLProtocolMock.testError = nil

        let expectation = self.expectation(description: "fetch completes")

        service.fetchAllToDos(resultQueue: .main) { result in
            switch result {
            case .success(let todos):
                XCTAssertEqual(Set(todos), Set(ToDoDTO.mocks))
                XCTAssertEqual(todos.count, ToDoDTO.mocks.count)
            case .failure:
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func test_fetchAllToDos_failure() {
        let error = NSError(domain: "fetch", code: 1)
        URLProtocolMock.testError = error
        URLProtocolMock.testData = nil

        let expectation = self.expectation(description: "fetch fails")

        service.fetchAllToDos(resultQueue: .main) { result in
            switch result {
            case .success:
                XCTFail("Should have failed")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "fetch")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
