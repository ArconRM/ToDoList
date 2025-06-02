//
//  MainInteractorProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol MainInteractorProtocol {
    func fetchToDos(completion:  @escaping (Result<[ToDo], Error>) -> Void)
}
