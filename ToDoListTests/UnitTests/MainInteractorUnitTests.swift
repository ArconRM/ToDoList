//
//  MainInteractorUnitTests.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
import XCTest
@testable import ToDoList

final class MainInteractorUnitTests: XCTestCase {

    var networkService: ToDoNetworkServiceMockData!
    var persistenceManager: ToDoPersistenceManagerMock!
    var interactor: MainInteractor!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.wasLaunched.rawValue)

        networkService = ToDoNetworkServiceMockData()
        persistenceManager = ToDoPersistenceManagerMock()
        interactor = MainInteractor(toDoNetworkService: networkService, toDoPersistenceManager: persistenceManager)
    }

    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.wasLaunched.rawValue)
    }

    func test_fetchToDos_firstLaunch_savesToPersistence() {
        let expectation = self.expectation(description: "fetch from network")
        
        let expected = ToDo.mocks

        interactor.fetchToDos { result in
            switch result {
            case .success(let todos):
                XCTAssertEqual(todos.count, expected.count)
                XCTAssertEqual(self.persistenceManager.savedToDos.count, expected.count)
                XCTAssertTrue(UserDefaults.standard.bool(forKey: UserDefaultsKeys.wasLaunched.rawValue))
            case .failure:
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func test_fetchToDos_secondLaunch_loadsFromPersistence() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.wasLaunched.rawValue)

        let expected = ToDo.mocks
        persistenceManager.loadedToDos = expected

        let expectation = self.expectation(description: "fetch from core data")

        interactor.fetchToDos { result in
            switch result {
            case .success(let todos):
                XCTAssertEqual(todos.count, ToDoDTO.mocks.count)
                XCTAssertEqual(self.persistenceManager.savedToDos.count, ToDoDTO.mocks.count)
            case .failure:
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func test_fetchToDos_firstLaunch_saveFails() {
        persistenceManager.shouldThrowOnSave = true

        let expectation = self.expectation(description: "save failure")

        interactor.fetchToDos { result in
            switch result {
            case .success:
                XCTFail("Should have failed")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, "save")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func test_fetchToDos_secondLaunch_loadFails() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.wasLaunched.rawValue)
        persistenceManager.shouldThrowOnLoad = true

        let expectation = self.expectation(description: "load failure")

        interactor.fetchToDos { result in
            switch result {
            case .success:
                XCTFail("Should have failed")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, "load")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }
}
