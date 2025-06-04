//
//  MainInteractorMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

class MainInteractorMock: MainInteractorProtocol {
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
    
    var toggleToDoCalledWith: ToDo?
    func toggleIsChecked(for toDo: ToDo) throws {
        toggleToDoCalledWith = toDo
    }
    
    var deletedToDo: ToDo?
    func deleteToDo(toDo: ToDo) throws {
        deletedToDo = toDo
    }
}
