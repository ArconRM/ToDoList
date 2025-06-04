//
//  EditToDoViewMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

final class EditToDoViewMock: EditToDoViewProtocol {
    var configuredToDo: ToDo?
    var shownError: Error?
    
    var onConfiguredToDo: (() -> Void)?
    var onShowError: (() -> Void)?
    
    func configureWithItem(_ toDo: ToDo) {
        configuredToDo = toDo
        onConfiguredToDo?()
    }
    
    func showError(_ error: Error) {
        shownError = error
        onShowError?()
    }
}
