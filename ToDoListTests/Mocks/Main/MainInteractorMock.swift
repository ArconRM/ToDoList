//
//  MainInteractorMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

final class MainInteractorMock: MainInteractorProtocol {
    var fetchToDosResult: Result<[ToDo], Error>?
    func fetchToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        if let result = fetchToDosResult {
            completion(result)
        }
    }
    
    var createEmptyToDoResult: Result<ToDo, Error>?
    func createEmptyToDo() throws -> ToDo {
        switch createEmptyToDoResult {
        case .success(let toDo): return toDo
        case .failure(let error): throw error
        case .none: fatalError("createEmptyToDoResult not set")
        }
    }
    
    var toggleToDoCalledFor: ToDo?
    var shouldThrowOnToggle: Error?
    func toggleIsChecked(for toDo: ToDo) throws {
        toggleToDoCalledFor = toDo
        if let error = shouldThrowOnToggle { throw error }
    }
    
    var deletedToDo: ToDo?
    var shouldThrowOnDelete: Error?
    func deleteToDo(toDo: ToDo) throws {
        deletedToDo = toDo
        if let error = shouldThrowOnDelete { throw error }
    }
}
