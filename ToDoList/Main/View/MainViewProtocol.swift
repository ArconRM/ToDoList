//
//  MainViewProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol MainViewProtocol: AnyObject, ErrorPresentable {
    func loadedAllToDos(_ toDos: [ToDo])
}
