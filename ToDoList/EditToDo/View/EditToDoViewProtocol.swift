//
//  EditToDoViewProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol EditToDoViewProtocol: AnyObject, ErrorPresentable {
    func configureWithItem(_ item: ToDo)
}
