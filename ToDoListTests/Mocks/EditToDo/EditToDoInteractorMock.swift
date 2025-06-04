//
//  EditToDoInteractorMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

final class EditToDoInteractorMock: EditToDoInteractorProtocol {
    var updatedToDo: ToDo?
    var shouldThrowOnUpdate: Error?
    
    func updateToDo(toDo: ToDo) throws {
        updatedToDo = toDo
        if let error = shouldThrowOnUpdate { throw error }
    }
}
