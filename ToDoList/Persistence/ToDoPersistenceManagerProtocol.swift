//
//  ToDoPersistenceManagerProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol ToDoPersistenceManagerProtocol {
    func saveToDo(_ toDo: ToDo) throws
    func saveToDos(_ toDos: [ToDo]) throws
    func createEmptyToDo() throws -> ToDo
    func loadAllToDos() throws -> [ToDo]
    func updateToDo(_ updatedToDo: ToDo) throws
    func deleteToDo(id: Int) throws
}
