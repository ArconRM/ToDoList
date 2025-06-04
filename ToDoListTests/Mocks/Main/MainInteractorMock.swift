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

    var createEmptyToDoResult: ToDo?
    var shouldThrowOnCreate: Error?
    func createEmptyToDo(completion: @escaping (Result<ToDo, any Error>) -> Void) {
        if let error = shouldThrowOnCreate {
            completion(.failure(error))
        } else if let toDo = createEmptyToDoResult {
            completion(.success(toDo))
        } else {
            fatalError("createEmptyToDoResult not set")
        }
    }

    var toggleToDoCalledFor: ToDo?
    var shouldThrowOnToggle: Error?
    func toggleIsChecked(for toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        toggleToDoCalledFor = toDo
        if let error = shouldThrowOnToggle {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }

    var deletedToDo: ToDo?
    var shouldThrowOnDelete: Error?
    func deleteToDo(toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        deletedToDo = toDo
        if let error = shouldThrowOnDelete {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}
