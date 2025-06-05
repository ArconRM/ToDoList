//
//  EditToDoInteractorUnitTests.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 04.06.2025.
//

import Foundation
import XCTest
@testable import ToDoList

final class EditToDoInteractorTests: XCTestCase {

    var persistenceManager: ToDoPersistenceManagerMock!
    var interactor: EditToDoInteractor!

    override func setUp() {
        persistenceManager = ToDoPersistenceManagerMock()
        interactor = EditToDoInteractor(toDoPersistenceManager: persistenceManager)
    }

    func test_updateToDo_success() {
        let toDo = ToDo.mocks.first!
        let expectation = self.expectation(description: "update success")
        
        interactor.updateToDo(toDo: toDo) { result in
            switch result {
            case .success:
                XCTAssertEqual(self.persistenceManager.updatedToDo?.id, toDo.id)
            case .failure:
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }

    func test_updateToDo_failure() {
        let toDo = ToDo.mocks.first!
        persistenceManager.shouldThrowOnUpdate = true
        let expectation = self.expectation(description: "update failure")
        
        interactor.updateToDo(toDo: toDo) { result in
            switch result {
            case .success:
                XCTFail("Should have failed")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, "update")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
}
