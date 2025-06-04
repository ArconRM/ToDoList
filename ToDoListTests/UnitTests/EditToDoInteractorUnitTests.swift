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

        XCTAssertNoThrow(try interactor.updateToDo(toDo: toDo))
        XCTAssertEqual(persistenceManager.updatedToDo?.id, toDo.id)
    }

    func test_updateToDo_failure() {
        let toDo = ToDo.mocks.first!
        persistenceManager.shouldThrowOnUpdate = true

        XCTAssertThrowsError(try interactor.updateToDo(toDo: toDo)) { error in
            XCTAssertEqual((error as NSError).domain, "update")
        }
    }
}
