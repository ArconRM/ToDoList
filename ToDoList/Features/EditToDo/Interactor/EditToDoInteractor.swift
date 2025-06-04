//
//  EditToDoInteractor.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

final class EditToDoInteractor: EditToDoInteractorProtocol {
    private let toDoPersistenceManager: ToDoPersistenceManagerProtocol
    
    init(toDoPersistenceManager: ToDoPersistenceManagerProtocol) {
        self.toDoPersistenceManager = toDoPersistenceManager
    }
    
    func updateToDo(toDo: ToDo) throws {
        try toDoPersistenceManager.updateToDo(toDo)
    }
    
    func updateToDo(toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.toDoPersistenceManager.updateToDo(toDo)
                
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
