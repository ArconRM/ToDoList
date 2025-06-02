//
//  MainInteractor.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct MainInteractor: MainInteractorProtocol {
    
    private let toDoNetworkService: ToDoNetworkServiceProtocol
    
    init(toDoNetworkService: ToDoNetworkServiceProtocol) {
        self.toDoNetworkService = toDoNetworkService
    }
    
    func fetchSavedToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        completion(.failure(NSError(domain: "", code: 0)))
    }
    
    func fetchNetworkToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        toDoNetworkService.fetchAllToDos(resultQueue: DispatchQueue.main) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                              
            case .success(let toDosDto):
                DispatchQueue.main.async {
                    completion(.success(toDosDto.map({ ToDo(dto: $0) })))
                }
            }
        }
    }
}
