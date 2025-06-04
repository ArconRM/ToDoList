//
//  ToDo.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct ToDo: Identifiable, Equatable, Hashable {
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
        // Поскольку в апи они без названия
        self.title = "Без названия"
        self.description = dto.todo
        self.isCompleted = dto.completed
        self.userId = dto.userId
        self.dateCreated = Date.now
    }
}

extension ToDo {
    static var mocks: [ToDo] {
        return [
            .init(id: 1, title: "Mock", description: "Do something nice for someone you care about", isCompleted: false, userId: 152, dateCreated: Date()),
            .init(id: 2, title: "Mock", description: "Memorize a poem", isCompleted: true, userId: 13, dateCreated: Date()),
            .init(id: 3, title: "Mock", description: "Watch a classic movie", isCompleted: true, userId: 68, dateCreated: Date()),
            .init(id: 4, title: "Mock", description: "Watch a documentary", isCompleted: false, userId: 84, dateCreated: Date()),
            .init(id: 5, title: "Mock", description: "Invest in cryptocurrency", isCompleted: false, userId: 163, dateCreated: Date()),
            .init(id: 6, title: "Mock", description: "Contribute code or a monetary donation to an open-source software project", isCompleted: false, userId: 69, dateCreated: Date()),
            .init(id: 7, title: "Mock", description: "Solve a Rubik's cube", isCompleted: true, userId: 76, dateCreated: Date()),
        ]
    }
}
