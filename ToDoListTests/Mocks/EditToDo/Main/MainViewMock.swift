//
//  MainViewMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

class MainViewMock: MainViewProtocol {
    var loadedToDos: [ToDo]?
    var shownError: Error?
    
    func loadedAllToDos(_ toDos: [ToDo]) {
        loadedToDos = toDos
    }
    
    func showError(_ error: Error) {
        shownError = error
    }
}
