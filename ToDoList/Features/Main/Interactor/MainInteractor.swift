//
//  MainInteractor.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

final class MainInteractor: MainInteractorProtocol {

    private let toDoNetworkService: ToDoNetworkServiceProtocol
    private let toDoPersistenceManager: ToDoPersistenceManagerProtocol

    private var wasLaunched: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.wasLaunched.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.wasLaunched.rawValue)
        }
    }

    init(toDoNetworkService: ToDoNetworkServiceProtocol, toDoPersistenceManager: ToDoPersistenceManagerProtocol) {
        self.toDoNetworkService = toDoNetworkService
        self.toDoPersistenceManager = toDoPersistenceManager
    }

    func fetchToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        if !wasLaunched {
            fetchNetworkToDos { result in
                switch result {
                case .success(let toDos):
                    DispatchQueue.global(qos: .userInitiated).async {
                        do {
                            try self.toDoPersistenceManager.saveToDos(toDos)
                            completion(.success(toDos))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    self.wasLaunched = true
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let toDos = try self.toDoPersistenceManager.loadAllToDos()
                    completion(.success(toDos))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    private func fetchNetworkToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        toDoNetworkService.fetchAllToDos(resultQueue: .global(qos: .userInitiated)) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let toDosDto):
                completion(.success(toDosDto.map({ ToDo(dto: $0) })))
            }
        }
    }

    func createEmptyToDo(completion: @escaping (Result<ToDo, any Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let toDo = try self.toDoPersistenceManager.createEmptyToDo()

                completion(.success(toDo))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func toggleIsChecked(for toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                var updatedToDo = toDo
                updatedToDo.isCompleted.toggle()
                try self.toDoPersistenceManager.updateToDo(updatedToDo)

                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func deleteToDo(toDo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.toDoPersistenceManager.deleteToDo(id: toDo.id)

                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
