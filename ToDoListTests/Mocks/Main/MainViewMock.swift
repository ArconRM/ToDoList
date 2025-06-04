//
//  MainViewMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

final class MainViewMock: MainViewProtocol {
    var loadedToDos: [ToDo]?
    var shownError: Error?
    
    var onLoadedToDos: (() -> Void)?
    var onShowError: (() -> Void)?
    
    func loadedAllToDos(_ todos: [ToDo]) {
        loadedToDos = todos
        onLoadedToDos?()
    }
    
    func showError(_ error: Error) {
        shownError = error
        onShowError?()
    }
}
