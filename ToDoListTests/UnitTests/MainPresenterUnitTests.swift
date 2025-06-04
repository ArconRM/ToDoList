//
//  MainPresenterUnitTests.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import XCTest
import Foundation
@testable import ToDoList

final class MainPresenterUnitTests: XCTestCase {
    
    var interactor: MainInteractorMock!
    var view: MainViewMock!
    var router: MainRouterMock!
    var presenter: MainPresenter!
    
    override func setUp() {
        super.setUp()
        
        interactor = MainInteractorMock()
        view = MainViewMock()
        router = MainRouterMock()
        presenter = MainPresenter(interactor: interactor, router: router)
        presenter.view = view
    }
    
    func test_fetchAllToDos_success() {
        let mockToDos = ToDo.mocks
        interactor.fetchToDosResult = .success(mockToDos)
        
        let expectation = self.expectation(description: "fetchAllToDos completes")
        
        view.onLoadedToDos = {
            expectation.fulfill()
        }
        
        presenter.fetchAllToDos()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(view.loadedToDos?.count, mockToDos.count)
        XCTAssertEqual(Set(view.loadedToDos!), Set(mockToDos))
    }
    
    func test_fetchAllToDos_failure() {
        let error = NSError(domain: "test", code: 1)
        interactor.fetchToDosResult = .failure(error)
        
        let expectation = self.expectation(description: "fetchAllToDos fails")
        
        view.onShowError = {
            expectation.fulfill()
        }
        
        presenter.fetchAllToDos()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(view.shownError as NSError?, error)
    }
    
    func test_createNewToDo_success() {
        let toDo = ToDo.mocks.first!
        interactor.createEmptyToDoResult = .success(toDo)
        
        presenter.createNewToDo()
        
        XCTAssertEqual(router.shownToDo, toDo)
    }
    
    func test_createNewToDo_failure() {
        let error = NSError(domain: "create", code: 1)
        interactor.createEmptyToDoResult = .failure(error)
        
        presenter.createNewToDo()
        
        XCTAssertEqual(view.shownError as NSError?, error)
    }
    
    func test_toggleIsCompleted_success() {
        let toDo = ToDo.mocks.first!
        interactor.fetchToDosResult = .success([toDo])
        
        let expectation = self.expectation(description: "fetchAllToDos completes")
        
        view.onLoadedToDos = {
            expectation.fulfill()
        }
        
        presenter.toggleIsCompleted(for: toDo)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(interactor.toggleToDoCalledFor?.id, toDo.id)
        XCTAssertEqual(view.loadedToDos?.first?.title, "Mock")
    }
    
    func test_toggleIsCompleted_failure() {
        let toDo = ToDo.mocks.first!
        interactor.shouldThrowOnToggle = NSError(domain: "toggle", code: 1)
        
        presenter.toggleIsCompleted(for: toDo)
        
        XCTAssertNotNil(view.shownError)
    }
    
    func test_deleteToDo_success() {
        let toDo = ToDo.mocks.first!
        interactor.fetchToDosResult = .success([toDo])
        
        let expectation = self.expectation(description: "fetchAllToDos completes")
        
        view.onLoadedToDos = {
            expectation.fulfill()
        }
        
        presenter.deleteToDo(toDo: toDo)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(interactor.deletedToDo?.id, toDo.id)
        XCTAssertEqual(view.loadedToDos?.first?.title, "Mock")
    }
    
    func test_deleteToDo_failure() {
        let toDo = ToDo.mocks.first!
        interactor.shouldThrowOnDelete = NSError(domain: "delete", code: 1)
        
        presenter.deleteToDo(toDo: toDo)
        
        XCTAssertNotNil(view.shownError)
    }
}
