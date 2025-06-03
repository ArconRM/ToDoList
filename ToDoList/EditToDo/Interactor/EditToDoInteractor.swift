//
//  EditToDoInteractor.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct EditToDoInteractor: EditToDoInteractorProtocol {
    private let toDoPersistenceManager: ToDoPersistenceManagerProtocol
    
    init(toDoPersistenceManager: ToDoPersistenceManagerProtocol) {
        self.toDoPersistenceManager = toDoPersistenceManager
    }
    
    func updateToDo(toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        do {
            try toDoPersistenceManager.updateToDo(toDo)
            completion(.success(()))
        } catch(let error) {
            completion(.failure(error))
        }
    }
}
