//
//  EditToDoPresenterProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol EditToDoPresenterProtocol: BasePresenterProtocol {
    var toDo: ToDo { get }
    func updateToDo(title: String?, description: String?)
    func viewWillDisappear()
}
