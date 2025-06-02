//
//  ToDo.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct ToDo: Identifiable {
    var id: Int
    var title: String
    var description: String
    var isCompleted: Bool
    var userId: Int
    var dateCreated: Date
}

extension ToDo {
    init(dto: ToDoDTO) {
        self.id = dto.id
        self.title = "Название"
        self.description = dto.todo
        self.isCompleted = dto.completed
        self.userId = dto.userId
        self.dateCreated = Date.now
    }
}
