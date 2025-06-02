//
//  MainPresenterProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol MainPresenterProtocol: BasePresenterProtocol {
    func fetchAllToDos()
    func toggleIsCompleted(for toDo: ToDo)
    func deleteToDo(toDo: ToDo)
    func showEditToDo(toDo: ToDo)
}
