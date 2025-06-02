//
//  MainInteractorProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol MainInteractorProtocol {
    func fetchSavedToDos(completion: @escaping (Result<[ToDo], Error>) -> Void)
    func fetchNetworkToDos(completion:  @escaping (Result<[ToDo], Error>) -> Void)
}
