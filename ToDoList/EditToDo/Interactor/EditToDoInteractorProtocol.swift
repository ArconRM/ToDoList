//
//  EditToDoInteractorProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol EditToDoInteractorProtocol {
    func updateToDo(toDo: ToDo, completion: @escaping (Result<Void, Error>) -> Void)
}
