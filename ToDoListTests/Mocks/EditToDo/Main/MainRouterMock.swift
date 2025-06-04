//
//  MainRouterMock.swift
//  ToDoListTests
//
//  Created by Artemiy MIROTVORTSEV on 03.06.2025.
//

import Foundation
@testable import ToDoList

class MainRouterMock: MainRouterProtocol {
    var shownToDo: ToDo?
    func showEditToDoView(toDo: ToDo) {
        shownToDo = toDo
    }
}
