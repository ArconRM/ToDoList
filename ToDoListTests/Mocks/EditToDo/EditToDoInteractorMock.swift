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
    
    func updateToDo(toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        updatedToDo = toDo
        if let error = shouldThrowOnUpdate {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}
