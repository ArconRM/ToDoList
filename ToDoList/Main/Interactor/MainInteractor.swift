//
//  MainInteractor.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
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
            var networkToDos: [ToDo] = []
            fetchNetworkToDos() { result in
                switch result {
                case .success(let toDos):
                    networkToDos = toDos
                    
                    do {
                        try self.toDoPersistenceManager.saveToDos(networkToDos)
                    } catch(let error) {
                        completion(.failure(error))
                    }
                    
                    print("fetched from network")
                    
                    self.wasLaunched = true
                    
                    completion(.success(networkToDos))
                    
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
            
        } else {
            do {
                let toDos = try toDoPersistenceManager.loadAllToDos()
                
                print("fetched from core data")
                
                completion(.success(toDos))
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }
    
    private func fetchNetworkToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        toDoNetworkService.fetchAllToDos(resultQueue: DispatchQueue.global(qos: .background)) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let toDosDto):
                completion(.success(toDosDto.map({ ToDo(dto: $0) })))
            }
        }
    }
}
