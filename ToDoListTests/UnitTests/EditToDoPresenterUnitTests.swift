//
//  EditToDoPresenterUnitTests.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 04.06.2025.
//

import Foundation
import XCTest
@testable import ToDoList

final class EditToDoPresenterTests: XCTestCase {
    
    var view: EditToDoViewMock!
    var interactor: EditToDoInteractorMock!
    var presenter: EditToDoPresenter!
    
    override func setUp() {
        view = EditToDoViewMock()
        interactor = EditToDoInteractorMock()
        presenter = EditToDoPresenter(interactor: interactor, toDo: ToDo.mocks.first!)
        presenter.view = view
    }
    
    func test_viewDidLoad_configuresViewWithToDo() {
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.configuredToDo?.id, presenter.toDo.id)
        XCTAssertEqual(view.configuredToDo?.title, presenter.toDo.title)
    }
    
    func test_updateToDo_success() {
        presenter.updateToDo(title: "Updated title", description: "Updated description")
        
        XCTAssertEqual(interactor.updatedToDo?.title, "Updated title")
        XCTAssertEqual(interactor.updatedToDo?.description, "Updated description")
        XCTAssertNil(view.shownError)
    }
    
    func test_updateToDo_keepsOldValuesWhenTitleAndDescriptionAreEmpty() {
        let originalTitle = presenter.toDo.title
        let originalDescription = presenter.toDo.description
        
        presenter.updateToDo(title: "", description: "")
        
        XCTAssertEqual(interactor.updatedToDo?.title, originalTitle)
        XCTAssertEqual(interactor.updatedToDo?.description, originalDescription)
    }
    
    func test_updateToDo_failure() {
        let error = NSError(domain: "update", code: 1)
        interactor.shouldThrowOnUpdate = error
        
        presenter.updateToDo(title: "Updated title", description: "Updated description")
        
        XCTAssertEqual(view.shownError as NSError?, error)
    }
}
