//
//  ToDoPersistenceManagerMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 04.06.2025.
//

import Foundation
@testable import ToDoList

final class ToDoPersistenceManagerMock: ToDoPersistenceManagerProtocol {
    func saveToDo(_ toDo: ToDoList.ToDo) throws { }

    var savedToDos: [ToDo] = []
    var loadedToDos: [ToDo] = []
    var updatedToDo: ToDo?
    var shouldThrowOnSave = false
    var shouldThrowOnLoad = false
    var shouldThrowOnUpdate = false

    func saveToDos(_ todos: [ToDo]) throws {
        savedToDos = todos
        if shouldThrowOnSave { throw NSError(domain: "save", code: 1) }
    }

    func loadAllToDos() throws -> [ToDo] {
        if shouldThrowOnLoad { throw NSError(domain: "load", code: 1) }
        return loadedToDos
    }

    func createEmptyToDo() throws -> ToDo {
        return ToDo.mocks.first!
    }

    func updateToDo(_ todo: ToDo) throws {
        updatedToDo = todo
        if shouldThrowOnUpdate { throw NSError(domain: "update", code: 1) }
    }

    func deleteToDo(id: Int) throws {}
}
